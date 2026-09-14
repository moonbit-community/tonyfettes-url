#!/usr/bin/env python3
"""Generate MoonBit tests from WPT setters_tests.json for url package."""

import json
import sys
import urllib.request

URL = "https://raw.githubusercontent.com/web-platform-tests/wpt/master/url/resources/setters_tests.json"


def escape_moonbit_string(value):
    if value is None:
        return None
    result = []
    for c in value:
        code = ord(c)
        if c == "\\":
            result.append("\\\\")
        elif c == '"':
            result.append('\\"')
        elif c == "\n":
            result.append("\\n")
        elif c == "\r":
            result.append("\\r")
        elif c == "\t":
            result.append("\\t")
        elif code < 32 or code == 127 or code > 126:
            result.append(f"\\u{{{code:X}}}")
        else:
            result.append(c)
    return "".join(result)


FIELD_ORDER = [
    "href",
    "protocol",
    "username",
    "password",
    "host",
    "hostname",
    "port",
    "pathname",
    "search",
    "hash",
]


def setter_method(name):
    if name == "href":
        return "set_href"
    return f"set_{name}"


JS_VIEW_GETTERS = {"href", "protocol", "host", "hostname", "port", "pathname", "search", "hash"}


def getter_expr(name):
    """Expression yielding the JavaScript getter view of `url`."""
    if name in JS_VIEW_GETTERS:
        return f"js_{name}(url)"
    return f"url.{name}()"


HELPERS = '''///|
fn js_href(url : Url) -> String {
  url.to_string()
}

///|
fn js_protocol(url : Url) -> String {
  "\\{url.scheme()}:"
}

///|
fn js_hostname(url : Url) -> String {
  if url.host() is Some(host) {
    host.to_string()
  } else {
    ""
  }
}

///|
fn js_port(url : Url) -> String {
  if url.port() is Some(port) {
    port.to_string()
  } else {
    ""
  }
}

///|
fn js_host(url : Url) -> String {
  let hostname = js_hostname(url)
  if url.port() is Some(port) {
    "\\{hostname}:\\{port}"
  } else {
    hostname
  }
}

///|
fn js_pathname(url : Url) -> String {
  url.path().to_string()
}

///|
fn js_search(url : Url) -> String {
  match url.query() {
    Some("") | None => ""
    Some(query) => "?\\{query}"
  }
}

///|
fn js_hash(url : Url) -> String {
  match url.fragment() {
    Some("") | None => ""
    Some(fragment) => "#\\{fragment}"
  }
}
'''


def generate_single_test(setter, index, item):
    href = escape_moonbit_string(item["href"])
    new_value = escape_moonbit_string(item["new_value"])
    expected = item["expected"]

    lines = []
    lines.append("///|")
    lines.append(f'test "WPT setters {setter} #{index}" {{')
    lines.append(f'  let url = Url::parse("{href}")')
    lines.append(f'  url.{setter_method(setter)}("{new_value}")')

    for field in FIELD_ORDER:
        if field not in expected:
            continue
        expected_value = escape_moonbit_string(expected[field])
        lines.append(f'  assert_eq({getter_expr(field)}, "{expected_value}")')

    lines.append("}")
    return "\n".join(lines)


def main():
    print("Fetching WPT setters_tests.json...", file=sys.stderr)
    with urllib.request.urlopen(URL) as response:
        data = json.loads(response.read())

    output = []
    output.append("// Auto-generated from WPT setters_tests.json")
    output.append("// https://github.com/web-platform-tests/wpt/blob/master/url/resources/setters_tests.json")
    output.append("// Do not edit manually")
    output.append("//")
    output.append("// To regenerate: python3 scripts/generate_wpt_setters_tests.py > wpt_setters_wbtest.mbt")
    output.append("//")
    output.append("// These tests exercise the deprecated JavaScript-style setters, so they live")
    output.append("// in a white-box file where intra-package deprecation warnings are skipped.")
    output.append("// The expected values are the JavaScript getter views, computed here from the")
    output.append("// typed getters.")
    output.append("")
    output.append(HELPERS)

    for setter in FIELD_ORDER:
        if setter not in data:
            continue
        tests = data[setter]
        for index, item in enumerate(tests):
            output.append(generate_single_test(setter, index, item))
            output.append("")

    print("\n".join(output))


if __name__ == "__main__":
    main()
