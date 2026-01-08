#!/usr/bin/env python3
"""Generate MoonBit tests from WPT urltestdata.json"""

import json
import urllib.request
import re

URL = "https://raw.githubusercontent.com/web-platform-tests/wpt/master/url/resources/urltestdata.json"


def escape_moonbit_string(s):
    """Escape special characters for MoonBit string literals."""
    if s is None:
        return None
    result = []
    for c in s:
        code = ord(c)
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
            # Control characters - use unicode escape format
            result.append(f'\\u{{{code:04X}}}')
        else:
            result.append(c)
    return ''.join(result)


def sanitize_test_name(name):
    """Sanitize section name for use in test name."""
    # Remove or replace characters that might be problematic
    name = name.strip()
    # Keep only alphanumeric, spaces, and some punctuation
    name = re.sub(r'[^\w\s\-.,()]', '', name)
    # Collapse multiple spaces
    name = re.sub(r'\s+', ' ', name)
    return name[:60]  # Limit length


def format_string_option(value):
    """Format a string value as MoonBit Some/None option."""
    if value is None:
        return "None"
    escaped = escape_moonbit_string(value)
    return f'Some("{escaped}")'


def generate_test_block(name, tests):
    """Generate a test block for a section of tests."""
    lines = []
    lines.append(f'test "WPT: {name}" {{')
    lines.append('  let test_cases : Array[WptTestVector] = [')

    for test in tests:
        input_val = escape_moonbit_string(test.get('input', ''))
        base_val = test.get('base')
        is_failure = test.get('failure', False)

        # Format base
        if base_val is None:
            base_str = "None"
        else:
            base_str = f'Some("{escape_moonbit_string(base_val)}")'

        # Format expected: None for failures, Some(href) for success
        if is_failure:
            expected_str = "None"
        else:
            href = test.get('href', '')
            expected_str = f'Some("{escape_moonbit_string(href)}")'

        lines.append(f'    {{ input: "{input_val}", base: {base_str}, expected: {expected_str} }},')

    lines.append('  ]')
    lines.append('  for test_case in test_cases {')
    lines.append('    let { input, base, expected } = test_case')
    lines.append('    let result = match base {')
    lines.append('      Some(b) => {')
    lines.append('        let base_url = @url.Url::parse(b)')
    lines.append('        guard base_url is Some(base_url) else { continue }')
    lines.append('        @url.Url::parse(input, base=base_url)')
    lines.append('      }')
    lines.append('      None => @url.Url::parse(input)')
    lines.append('    }')
    lines.append('    match (result, expected) {')
    lines.append('      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)')
    lines.append('      (None, None) => ()')
    lines.append('      (Some(url), None) => {')
    lines.append('        fail("Expected failure but got: \{url.to_string().escape()}")')
    lines.append('      }')
    lines.append('      (None, Some(exp)) => {')
    lines.append('        fail("Expected success but parsing failed. Expected: \{exp.escape()}")')
    lines.append('      }')
    lines.append('    }')
    lines.append('  }')
    lines.append('}')

    return '\n'.join(lines)


def main():
    # Fetch test data
    print("Fetching test data from WPT...", file=__import__('sys').stderr)
    with urllib.request.urlopen(URL) as response:
        data = json.loads(response.read())

    print(f"Loaded {len(data)} entries", file=__import__('sys').stderr)

    # Generate test file
    output = []
    output.append("// Auto-generated from WPT urltestdata.json")
    output.append("// https://github.com/web-platform-tests/wpt/blob/master/url/resources/urltestdata.json")
    output.append("// Do not edit manually")
    output.append("")
    output.append("struct WptTestVector {")
    output.append("  input : String")
    output.append("  base : String?")
    output.append("  expected : String?")
    output.append("}")
    output.append("")

    # Group tests by section comments
    current_section = "General"
    section_tests = []
    test_count = 0
    section_count = 0
    used_names = {}  # Track used test names

    for item in data:
        if isinstance(item, str):
            # Comment - start new section
            if section_tests:
                name = get_unique_name(current_section, used_names)
                output.append(generate_test_block(name, section_tests))
                output.append("")
                section_count += 1
            current_section = item.lstrip("# ")
            section_tests = []
        else:
            # Test case
            section_tests.append(item)
            test_count += 1

    # Final section
    if section_tests:
        name = get_unique_name(current_section, used_names)
        output.append(generate_test_block(name, section_tests))
        section_count += 1

    print(f"Generated {section_count} test blocks with {test_count} test cases", file=__import__('sys').stderr)
    print('\n'.join(output))


def get_unique_name(section, used_names):
    """Get a unique test name, adding a suffix if needed."""
    sanitized = sanitize_test_name(section)
    if sanitized not in used_names:
        used_names[sanitized] = 1
        return sanitized
    else:
        used_names[sanitized] += 1
        return f"{sanitized} ({used_names[sanitized]})"


if __name__ == "__main__":
    main()
