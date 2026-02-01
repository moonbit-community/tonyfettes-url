#!/usr/bin/env python3
"""Generate MoonBit tests from WPT URLSearchParams test files.

Downloads actual WPT test files from GitHub and parses them to extract test cases.
"""

import json
import re
import sys
import urllib.request

WPT_BASE = "https://raw.githubusercontent.com/web-platform-tests/wpt/master/url"

# WPT test file URLs
WPT_FILES = {
    "constructor": f"{WPT_BASE}/urlsearchparams-constructor.any.js",
    "append": f"{WPT_BASE}/urlsearchparams-append.any.js",
    "delete": f"{WPT_BASE}/urlsearchparams-delete.any.js",
    "get": f"{WPT_BASE}/urlsearchparams-get.any.js",
    "getall": f"{WPT_BASE}/urlsearchparams-getall.any.js",
    "has": f"{WPT_BASE}/urlsearchparams-has.any.js",
    "set": f"{WPT_BASE}/urlsearchparams-set.any.js",
    "size": f"{WPT_BASE}/urlsearchparams-size.any.js",
    "sort": f"{WPT_BASE}/urlsearchparams-sort.any.js",
    "stringifier": f"{WPT_BASE}/urlsearchparams-stringifier.any.js",
}


def fetch_url(url):
    """Fetch content from URL."""
    print(f"Fetching {url}...", file=sys.stderr)
    with urllib.request.urlopen(url) as response:
        return response.read().decode('utf-8')


def escape_moonbit_string(s):
    """Escape special characters for MoonBit string literals.

    MoonBit requires full Unicode code points, not UTF-16 surrogate pairs.
    """
    if s is None:
        return None
    result = []
    i = 0
    while i < len(s):
        c = s[i]
        code = ord(c)

        # Check for surrogate pairs (JavaScript uses UTF-16)
        if 0xD800 <= code <= 0xDBFF and i + 1 < len(s):
            # High surrogate - check for low surrogate
            next_code = ord(s[i + 1])
            if 0xDC00 <= next_code <= 0xDFFF:
                # Combine surrogate pair into full code point
                full_code = 0x10000 + ((code - 0xD800) << 10) + (next_code - 0xDC00)
                result.append(f'\\u{{{full_code:04X}}}')
                i += 2
                continue

        if c == '\\':
            result.append('\\\\')
        elif c == '"':
            result.append('\\"')
        elif c == '\n':
            result.append('\\n')
        elif c == '\r':
            result.append('\\r')
        elif c == '\t':
            result.append('\\t')
        elif code < 32 or code == 127:
            result.append(f'\\u{{{code:04X}}}')
        elif code > 127:
            result.append(f'\\u{{{code:04X}}}')
        else:
            result.append(c)
        i += 1
    return ''.join(result)


def parse_js_string(s):
    """Parse a JavaScript string literal to Python string."""
    if s.startswith('"') and s.endswith('"'):
        s = s[1:-1]
    elif s.startswith("'") and s.endswith("'"):
        s = s[1:-1]

    result = []
    i = 0
    while i < len(s):
        if s[i] == '\\' and i + 1 < len(s):
            next_char = s[i + 1]
            if next_char == 'n':
                result.append('\n')
                i += 2
            elif next_char == 'r':
                result.append('\r')
                i += 2
            elif next_char == 't':
                result.append('\t')
                i += 2
            elif next_char == '0':
                result.append('\0')
                i += 2
            elif next_char == '\\':
                result.append('\\')
                i += 2
            elif next_char == '"':
                result.append('"')
                i += 2
            elif next_char == "'":
                result.append("'")
                i += 2
            elif next_char == 'u':
                # Unicode escape: \uXXXX
                if i + 5 < len(s):
                    hex_str = s[i+2:i+6]
                    try:
                        code = int(hex_str, 16)
                        result.append(chr(code))
                        i += 6
                    except ValueError:
                        result.append(s[i])
                        i += 1
                else:
                    result.append(s[i])
                    i += 1
            elif next_char == 'x':
                # Hex escape: \xXX
                if i + 3 < len(s):
                    hex_str = s[i+2:i+4]
                    try:
                        code = int(hex_str, 16)
                        result.append(chr(code))
                        i += 4
                    except ValueError:
                        result.append(s[i])
                        i += 1
                else:
                    result.append(s[i])
                    i += 1
            else:
                result.append(s[i])
                i += 1
        else:
            result.append(s[i])
            i += 1
    return ''.join(result)


def parse_sort_tests(content):
    """Parse sort tests which have a JSON array at the beginning."""
    # Find the JSON array at the start
    bracket_start = content.find('[')
    if bracket_start == -1:
        return []

    # Find matching end bracket
    depth = 0
    bracket_end = bracket_start
    for i, c in enumerate(content[bracket_start:], bracket_start):
        if c == '[':
            depth += 1
        elif c == ']':
            depth -= 1
            if depth == 0:
                bracket_end = i
                break

    json_str = content[bracket_start:bracket_end + 1]
    # Remove JavaScript comments
    json_str = re.sub(r'//.*$', '', json_str, flags=re.MULTILINE)

    try:
        data = json.loads(json_str)
        return data
    except json.JSONDecodeError as e:
        print(f"Failed to parse sort tests JSON: {e}", file=sys.stderr)
        return []


def generate_sort_tests(content):
    """Generate MoonBit tests for sort operations."""
    tests = []
    data = parse_sort_tests(content)

    for i, test_case in enumerate(data):
        input_str = test_case.get("input", "")
        output_pairs = test_case.get("output", [])

        input_escaped = escape_moonbit_string(input_str)
        pairs_str = ", ".join(
            f'("{escape_moonbit_string(pair[0])}", "{escape_moonbit_string(pair[1])}")'
            for pair in output_pairs
        )

        tests.append(f'''///|
test "WPT URLSearchParams sort #{i}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [{pairs_str}])
}}''')

    return tests


def extract_test_blocks(content):
    """Extract individual test() blocks from JavaScript content."""
    # Pattern to match test() function calls
    # This is a simplified parser - won't handle all edge cases
    blocks = []

    # Find all test( occurrences
    pattern = r'test\s*\(\s*(?:function\s*\(\s*\)|(?:\(\s*\)\s*=>))\s*\{'

    for match in re.finditer(pattern, content):
        start = match.start()
        # Find the matching closing brace and parenthesis
        brace_count = 1
        i = match.end()
        while i < len(content) and brace_count > 0:
            if content[i] == '{':
                brace_count += 1
            elif content[i] == '}':
                brace_count -= 1
            i += 1

        # Find the test description (string after the closing brace)
        rest = content[i:i+200]
        desc_match = re.search(r',\s*[\'"]([^\'"]+)[\'"]', rest)
        desc = desc_match.group(1) if desc_match else f"test_{len(blocks)}"

        block_content = content[match.end():i-1]
        blocks.append((desc, block_content))

    return blocks


def generate_constructor_tests(content):
    """Generate MoonBit tests for constructor."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Skip tests that use browser-specific APIs we can't test
        if 'DOMException' in block or 'FormData' in block:
            continue
        if 'URL(' in block and 'URLSearchParams' not in block.split('URL(')[0][-20:]:
            # Skip tests that primarily test URL integration
            continue

        # Extract simple assertions from the block
        # Pattern: new URLSearchParams('...') followed by assertions

        # Look for constructor calls and their assertions
        constructor_pattern = r"(?:params\s*=\s*)?new URLSearchParams\((['\"][^'\"]*['\"])\)"
        assert_equals_pattern = r"assert_equals\s*\(\s*params\s*\+\s*''\s*,\s*(['\"][^'\"]*['\"])\s*\)"
        assert_equals_pattern2 = r"assert_equals\s*\(\s*params\.toString\(\)\s*,\s*(['\"][^'\"]*['\"])\s*\)"
        get_pattern = r"assert_equals\s*\(\s*params\.get\((['\"][^'\"]*['\"])\)\s*,\s*(['\"][^'\"]*['\"])\s*\)"

        # Find all constructor positions to know where each one's scope ends
        const_matches = list(re.finditer(constructor_pattern, block))

        for i, const_match in enumerate(const_matches):
            input_str = parse_js_string(const_match.group(1))

            # Determine the end of this constructor's scope (until next constructor or end of block)
            scope_start = const_match.end()
            if i + 1 < len(const_matches):
                scope_end = const_matches[i + 1].start()
            else:
                scope_end = len(block)

            rest_of_block = block[scope_start:scope_end]

            # Check for params + '' assertion
            tostring_match = re.search(assert_equals_pattern, rest_of_block)
            if not tostring_match:
                tostring_match = re.search(assert_equals_pattern2, rest_of_block)

            if tostring_match:
                expected = parse_js_string(tostring_match.group(1))
                input_escaped = escape_moonbit_string(input_str)
                expected_escaped = escape_moonbit_string(expected)

                tests.append(f'''///|
test "WPT URLSearchParams constructor #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  assert_eq(params.to_string(), "{expected_escaped}")
}}''')
                test_idx += 1

            # Check for get assertions within this constructor's scope
            for get_match in re.finditer(get_pattern, rest_of_block):
                key = parse_js_string(get_match.group(1))
                value = parse_js_string(get_match.group(2))
                input_escaped = escape_moonbit_string(input_str)
                key_escaped = escape_moonbit_string(key)
                value_escaped = escape_moonbit_string(value)

                tests.append(f'''///|
test "WPT URLSearchParams constructor #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  assert_eq(params.get("{key_escaped}"), Some("{value_escaped}"))
}}''')
                test_idx += 1

    return tests


def generate_stringifier_tests(content):
    """Generate MoonBit tests for stringifier."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Skip URL integration tests
        if 'new URL(' in block:
            continue

        # Look for simple append/set followed by toString assertion
        # Pattern: params.append('name', 'value') followed by assert_equals(params + '', 'expected')

        append_pattern = r"params\.append\((['\"][^'\"]*['\"]),\s*(['\"][^'\"]*['\"])\)"
        delete_pattern = r"params\.delete\((['\"][^'\"]*['\"])\)"
        assert_pattern = r"assert_equals\s*\(\s*params\s*\+\s*''\s*,\s*(['\"][^'\"]*['\"])\s*\)"
        assert_pattern2 = r"assert_equals\s*\(\s*params\.toString\(\)\s*,\s*(['\"][^'\"]*['\"])\s*\)"
        # Detect when params is reassigned to a new URLSearchParams
        reassign_pattern = r"params\s*=\s*new URLSearchParams\("

        # Find sequences of operations followed by assertions
        # WPT tests are stateful - operations accumulate across assertions
        # BUT reset when params is reassigned
        lines = block.split('\n')
        operations = []

        for line in lines:
            # Check for reassignment first - this resets operations
            if re.search(reassign_pattern, line):
                operations = []
                continue  # Skip this line for operations

            append_match = re.search(append_pattern, line)
            if append_match:
                name = parse_js_string(append_match.group(1))
                value = parse_js_string(append_match.group(2))
                operations.append(('append', name, value))

            delete_match = re.search(delete_pattern, line)
            if delete_match:
                name = parse_js_string(delete_match.group(1))
                operations.append(('delete', name))

            assert_match = re.search(assert_pattern, line)
            if not assert_match:
                assert_match = re.search(assert_pattern2, line)

            if assert_match and operations:
                expected = parse_js_string(assert_match.group(1))
                expected_escaped = escape_moonbit_string(expected)

                op_lines = ['  let params = @url.UrlSearchParams::new()']
                for op in operations:
                    if op[0] == 'append':
                        name_escaped = escape_moonbit_string(op[1])
                        value_escaped = escape_moonbit_string(op[2])
                        op_lines.append(f'  params.append("{name_escaped}", "{value_escaped}")')
                    elif op[0] == 'delete':
                        name_escaped = escape_moonbit_string(op[1])
                        op_lines.append(f'  params.delete("{name_escaped}")')

                tests.append(f'''///|
test "WPT URLSearchParams stringifier #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
{chr(10).join(op_lines)}
  assert_eq(params.to_string(), "{expected_escaped}")
}}''')
                test_idx += 1
                # Don't reset operations - WPT tests accumulate state

    return tests


def generate_append_tests(content):
    """Generate MoonBit tests for append."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Look for append operations followed by toString assertions
        append_pattern = r"params\.append\((['\"][^'\"]*['\"]),\s*([^)]+)\)"
        assert_pattern = r"assert_equals\s*\(\s*params\s*\+\s*''\s*,\s*(['\"][^'\"]*['\"])\s*\)"

        lines = block.split('\n')
        operations = []

        for line in lines:
            append_match = re.search(append_pattern, line)
            if append_match:
                name = parse_js_string(append_match.group(1))
                value_raw = append_match.group(2).strip()
                # Handle numeric values and string values
                if value_raw.startswith(("'", '"')):
                    value = parse_js_string(value_raw)
                elif value_raw == 'null':
                    value = 'null'
                elif value_raw.isdigit():
                    value = value_raw
                else:
                    continue
                operations.append(('append', name, str(value)))

            assert_match = re.search(assert_pattern, line)
            if assert_match and operations:
                expected = parse_js_string(assert_match.group(1))
                expected_escaped = escape_moonbit_string(expected)

                op_lines = ['  let params = @url.UrlSearchParams::new()']
                for op in operations:
                    name_escaped = escape_moonbit_string(op[1])
                    value_escaped = escape_moonbit_string(op[2])
                    op_lines.append(f'  params.append("{name_escaped}", "{value_escaped}")')

                tests.append(f'''///|
test "WPT URLSearchParams append #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
{chr(10).join(op_lines)}
  assert_eq(params.to_string(), "{expected_escaped}")
}}''')
                test_idx += 1
                # Don't reset operations - WPT tests often have multiple assertions

    return tests


def generate_delete_tests(content):
    """Generate MoonBit tests for delete."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Skip URL-specific tests
        if 'new URL(' in block:
            continue

        # Pattern: new URLSearchParams('...'), params.delete('...'), assert_equals(params + '', '...')
        constructor_pattern = r"(?:params\s*=\s*)?new URLSearchParams\((['\"][^'\"]*['\"])\)"
        delete_pattern = r"params\.delete\(([^)]+)\)"
        assert_pattern = r"assert_equals\s*\(\s*params\s*\+\s*''\s*,\s*(['\"][^'\"]*['\"])\s*\)"
        assert_pattern2 = r"assert_equals\s*\(\s*params\.toString\(\)\s*,\s*(['\"][^'\"]*['\"])\s*\)"

        # Find all constructor positions to properly scope assertions
        const_matches = list(re.finditer(constructor_pattern, block))

        for i, const_match in enumerate(const_matches):
            current_input = parse_js_string(const_match.group(1))

            # Determine scope of this constructor
            scope_start = const_match.end()
            if i + 1 < len(const_matches):
                scope_end = const_matches[i + 1].start()
            else:
                scope_end = len(block)

            scope = block[scope_start:scope_end]

            # Find delete and assertion within this scope
            delete_match = re.search(delete_pattern, scope)
            if delete_match:
                args = delete_match.group(1).strip()
                # Parse delete arguments (can be one or two args)
                if ',' in args:
                    # Two-argument delete
                    parts = args.split(',', 1)
                    name = parse_js_string(parts[0].strip())
                    value_raw = parts[1].strip()
                    if value_raw == 'undefined':
                        delete_args = (name, None)
                    else:
                        value = parse_js_string(value_raw)
                        delete_args = (name, value)
                else:
                    name_raw = args.strip()
                    if name_raw == 'null':
                        name = 'null'
                    elif name_raw == 'undefined':
                        name = 'undefined'
                    else:
                        name = parse_js_string(name_raw)
                    delete_args = (name, None)

                # Look for assertion after the delete within this scope
                rest = scope[delete_match.end():]
                assert_match = re.search(assert_pattern, rest)
                if not assert_match:
                    assert_match = re.search(assert_pattern2, rest)

                if assert_match:
                    expected = parse_js_string(assert_match.group(1))
                    input_escaped = escape_moonbit_string(current_input)
                    expected_escaped = escape_moonbit_string(expected)
                    name_escaped = escape_moonbit_string(delete_args[0])

                    if delete_args[1] is not None:
                        value_escaped = escape_moonbit_string(delete_args[1])
                        delete_line = f'  params.delete("{name_escaped}", value="{value_escaped}")'
                    else:
                        delete_line = f'  params.delete("{name_escaped}")'

                    tests.append(f'''///|
test "WPT URLSearchParams delete #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
{delete_line}
  assert_eq(params.to_string(), "{expected_escaped}")
}}''')
                    test_idx += 1

    return tests


def generate_get_tests(content):
    """Generate MoonBit tests for get."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Pattern: new URLSearchParams('...'), assert_equals(params.get('...'), '...')
        constructor_pattern = r"(?:params\s*=\s*)?new URLSearchParams\((['\"][^'\"]*['\"])\)"
        # Match assert_equals(params.get('key'), 'value') or assert_equals(params.get('key'), null)
        get_pattern = r"assert_equals\s*\(\s*params\.get\((['\"][^'\"]*['\"])\)\s*,\s*(null|['\"][^'\"]*['\"])"

        lines = block.split('\n')
        current_input = None

        for line in lines:
            const_match = re.search(constructor_pattern, line)
            if const_match:
                current_input = parse_js_string(const_match.group(1))

            get_match = re.search(get_pattern, line)
            if get_match and current_input is not None:
                key = parse_js_string(get_match.group(1))
                value_raw = get_match.group(2).strip()

                input_escaped = escape_moonbit_string(current_input)
                key_escaped = escape_moonbit_string(key)

                if value_raw == 'null':
                    tests.append(f'''///|
test "WPT URLSearchParams get #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  assert_eq(params.get("{key_escaped}"), None)
}}''')
                else:
                    value = parse_js_string(value_raw)
                    value_escaped = escape_moonbit_string(value)
                    tests.append(f'''///|
test "WPT URLSearchParams get #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  assert_eq(params.get("{key_escaped}"), Some("{value_escaped}"))
}}''')
                test_idx += 1

    return tests


def generate_getall_tests(content):
    """Generate MoonBit tests for getAll."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Pattern: new URLSearchParams('...'), assert_array_equals(params.getAll('...'), [...])
        constructor_pattern = r"(?:params\s*=\s*)?new URLSearchParams\((['\"][^'\"]*['\"])\)"
        getall_pattern = r"assert_array_equals\s*\(\s*params\.getAll\((['\"][^'\"]*['\"])\)\s*,\s*\[([^\]]*)\]\s*\)"

        lines = block.split('\n')
        current_input = None

        for line in lines:
            const_match = re.search(constructor_pattern, line)
            if const_match:
                current_input = parse_js_string(const_match.group(1))

            getall_match = re.search(getall_pattern, line)
            if getall_match and current_input is not None:
                key = parse_js_string(getall_match.group(1))
                values_raw = getall_match.group(2).strip()

                input_escaped = escape_moonbit_string(current_input)
                key_escaped = escape_moonbit_string(key)

                if values_raw:
                    # Parse array values
                    values = []
                    for v in re.findall(r"['\"]([^'\"]*)['\"]", values_raw):
                        values.append(v)
                    values_str = ", ".join(f'"{escape_moonbit_string(v)}"' for v in values)
                else:
                    values_str = ""

                tests.append(f'''///|
test "WPT URLSearchParams getAll #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  assert_eq(params.get_all("{key_escaped}"), [{values_str}])
}}''')
                test_idx += 1

    return tests


def generate_has_tests(content):
    """Generate MoonBit tests for has."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Pattern: new URLSearchParams('...'), assert_true/false(params.has('...'))
        constructor_pattern = r"(?:params\s*=\s*)?new URLSearchParams\((['\"][^'\"]*['\"])\)"
        has_true_pattern = r"assert_true\s*\(\s*params\.has\(([^)]+)\)\s*\)"
        has_false_pattern = r"assert_false\s*\(\s*params\.has\(([^)]+)\)\s*\)"

        lines = block.split('\n')
        current_input = None

        for line in lines:
            const_match = re.search(constructor_pattern, line)
            if const_match:
                current_input = parse_js_string(const_match.group(1))

            # Check for assert_true(params.has(...))
            has_match = re.search(has_true_pattern, line)
            expected = True
            if not has_match:
                has_match = re.search(has_false_pattern, line)
                expected = False

            if has_match and current_input is not None:
                args = has_match.group(1).strip()

                # Parse has arguments (can be one or two args)
                if ',' in args:
                    parts = args.split(',', 1)
                    name_raw = parts[0].strip()
                    value_raw = parts[1].strip()

                    if name_raw == 'null':
                        name = 'null'
                    else:
                        name = parse_js_string(name_raw)

                    if value_raw == 'undefined':
                        has_value = None
                    elif value_raw.startswith(("'", '"')):
                        has_value = parse_js_string(value_raw)
                    else:
                        continue
                else:
                    if args == 'null':
                        name = 'null'
                    else:
                        name = parse_js_string(args)
                    has_value = None

                input_escaped = escape_moonbit_string(current_input)
                name_escaped = escape_moonbit_string(name)
                assert_fn = "assert_true" if expected else "assert_false"

                if has_value is not None:
                    value_escaped = escape_moonbit_string(has_value)
                    has_call = f'params.has("{name_escaped}", value="{value_escaped}")'
                else:
                    has_call = f'params.has("{name_escaped}")'

                tests.append(f'''///|
test "WPT URLSearchParams has #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  {assert_fn}({has_call})
}}''')
                test_idx += 1

    return tests


def generate_set_tests(content):
    """Generate MoonBit tests for set."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Pattern: new URLSearchParams('...'), params.set('...', '...'), assert_equals(params + '', '...')
        constructor_pattern = r"(?:params\s*=\s*)?new URLSearchParams\((['\"][^'\"]*['\"])\)"
        set_pattern = r"params\.set\((['\"][^'\"]*['\"])\s*,\s*([^)]+)\)"
        assert_pattern = r"assert_equals\s*\(\s*params\s*\+\s*''\s*,\s*(['\"][^'\"]*['\"])\s*\)"

        current_input = None

        for const_match in re.finditer(constructor_pattern, block):
            current_input = parse_js_string(const_match.group(1))
            rest = block[const_match.end():]

            set_match = re.search(set_pattern, rest)
            if set_match:
                name = parse_js_string(set_match.group(1))
                value_raw = set_match.group(2).strip()
                if value_raw.startswith(("'", '"')):
                    value = parse_js_string(value_raw)
                elif value_raw.isdigit():
                    value = value_raw
                else:
                    continue

                rest2 = rest[set_match.end():]
                assert_match = re.search(assert_pattern, rest2[:200])

                if assert_match:
                    expected = parse_js_string(assert_match.group(1))

                    input_escaped = escape_moonbit_string(current_input)
                    name_escaped = escape_moonbit_string(name)
                    value_escaped = escape_moonbit_string(str(value))
                    expected_escaped = escape_moonbit_string(expected)

                    tests.append(f'''///|
test "WPT URLSearchParams set #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  params.set("{name_escaped}", "{value_escaped}")
  assert_eq(params.to_string(), "{expected_escaped}")
}}''')
                    test_idx += 1

    return tests


def generate_size_tests(content):
    """Generate MoonBit tests for size."""
    tests = []
    blocks = extract_test_blocks(content)

    test_idx = 0
    for desc, block in blocks:
        # Skip URL-specific tests (they test URL.searchParams.size)
        if 'new URL(' in block:
            continue

        # Pattern: new URLSearchParams('...'), assert_equals(params.size, N)
        constructor_pattern = r'new URLSearchParams\((["\'][^"\']*["\'])\)'
        size_pattern = r"assert_equals\s*\(\s*params\.size\s*,\s*(\d+)\s*\)"

        const_match = re.search(constructor_pattern, block)
        if const_match:
            input_str = parse_js_string(const_match.group(1))

            size_match = re.search(size_pattern, block[const_match.end():const_match.end()+100])
            if size_match:
                expected_size = int(size_match.group(1))
                input_escaped = escape_moonbit_string(input_str)

                tests.append(f'''///|
test "WPT URLSearchParams size #{test_idx} - {escape_moonbit_string(desc[:40])}" {{
  let params = @url.UrlSearchParams::from_string("{input_escaped}")
  assert_eq(params.size(), {expected_size})
}}''')
                test_idx += 1

    return tests


def main():
    output = []

    # Header
    output.append("// Auto-generated from WPT URLSearchParams test files")
    output.append("// https://github.com/nicety/test/wpt/tree/master/url")
    output.append("// Do not edit manually")
    output.append("//")
    output.append("// To regenerate: python3 scripts/generate_wpt_urlsearchparams_tests.py > wpt_urlsearchparams_test.mbt")
    output.append("")

    all_tests = []
    total_count = 0

    # Fetch and process each test file
    for name, url in WPT_FILES.items():
        try:
            content = fetch_url(url)
        except Exception as e:
            print(f"Failed to fetch {name}: {e}", file=sys.stderr)
            continue

        if name == "sort":
            tests = generate_sort_tests(content)
        elif name == "constructor":
            tests = generate_constructor_tests(content)
        elif name == "stringifier":
            tests = generate_stringifier_tests(content)
        elif name == "append":
            tests = generate_append_tests(content)
        elif name == "delete":
            tests = generate_delete_tests(content)
        elif name == "get":
            tests = generate_get_tests(content)
        elif name == "getall":
            tests = generate_getall_tests(content)
        elif name == "has":
            tests = generate_has_tests(content)
        elif name == "set":
            tests = generate_set_tests(content)
        elif name == "size":
            tests = generate_size_tests(content)
        else:
            tests = []

        print(f"Generated {len(tests)} tests from {name}", file=sys.stderr)
        total_count += len(tests)
        all_tests.extend(tests)

    # Output all tests
    for test in all_tests:
        output.append(test)
        output.append("")

    print(f"Total: {total_count} tests generated", file=sys.stderr)
    print('\n'.join(output))


if __name__ == "__main__":
    main()
