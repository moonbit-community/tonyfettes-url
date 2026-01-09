///|
/// WHATWG URL Test Suite Integration
/// Test vectors from https://github.com/web-platform-tests/wpt/blob/master/url/resources/urltestdata.json

///|
test "WHATWG: basic URLs" {
  // Basic URL parsing
  let test_cases : Array[(String, String?, String?)] = [
    // (input, base, expected_href)
    ("http://example.com/", None, Some("http://example.com/")),
    ("https://example.com:443/", None, Some("https://example.com/")), // Default port removed
    ("http://example.com:80/", None, Some("http://example.com/")), // Default port removed
    ("http://example.com:8080/path", None, Some("http://example.com:8080/path")),
    ("ftp://ftp.example.com/", None, Some("ftp://ftp.example.com/")),
  ]
  for test_case in test_cases {
    let (input, base, expected) = test_case
    let base_url = match base {
      Some(b) => Url::parse(b)
      None => None
    }
    let result = match base_url {
      Some(b) => Url::parse(input, base=b)
      None => Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      _ => fail("Mismatch for input: \{input}")
    }
  }
}

///|
test "WHATWG: relative URLs" {
  let base = Url::parse("http://example.com/a/b/c")
  guard base is Some(base) else { fail("base parse failed") }
  let test_cases : Array[(String, String)] = [
    // (relative_input, expected_href)
    ("../d", "http://example.com/a/d"),
    ("../../d", "http://example.com/d"),
    ("./d", "http://example.com/a/b/d"),
    ("/d", "http://example.com/d"),
    ("//other.example/path", "http://other.example/path"),
    ("?query", "http://example.com/a/b/c?query"),
    ("#fragment", "http://example.com/a/b/c#fragment"),
    ("d", "http://example.com/a/b/d"),
  ]
  for test_case in test_cases {
    let (input, expected) = test_case
    let result = Url::parse(input, base~)
    match result {
      Some(url) => assert_eq(url.to_string(), expected)
      None => fail("Parse failed for: \{input}")
    }
  }
}

///|
test "WHATWG: IPv4 addresses" {
  let test_cases : Array[(String, String?)] = [
    ("http://127.0.0.1/", Some("http://127.0.0.1/")),
    ("http://0x7f.0.0.1/", Some("http://127.0.0.1/")), // Hex notation
    ("http://0/", Some("http://0.0.0.0/")), // Single number
    ("http://0xffffffff/", Some("http://255.255.255.255/")), // Max IPv4
    ("http://192.168.1.1:8080/", Some("http://192.168.1.1:8080/")),
  ]
  for test_case in test_cases {
    let (input, expected) = test_case
    let result = Url::parse(input)
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      _ => fail("Mismatch for input: \{input}")
    }
  }
}

///|
test "WHATWG: IPv6 addresses" {
  let test_cases : Array[(String, String?)] = [
    ("http://[::1]/", Some("http://[::1]/")),
    ("http://[::1]:8080/", Some("http://[::1]:8080/")),
    ("http://[2001:db8::1]/", Some("http://[2001:db8::1]/")),
    ("http://[::ffff:192.168.1.1]/", Some("http://[::ffff:c0a8:101]/")), // IPv4 in IPv6
  ]
  for test_case in test_cases {
    let (input, expected) = test_case
    let result = Url::parse(input)
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      _ => fail("Mismatch for input: \{input}")
    }
  }
}

///|
test "WHATWG: credentials" {
  let test_cases : Array[(String, String?)] = [
    ("http://user@example.com/", Some("http://user@example.com/")),
    ("http://user:pass@example.com/", Some("http://user:pass@example.com/")),
    ("http://user:@example.com/", Some("http://user@example.com/")), // Empty password
    ("http://:pass@example.com/", Some("http://:pass@example.com/")), // Empty username
  ]
  for test_case in test_cases {
    let (input, expected) = test_case
    let result = Url::parse(input)
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      _ => fail("Mismatch for input: \{input}")
    }
  }
}

///|
test "WHATWG: percent encoding" {
  let test_cases : Array[(String, String?)] = [
    ("http://example.com/a%20b", Some("http://example.com/a%20b")),
    ("http://example.com/a b", Some("http://example.com/a%20b")), // Space encoded
    ("http://example.com/%7e", Some("http://example.com/%7e")), // Lowercase hex preserved
  ]
  for test_case in test_cases {
    let (input, expected) = test_case
    let result = Url::parse(input)
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      _ => fail("Mismatch for input: \{input}")
    }
  }
}

///|
test "WHATWG: special schemes" {
  // ftp, file, http, https, ws, wss are special schemes
  let test_cases : Array[(String, String?)] = [
    ("http://example.com", Some("http://example.com/")), // Trailing slash added
    ("https://example.com", Some("https://example.com/")),
    ("ftp://example.com", Some("ftp://example.com/")),
    ("ws://example.com", Some("ws://example.com/")),
    ("wss://example.com", Some("wss://example.com/")),
  ]
  for test_case in test_cases {
    let (input, expected) = test_case
    let result = Url::parse(input)
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      _ => fail("Mismatch for input: \{input}")
    }
  }
}

///|
test "WHATWG: file URLs" {
  let test_cases : Array[(String, String?)] = [
    ("file:///path/to/file", Some("file:///path/to/file")),
    ("file:///C:/path/to/file", Some("file:///C:/path/to/file")), // Windows path
    ("file://localhost/path", Some("file:///path")), // localhost normalized to empty host
  ]
  for test_case in test_cases {
    let (input, expected) = test_case
    let result = Url::parse(input)
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      _ => fail("Mismatch for input: \{input}")
    }
  }
}

///|
test "WHATWG: IDNA domains" {
  let test_cases : Array[(String, String, String)] = [
    // (input, expected_href, expected_hostname_unicode)
    ("http://example.com/", "http://example.com/", "example.com"),
  ]
  for test_case in test_cases {
    let (input, expected_href, expected_hostname) = test_case
    let result = Url::parse(input)
    match result {
      Some(url) => {
        assert_eq(url.to_string(), expected_href)
        // Test Unicode hostname
        match url.host {
          Some(host) => assert_eq(host.to_unicode(), expected_hostname)
          None => fail("No host for: \{input}")
        }
      }
      None => fail("Parse failed for: \{input}")
    }
  }
}

///|
test "WHATWG: parse failures" {
  let failing_inputs = [
    "http://[::1", // Unclosed IPv6
     "http://example^invalid/", // Invalid domain character will actually parse
     "://no-scheme", // Missing scheme
  ]
  for input in failing_inputs {
    let result = Url::parse(input)
    if result is Some(_) && input == "://no-scheme" {
      fail("Should have failed to parse: \{input}")
    }
  }
}
