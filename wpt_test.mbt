// Auto-generated from WPT urltestdata.json
// https://github.com/web-platform-tests/wpt/blob/master/url/resources/urltestdata.json
// Do not edit manually

struct WptTestVector {
  input : String
  base : String?
  expected : String?
}

test "WPT: See ..README.md for a description of the format." {
  let test_cases : Array[WptTestVector] = [
    { input: "http://example\t.\norg", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/") },
    { input: "http://user:pass@foo:21/bar;par?b#c", base: Some("http://example.org/foo/bar"), expected: Some("http://user:pass@foo:21/bar;par?b#c") },
    { input: "https://test:@test", base: None, expected: Some("https://test@test/") },
    { input: "https://:@test", base: None, expected: Some("https://test/") },
    { input: "non-special://test:@test/x", base: None, expected: Some("non-special://test@test/x") },
    { input: "non-special://:@test/x", base: None, expected: Some("non-special://test/x") },
    { input: "http:foo.com", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/foo.com") },
    { input: "\t   :foo.com   \n", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:foo.com") },
    { input: " foo.com  ", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/foo.com") },
    { input: "a:\t foo.com", base: Some("http://example.org/foo/bar"), expected: Some("a: foo.com") },
    { input: "http://f:21/ b ? d # e ", base: Some("http://example.org/foo/bar"), expected: Some("http://f:21/%20b%20?%20d%20#%20e") },
    { input: "lolscheme:x x#x x", base: None, expected: Some("lolscheme:x x#x%20x") },
    { input: "http://f:/c", base: Some("http://example.org/foo/bar"), expected: Some("http://f/c") },
    { input: "http://f:0/c", base: Some("http://example.org/foo/bar"), expected: Some("http://f:0/c") },
    { input: "http://f:00000000000000/c", base: Some("http://example.org/foo/bar"), expected: Some("http://f:0/c") },
    { input: "http://f:00000000000000000000080/c", base: Some("http://example.org/foo/bar"), expected: Some("http://f/c") },
    { input: "http://f:b/c", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://f: /c", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://f:\n/c", base: Some("http://example.org/foo/bar"), expected: Some("http://f/c") },
    { input: "http://f:fifty-two/c", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://f:999999/c", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "non-special://f:999999/c", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://f: 21 / b ? d # e ", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar") },
    { input: "  \t", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar") },
    { input: ":foo.com/", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:foo.com/") },
    { input: ":foo.com\\", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:foo.com/") },
    { input: ":", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:") },
    { input: ":a", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:a") },
    { input: ":/", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:/") },
    { input: ":\\", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:/") },
    { input: ":#", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:#") },
    { input: "#", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar#") },
    { input: "#/", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar#/") },
    { input: "#\\", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar#\\") },
    { input: "#;?", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar#;?") },
    { input: "?", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar?") },
    { input: "/", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/") },
    { input: ":23", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:23") },
    { input: "/:23", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/:23") },
    { input: "\\x", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/x") },
    { input: "\\\\x\\hello", base: Some("http://example.org/foo/bar"), expected: Some("http://x/hello") },
    { input: "::", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/::") },
    { input: "::23", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/::23") },
    { input: "foo://", base: Some("http://example.org/foo/bar"), expected: Some("foo://") },
    { input: "http://a:b@c:29/d", base: Some("http://example.org/foo/bar"), expected: Some("http://a:b@c:29/d") },
    { input: "http::@c:29", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/:@c:29") },
    { input: "http://&a:foo(b]c@d:2/", base: Some("http://example.org/foo/bar"), expected: Some("http://&a:foo(b%5Dc@d:2/") },
    { input: "http://::@c@d:2", base: Some("http://example.org/foo/bar"), expected: Some("http://:%3A%40c@d:2/") },
    { input: "http://foo.com:b@d/", base: Some("http://example.org/foo/bar"), expected: Some("http://foo.com:b@d/") },
    { input: "http://foo.com/\\@", base: Some("http://example.org/foo/bar"), expected: Some("http://foo.com//@") },
    { input: "http:\\\\foo.com\\", base: Some("http://example.org/foo/bar"), expected: Some("http://foo.com/") },
    { input: "http:\\\\a\\b:c\\d@foo.com\\", base: Some("http://example.org/foo/bar"), expected: Some("http://a/b:c/d@foo.com/") },
    { input: "http://a:b@c\\", base: None, expected: Some("http://a:b@c/") },
    { input: "ws://a@b\\c", base: None, expected: Some("ws://a@b/c") },
    { input: "foo:/", base: Some("http://example.org/foo/bar"), expected: Some("foo:/") },
    { input: "foo:/bar.com/", base: Some("http://example.org/foo/bar"), expected: Some("foo:/bar.com/") },
    { input: "foo://///////", base: Some("http://example.org/foo/bar"), expected: Some("foo://///////") },
    { input: "foo://///////bar.com/", base: Some("http://example.org/foo/bar"), expected: Some("foo://///////bar.com/") },
    { input: "foo:////://///", base: Some("http://example.org/foo/bar"), expected: Some("foo:////://///") },
    { input: "c:/foo", base: Some("http://example.org/foo/bar"), expected: Some("c:/foo") },
    { input: "//foo/bar", base: Some("http://example.org/foo/bar"), expected: Some("http://foo/bar") },
    { input: "http://foo/path;a??e#f#g", base: Some("http://example.org/foo/bar"), expected: Some("http://foo/path;a??e#f#g") },
    { input: "http://foo/abcd?efgh?ijkl", base: Some("http://example.org/foo/bar"), expected: Some("http://foo/abcd?efgh?ijkl") },
    { input: "http://foo/abcd#foo?bar", base: Some("http://example.org/foo/bar"), expected: Some("http://foo/abcd#foo?bar") },
    { input: "[61:24:74]:98", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/[61:24:74]:98") },
    { input: "http:[61:27]/:foo", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/[61:27]/:foo") },
    { input: "http://[1::2]:3:4", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://2001::1", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://2001::1]", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://2001::1]:80", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://[2001::1]", base: Some("http://example.org/foo/bar"), expected: Some("http://[2001::1]/") },
    { input: "http://[::127.0.0.1]", base: Some("http://example.org/foo/bar"), expected: Some("http://[::7f00:1]/") },
    { input: "http://[::127.0.0.1.]", base: Some("http://example.org/foo/bar"), expected: None },
    { input: "http://[0:0:0:0:0:0:13.1.68.3]", base: Some("http://example.org/foo/bar"), expected: Some("http://[::d01:4403]/") },
    { input: "http://[2001::1]:80", base: Some("http://example.org/foo/bar"), expected: Some("http://[2001::1]/") },
    { input: "http:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/example.com/") },
    { input: "ftp:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("ftp://example.com/") },
    { input: "https:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("https://example.com/") },
    { input: "madeupscheme:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("madeupscheme:/example.com/") },
    { input: "file:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("file:///example.com/") },
    { input: "file://example:1/", base: None, expected: None },
    { input: "file://example:test/", base: None, expected: None },
    { input: "file://example%/", base: None, expected: None },
    { input: "file://[example]/", base: None, expected: None },
    { input: "ftps:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("ftps:/example.com/") },
    { input: "gopher:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("gopher:/example.com/") },
    { input: "ws:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("ws://example.com/") },
    { input: "wss:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("wss://example.com/") },
    { input: "data:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("data:/example.com/") },
    { input: "javascript:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("javascript:/example.com/") },
    { input: "mailto:/example.com/", base: Some("http://example.org/foo/bar"), expected: Some("mailto:/example.com/") },
    { input: "http:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/example.com/") },
    { input: "ftp:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("ftp://example.com/") },
    { input: "https:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("https://example.com/") },
    { input: "madeupscheme:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("madeupscheme:example.com/") },
    { input: "ftps:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("ftps:example.com/") },
    { input: "gopher:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("gopher:example.com/") },
    { input: "ws:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("ws://example.com/") },
    { input: "wss:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("wss://example.com/") },
    { input: "data:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("data:example.com/") },
    { input: "javascript:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("javascript:example.com/") },
    { input: "mailto:example.com/", base: Some("http://example.org/foo/bar"), expected: Some("mailto:example.com/") },
    { input: "/a/b/c", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/a/b/c") },
    { input: "/a/ /c", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/a/%20/c") },
    { input: "/a%2fc", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/a%2fc") },
    { input: "/a/%2f/c", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/a/%2f/c") },
    { input: "#β", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar#%CE%B2") },
    { input: "data:text/html,test#test", base: Some("http://example.org/foo/bar"), expected: Some("data:text/html,test#test") },
    { input: "tel:1234567890", base: Some("http://example.org/foo/bar"), expected: Some("tel:1234567890") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Based on httpsfelixfbecker.github.iowhatwg-url-custom-host-r" {
  let test_cases : Array[WptTestVector] = [
    { input: "ssh://example.com/foo/bar.git", base: Some("http://example.org/"), expected: Some("ssh://example.com/foo/bar.git") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Based on httptrac.webkit.orgbrowsertrunkLayoutTestsfasturlfi" {
  let test_cases : Array[WptTestVector] = [
    { input: "file:c:\\foo\\bar.html", base: Some("file:///tmp/mock/path"), expected: Some("file:///c:/foo/bar.html") },
    { input: "  File:c|////foo\\bar.html", base: Some("file:///tmp/mock/path"), expected: Some("file:///c:////foo/bar.html") },
    { input: "C|/foo/bar", base: Some("file:///tmp/mock/path"), expected: Some("file:///C:/foo/bar") },
    { input: "/C|\\foo\\bar", base: Some("file:///tmp/mock/path"), expected: Some("file:///C:/foo/bar") },
    { input: "//C|/foo/bar", base: Some("file:///tmp/mock/path"), expected: Some("file:///C:/foo/bar") },
    { input: "//server/file", base: Some("file:///tmp/mock/path"), expected: Some("file://server/file") },
    { input: "\\\\server\\file", base: Some("file:///tmp/mock/path"), expected: Some("file://server/file") },
    { input: "/\\server/file", base: Some("file:///tmp/mock/path"), expected: Some("file://server/file") },
    { input: "file:///foo/bar.txt", base: Some("file:///tmp/mock/path"), expected: Some("file:///foo/bar.txt") },
    { input: "file:///home/me", base: Some("file:///tmp/mock/path"), expected: Some("file:///home/me") },
    { input: "//", base: Some("file:///tmp/mock/path"), expected: Some("file:///") },
    { input: "///", base: Some("file:///tmp/mock/path"), expected: Some("file:///") },
    { input: "///test", base: Some("file:///tmp/mock/path"), expected: Some("file:///test") },
    { input: "file://test", base: Some("file:///tmp/mock/path"), expected: Some("file://test/") },
    { input: "file://localhost", base: Some("file:///tmp/mock/path"), expected: Some("file:///") },
    { input: "file://localhost/", base: Some("file:///tmp/mock/path"), expected: Some("file:///") },
    { input: "file://localhost/test", base: Some("file:///tmp/mock/path"), expected: Some("file:///test") },
    { input: "test", base: Some("file:///tmp/mock/path"), expected: Some("file:///tmp/mock/test") },
    { input: "file:test", base: Some("file:///tmp/mock/path"), expected: Some("file:///tmp/mock/test") },
    { input: "file:///w|m", base: None, expected: Some("file:///w|m") },
    { input: "file:///w||m", base: None, expected: Some("file:///w||m") },
    { input: "file:///w|/m", base: None, expected: Some("file:///w:/m") },
    { input: "file:C|/m/", base: None, expected: Some("file:///C:/m/") },
    { input: "file:C||/m/", base: None, expected: Some("file:///C||/m/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Based on httptrac.webkit.orgbrowsertrunkLayoutTestsfasturlsc" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://example.com/././foo", base: None, expected: Some("http://example.com/foo") },
    { input: "http://example.com/./.foo", base: None, expected: Some("http://example.com/.foo") },
    { input: "http://example.com/foo/.", base: None, expected: Some("http://example.com/foo/") },
    { input: "http://example.com/foo/./", base: None, expected: Some("http://example.com/foo/") },
    { input: "http://example.com/foo/bar/..", base: None, expected: Some("http://example.com/foo/") },
    { input: "http://example.com/foo/bar/../", base: None, expected: Some("http://example.com/foo/") },
    { input: "http://example.com/foo/..bar", base: None, expected: Some("http://example.com/foo/..bar") },
    { input: "http://example.com/foo/bar/../ton", base: None, expected: Some("http://example.com/foo/ton") },
    { input: "http://example.com/foo/bar/../ton/../../a", base: None, expected: Some("http://example.com/a") },
    { input: "http://example.com/foo/../../..", base: None, expected: Some("http://example.com/") },
    { input: "http://example.com/foo/../../../ton", base: None, expected: Some("http://example.com/ton") },
    { input: "http://example.com/foo/%2e", base: None, expected: Some("http://example.com/foo/") },
    { input: "http://example.com/foo/%2e%2", base: None, expected: Some("http://example.com/foo/%2e%2") },
    { input: "http://example.com/foo/%2e./%2e%2e/.%2e/%2e.bar", base: None, expected: Some("http://example.com/%2e.bar") },
    { input: "http://example.com////../..", base: None, expected: Some("http://example.com//") },
    { input: "http://example.com/foo/bar//../..", base: None, expected: Some("http://example.com/foo/") },
    { input: "http://example.com/foo/bar//..", base: None, expected: Some("http://example.com/foo/bar/") },
    { input: "http://example.com/foo", base: None, expected: Some("http://example.com/foo") },
    { input: "http://example.com/%20foo", base: None, expected: Some("http://example.com/%20foo") },
    { input: "http://example.com/foo%", base: None, expected: Some("http://example.com/foo%") },
    { input: "http://example.com/foo%2", base: None, expected: Some("http://example.com/foo%2") },
    { input: "http://example.com/foo%2zbar", base: None, expected: Some("http://example.com/foo%2zbar") },
    { input: "http://example.com/foo%2Â©zbar", base: None, expected: Some("http://example.com/foo%2%C3%82%C2%A9zbar") },
    { input: "http://example.com/foo%41%7a", base: None, expected: Some("http://example.com/foo%41%7a") },
    { input: "http://example.com/foo\t%91", base: None, expected: Some("http://example.com/foo%C2%91%91") },
    { input: "http://example.com/foo%00%51", base: None, expected: Some("http://example.com/foo%00%51") },
    { input: "http://example.com/(%28:%3A%29)", base: None, expected: Some("http://example.com/(%28:%3A%29)") },
    { input: "http://example.com/%3A%3a%3C%3c", base: None, expected: Some("http://example.com/%3A%3a%3C%3c") },
    { input: "http://example.com/foo\tbar", base: None, expected: Some("http://example.com/foobar") },
    { input: "http://example.com\\\\foo\\\\bar", base: None, expected: Some("http://example.com//foo//bar") },
    { input: "http://example.com/%7Ffp3%3Eju%3Dduvgw%3Dd", base: None, expected: Some("http://example.com/%7Ffp3%3Eju%3Dduvgw%3Dd") },
    { input: "http://example.com/@asdf%40", base: None, expected: Some("http://example.com/@asdf%40") },
    { input: "http://example.com/你好你好", base: None, expected: Some("http://example.com/%E4%BD%A0%E5%A5%BD%E4%BD%A0%E5%A5%BD") },
    { input: "http://example.com/‥/foo", base: None, expected: Some("http://example.com/%E2%80%A5/foo") },
    { input: "http://example.com/﻿/foo", base: None, expected: Some("http://example.com/%EF%BB%BF/foo") },
    { input: "http://example.com/‮/foo/‭/bar", base: None, expected: Some("http://example.com/%E2%80%AE/foo/%E2%80%AD/bar") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Based on httptrac.webkit.orgbrowsertrunkLayoutTestsfasturlsc (2)" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://www.google.com/foo?bar=baz#", base: None, expected: Some("http://www.google.com/foo?bar=baz#") },
    { input: "http://www.google.com/foo?bar=baz# »", base: None, expected: Some("http://www.google.com/foo?bar=baz#%20%C2%BB") },
    { input: "data:test# »", base: None, expected: Some("data:test#%20%C2%BB") },
    { input: "http://www.google.com", base: None, expected: Some("http://www.google.com/") },
    { input: "http://192.0x00A80001", base: None, expected: Some("http://192.168.0.1/") },
    { input: "http://www/foo%2Ehtml", base: None, expected: Some("http://www/foo%2Ehtml") },
    { input: "http://www/foo/%2E/html", base: None, expected: Some("http://www/foo/html") },
    { input: "http://user:pass@/", base: None, expected: None },
    { input: "http://%25DOMAIN:foobar@foodomain.com/", base: None, expected: Some("http://%25DOMAIN:foobar@foodomain.com/") },
    { input: "http:\\\\www.google.com\\foo", base: None, expected: Some("http://www.google.com/foo") },
    { input: "http://foo:80/", base: None, expected: Some("http://foo/") },
    { input: "http://foo:81/", base: None, expected: Some("http://foo:81/") },
    { input: "httpa://foo:80/", base: None, expected: Some("httpa://foo:80/") },
    { input: "http://foo:-80/", base: None, expected: None },
    { input: "https://foo:443/", base: None, expected: Some("https://foo/") },
    { input: "https://foo:80/", base: None, expected: Some("https://foo:80/") },
    { input: "ftp://foo:21/", base: None, expected: Some("ftp://foo/") },
    { input: "ftp://foo:80/", base: None, expected: Some("ftp://foo:80/") },
    { input: "gopher://foo:70/", base: None, expected: Some("gopher://foo:70/") },
    { input: "gopher://foo:443/", base: None, expected: Some("gopher://foo:443/") },
    { input: "ws://foo:80/", base: None, expected: Some("ws://foo/") },
    { input: "ws://foo:81/", base: None, expected: Some("ws://foo:81/") },
    { input: "ws://foo:443/", base: None, expected: Some("ws://foo:443/") },
    { input: "ws://foo:815/", base: None, expected: Some("ws://foo:815/") },
    { input: "wss://foo:80/", base: None, expected: Some("wss://foo:80/") },
    { input: "wss://foo:81/", base: None, expected: Some("wss://foo:81/") },
    { input: "wss://foo:443/", base: None, expected: Some("wss://foo/") },
    { input: "wss://foo:815/", base: None, expected: Some("wss://foo:815/") },
    { input: "http:/example.com/", base: None, expected: Some("http://example.com/") },
    { input: "ftp:/example.com/", base: None, expected: Some("ftp://example.com/") },
    { input: "https:/example.com/", base: None, expected: Some("https://example.com/") },
    { input: "madeupscheme:/example.com/", base: None, expected: Some("madeupscheme:/example.com/") },
    { input: "file:/example.com/", base: None, expected: Some("file:///example.com/") },
    { input: "ftps:/example.com/", base: None, expected: Some("ftps:/example.com/") },
    { input: "gopher:/example.com/", base: None, expected: Some("gopher:/example.com/") },
    { input: "ws:/example.com/", base: None, expected: Some("ws://example.com/") },
    { input: "wss:/example.com/", base: None, expected: Some("wss://example.com/") },
    { input: "data:/example.com/", base: None, expected: Some("data:/example.com/") },
    { input: "javascript:/example.com/", base: None, expected: Some("javascript:/example.com/") },
    { input: "mailto:/example.com/", base: None, expected: Some("mailto:/example.com/") },
    { input: "http:example.com/", base: None, expected: Some("http://example.com/") },
    { input: "ftp:example.com/", base: None, expected: Some("ftp://example.com/") },
    { input: "https:example.com/", base: None, expected: Some("https://example.com/") },
    { input: "madeupscheme:example.com/", base: None, expected: Some("madeupscheme:example.com/") },
    { input: "ftps:example.com/", base: None, expected: Some("ftps:example.com/") },
    { input: "gopher:example.com/", base: None, expected: Some("gopher:example.com/") },
    { input: "ws:example.com/", base: None, expected: Some("ws://example.com/") },
    { input: "wss:example.com/", base: None, expected: Some("wss://example.com/") },
    { input: "data:example.com/", base: None, expected: Some("data:example.com/") },
    { input: "javascript:example.com/", base: None, expected: Some("javascript:example.com/") },
    { input: "mailto:example.com/", base: None, expected: Some("mailto:example.com/") },
    { input: "https://example.com/aaa/bbb/%2e%2e?query", base: None, expected: Some("https://example.com/aaa/?query") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Based on httptrac.webkit.orgbrowsertrunkLayoutTestsfasturlse" {
  let test_cases : Array[WptTestVector] = [
    { input: "http:@www.example.com", base: None, expected: Some("http://www.example.com/") },
    { input: "http:/@www.example.com", base: None, expected: Some("http://www.example.com/") },
    { input: "http://@www.example.com", base: None, expected: Some("http://www.example.com/") },
    { input: "http:a:b@www.example.com", base: None, expected: Some("http://a:b@www.example.com/") },
    { input: "http:/a:b@www.example.com", base: None, expected: Some("http://a:b@www.example.com/") },
    { input: "http://a:b@www.example.com", base: None, expected: Some("http://a:b@www.example.com/") },
    { input: "http://@pple.com", base: None, expected: Some("http://pple.com/") },
    { input: "http::b@www.example.com", base: None, expected: Some("http://:b@www.example.com/") },
    { input: "http:/:b@www.example.com", base: None, expected: Some("http://:b@www.example.com/") },
    { input: "http://:b@www.example.com", base: None, expected: Some("http://:b@www.example.com/") },
    { input: "http:/:@/www.example.com", base: None, expected: None },
    { input: "http://user@/www.example.com", base: None, expected: None },
    { input: "http:@/www.example.com", base: None, expected: None },
    { input: "http:/@/www.example.com", base: None, expected: None },
    { input: "http://@/www.example.com", base: None, expected: None },
    { input: "https:@/www.example.com", base: None, expected: None },
    { input: "http:a:b@/www.example.com", base: None, expected: None },
    { input: "http:/a:b@/www.example.com", base: None, expected: None },
    { input: "http://a:b@/www.example.com", base: None, expected: None },
    { input: "http::@/www.example.com", base: None, expected: None },
    { input: "http:a:@www.example.com", base: None, expected: Some("http://a@www.example.com/") },
    { input: "http:/a:@www.example.com", base: None, expected: Some("http://a@www.example.com/") },
    { input: "http://a:@www.example.com", base: None, expected: Some("http://a@www.example.com/") },
    { input: "http://www.@pple.com", base: None, expected: Some("http://www.@pple.com/") },
    { input: "http:@:www.example.com", base: None, expected: None },
    { input: "http:/@:www.example.com", base: None, expected: None },
    { input: "http://@:www.example.com", base: None, expected: None },
    { input: "http://:@www.example.com", base: None, expected: Some("http://www.example.com/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Others" {
  let test_cases : Array[WptTestVector] = [
    { input: "/", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/") },
    { input: "/test.txt", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/test.txt") },
    { input: ".", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/") },
    { input: "..", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/") },
    { input: "test.txt", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/test.txt") },
    { input: "./test.txt", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/test.txt") },
    { input: "../test.txt", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/test.txt") },
    { input: "../aaa/test.txt", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/aaa/test.txt") },
    { input: "../../test.txt", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/test.txt") },
    { input: "中/test.txt", base: Some("http://www.example.com/test"), expected: Some("http://www.example.com/%E4%B8%AD/test.txt") },
    { input: "http://www.example2.com", base: Some("http://www.example.com/test"), expected: Some("http://www.example2.com/") },
    { input: "//www.example2.com", base: Some("http://www.example.com/test"), expected: Some("http://www.example2.com/") },
    { input: "file:...", base: Some("http://www.example.com/test"), expected: Some("file:///...") },
    { input: "file:..", base: Some("http://www.example.com/test"), expected: Some("file:///") },
    { input: "file:a", base: Some("http://www.example.com/test"), expected: Some("file:///a") },
    { input: "file:.", base: None, expected: Some("file:///") },
    { input: "file:.", base: Some("http://www.example.com/test"), expected: Some("file:///") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Basic canonicalization, uppercase should be converted to low" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://ExAmPlE.CoM", base: Some("http://other.com/"), expected: Some("http://example.com/") },
    { input: "http://example example.com", base: Some("http://other.com/"), expected: None },
    { input: "http://Goo%20 goo%7C|.com", base: Some("http://other.com/"), expected: None },
    { input: "http://[]", base: Some("http://other.com/"), expected: None },
    { input: "http://[:]", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: U3000 is mapped to U0020 (space) which is disallowed" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://GOO 　goo.com", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Other types of space (no-break, zero-width, zero-width-no-br" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://GOO​⁠﻿goo.com", base: Some("http://other.com/"), expected: Some("http://googoo.com/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Leading and trailing C0 control or space" {
  let test_cases : Array[WptTestVector] = [
    { input: "\u{0000}\u{001B}\u{0004}\u{0012} http://example.com/\u{001F} \r ", base: None, expected: Some("http://example.com/") },
    { input: "non-special:opaque  ", base: None, expected: Some("non-special:opaque") },
    { input: "non-special:opaque  ?hi", base: None, expected: Some("non-special:opaque %20?hi") },
    { input: "non-special:opaque  #hi", base: None, expected: Some("non-special:opaque %20#hi") },
    { input: "non-special:opaque  x?hi", base: None, expected: Some("non-special:opaque  x?hi") },
    { input: "non-special:opaque  x#hi", base: None, expected: Some("non-special:opaque  x#hi") },
    { input: "non-special:opaque \t\t  \t#hi", base: None, expected: Some("non-special:opaque  %20#hi") },
    { input: "non-special:opaque \t\t  #hi", base: None, expected: Some("non-special:opaque  %20#hi") },
    { input: "non-special:opaque\t\t  \r #hi", base: None, expected: Some("non-special:opaque  %20#hi") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Ideographic full stop (full-width period for Chinese, etc.) " {
  let test_cases : Array[WptTestVector] = [
    { input: "http://www.foo。bar.com", base: Some("http://other.com/"), expected: Some("http://www.foo.bar.com/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Invalid unicode characters should fail... UFDD0 is disallowe" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://﷐zyx.com", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: This is the same as previous but escaped" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://%ef%b7%90zyx.com", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: UFFFD" {
  let test_cases : Array[WptTestVector] = [
    { input: "https://�", base: None, expected: None },
    { input: "https://%EF%BF%BD", base: None, expected: None },
    { input: "https://x/�?�#�", base: None, expected: Some("https://x/%EF%BF%BD?%EF%BF%BD#%EF%BF%BD") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Domain is ASCII, but a label is invalid IDNA" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://a.b.c.xn--pokxncvks", base: None, expected: None },
    { input: "http://10.0.0.xn--pokxncvks", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: IDNA labels should be matched case-insensitively" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://a.b.c.XN--pokxncvks", base: None, expected: None },
    { input: "http://a.b.c.Xn--pokxncvks", base: None, expected: None },
    { input: "http://10.0.0.XN--pokxncvks", base: None, expected: None },
    { input: "http://10.0.0.xN--pokxncvks", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Test name prepping, fullwidth input should be converted to A" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://Ｇｏ.com", base: Some("http://other.com/"), expected: Some("http://go.com/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: URL spec forbids the following. httpswww.w3.orgBugsPublicsho" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://％４１.com", base: Some("http://other.com/"), expected: None },
    { input: "http://%ef%bc%85%ef%bc%94%ef%bc%91.com", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: ...00 in fullwidth should fail (also as escaped UTF-8 input)" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://％００.com", base: Some("http://other.com/"), expected: None },
    { input: "http://%ef%bc%85%ef%bc%90%ef%bc%90.com", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Basic IDN support, UTF-8 and UTF-16 input should be converte" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://你好你好", base: Some("http://other.com/"), expected: Some("http://xn--6qqa088eba/") },
    { input: "https://faß.ExAmPlE/", base: None, expected: Some("https://xn--fa-hia.example/") },
    { input: "sc://faß.ExAmPlE/", base: None, expected: Some("sc://fa%C3%9F.ExAmPlE/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Invalid escaped characters should fail and the percents shou" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://%zz%66%a.com", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: If we get an invalid character that has been escaped." {
  let test_cases : Array[WptTestVector] = [
    { input: "http://%25", base: Some("http://other.com/"), expected: None },
    { input: "http://hello%00", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Escaped numbers should be treated like IP addresses if they " {
  let test_cases : Array[WptTestVector] = [
    { input: "http://%30%78%63%30%2e%30%32%35%30.01", base: Some("http://other.com/"), expected: Some("http://192.168.0.1/") },
    { input: "http://%30%78%63%30%2e%30%32%35%30.01%2e", base: Some("http://other.com/"), expected: Some("http://192.168.0.1/") },
    { input: "http://192.168.0.257", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Invalid escaping in hosts causes failure" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://%3g%78%63%30%2e%30%32%35%30%2E.01", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: A space in a host causes failure" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://192.168.0.1 hello", base: Some("http://other.com/"), expected: None },
    { input: "https://x x:12", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Fullwidth and escaped UTF-8 fullwidth should still be treate" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://０Ｘｃ０．０２５０．０１", base: Some("http://other.com/"), expected: Some("http://192.168.0.1/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Domains with empty labels" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://./", base: None, expected: Some("http://./") },
    { input: "http://../", base: None, expected: Some("http://../") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Non-special domains with empty labels" {
  let test_cases : Array[WptTestVector] = [
    { input: "h://.", base: None, expected: Some("h://.") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Broken IPv6" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://[www.google.com]/", base: None, expected: None },
    { input: "http://[google.com]", base: Some("http://other.com/"), expected: None },
    { input: "http://[::1.2.3.4x]", base: Some("http://other.com/"), expected: None },
    { input: "http://[::1.2.3.]", base: Some("http://other.com/"), expected: None },
    { input: "http://[::1.2.]", base: Some("http://other.com/"), expected: None },
    { input: "http://[::.1.2]", base: Some("http://other.com/"), expected: None },
    { input: "http://[::1.]", base: Some("http://other.com/"), expected: None },
    { input: "http://[::.1]", base: Some("http://other.com/"), expected: None },
    { input: "http://[::%31]", base: Some("http://other.com/"), expected: None },
    { input: "http://%5B::1]", base: Some("http://other.com/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Misc Unicode" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://foo:💩@example.com/bar", base: Some("http://other.com/"), expected: Some("http://foo:%F0%9F%92%A9@example.com/bar") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: resolving a fragment against any scheme succeeds" {
  let test_cases : Array[WptTestVector] = [
    { input: "#", base: Some("test:test"), expected: Some("test:test#") },
    { input: "#x", base: Some("mailto:x@x.com"), expected: Some("mailto:x@x.com#x") },
    { input: "#x", base: Some("data:,"), expected: Some("data:,#x") },
    { input: "#x", base: Some("about:blank"), expected: Some("about:blank#x") },
    { input: "#x:y", base: Some("about:blank"), expected: Some("about:blank#x:y") },
    { input: "#", base: Some("test:test?test"), expected: Some("test:test?test#") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: multiple in authority state" {
  let test_cases : Array[WptTestVector] = [
    { input: "https://@test@test@example:800/", base: Some("http://doesnotmatter/"), expected: Some("https://%40test%40test@example:800/") },
    { input: "https://@@@example", base: Some("http://doesnotmatter/"), expected: Some("https://%40%40@example/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: non-az-09 characters" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://`{}:`{}@h/`{}?`{}", base: Some("http://doesnotmatter/"), expected: Some("http://%60%7B%7D:%60%7B%7D@h/%60%7B%7D?`{}") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: byte is and url is special" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://host/?'", base: None, expected: Some("http://host/?%27") },
    { input: "notspecial://host/?'", base: None, expected: Some("notspecial://host/?'") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Credentials in base" {
  let test_cases : Array[WptTestVector] = [
    { input: "/some/path", base: Some("http://user@example.org/smth"), expected: Some("http://user@example.org/some/path") },
    { input: "", base: Some("http://user:pass@example.org:21/smth"), expected: Some("http://user:pass@example.org:21/smth") },
    { input: "/some/path", base: Some("http://user:pass@example.org:21/smth"), expected: Some("http://user:pass@example.org:21/some/path") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: a set of tests designed by zcorpan for relative URLs with un" {
  let test_cases : Array[WptTestVector] = [
    { input: "i", base: Some("sc:sd"), expected: None },
    { input: "i", base: Some("sc:sd/sd"), expected: None },
    { input: "i", base: Some("sc:/pa/pa"), expected: Some("sc:/pa/i") },
    { input: "i", base: Some("sc://ho/pa"), expected: Some("sc://ho/i") },
    { input: "i", base: Some("sc:///pa/pa"), expected: Some("sc:///pa/i") },
    { input: "../i", base: Some("sc:sd"), expected: None },
    { input: "../i", base: Some("sc:sd/sd"), expected: None },
    { input: "../i", base: Some("sc:/pa/pa"), expected: Some("sc:/i") },
    { input: "../i", base: Some("sc://ho/pa"), expected: Some("sc://ho/i") },
    { input: "../i", base: Some("sc:///pa/pa"), expected: Some("sc:///i") },
    { input: "/i", base: Some("sc:sd"), expected: None },
    { input: "/i", base: Some("sc:sd/sd"), expected: None },
    { input: "/i", base: Some("sc:/pa/pa"), expected: Some("sc:/i") },
    { input: "/i", base: Some("sc://ho/pa"), expected: Some("sc://ho/i") },
    { input: "/i", base: Some("sc:///pa/pa"), expected: Some("sc:///i") },
    { input: "?i", base: Some("sc:sd"), expected: None },
    { input: "?i", base: Some("sc:sd/sd"), expected: None },
    { input: "?i", base: Some("sc:/pa/pa"), expected: Some("sc:/pa/pa?i") },
    { input: "?i", base: Some("sc://ho/pa"), expected: Some("sc://ho/pa?i") },
    { input: "?i", base: Some("sc:///pa/pa"), expected: Some("sc:///pa/pa?i") },
    { input: "#i", base: Some("sc:sd"), expected: Some("sc:sd#i") },
    { input: "#i", base: Some("sc:sd/sd"), expected: Some("sc:sd/sd#i") },
    { input: "#i", base: Some("sc:/pa/pa"), expected: Some("sc:/pa/pa#i") },
    { input: "#i", base: Some("sc://ho/pa"), expected: Some("sc://ho/pa#i") },
    { input: "#i", base: Some("sc:///pa/pa"), expected: Some("sc:///pa/pa#i") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: make sure that relative URL logic works on known typically n" {
  let test_cases : Array[WptTestVector] = [
    { input: "about:/../", base: None, expected: Some("about:/") },
    { input: "data:/../", base: None, expected: Some("data:/") },
    { input: "javascript:/../", base: None, expected: Some("javascript:/") },
    { input: "mailto:/../", base: None, expected: Some("mailto:/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: unknown schemes and their hosts" {
  let test_cases : Array[WptTestVector] = [
    { input: "sc://ñ.test/", base: None, expected: Some("sc://%C3%B1.test/") },
    { input: "sc://%/", base: None, expected: Some("sc://%/") },
    { input: "sc://@/", base: None, expected: None },
    { input: "sc://te@s:t@/", base: None, expected: None },
    { input: "sc://:/", base: None, expected: None },
    { input: "sc://:12/", base: None, expected: None },
    { input: "x", base: Some("sc://ñ"), expected: Some("sc://%C3%B1/x") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: unknown schemes and backslashes" {
  let test_cases : Array[WptTestVector] = [
    { input: "sc:\\../", base: None, expected: Some("sc:\\../") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: unknown scheme with path looking like a password" {
  let test_cases : Array[WptTestVector] = [
    { input: "sc::a@example.net", base: None, expected: Some("sc::a@example.net") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: unknown scheme with bogus percent-encoding" {
  let test_cases : Array[WptTestVector] = [
    { input: "wow:%NBD", base: None, expected: Some("wow:%NBD") },
    { input: "wow:%1G", base: None, expected: Some("wow:%1G") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: unknown scheme with non-URL characters" {
  let test_cases : Array[WptTestVector] = [
    { input: "wow:￿", base: None, expected: Some("wow:%EF%BF%BF") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Forbidden host code points" {
  let test_cases : Array[WptTestVector] = [
    { input: "sc://a\u{0000}b/", base: None, expected: None },
    { input: "sc://a b/", base: None, expected: None },
    { input: "sc://a<b", base: None, expected: None },
    { input: "sc://a>b", base: None, expected: None },
    { input: "sc://a[b/", base: None, expected: None },
    { input: "sc://a\\b/", base: None, expected: None },
    { input: "sc://a]b/", base: None, expected: None },
    { input: "sc://a^b", base: None, expected: None },
    { input: "sc://a|b/", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Forbidden host codepoints tabs and newlines are removed duri" {
  let test_cases : Array[WptTestVector] = [
    { input: "foo://ho\tst/", base: None, expected: Some("foo://host/") },
    { input: "foo://ho\nst/", base: None, expected: Some("foo://host/") },
    { input: "foo://ho\rst/", base: None, expected: Some("foo://host/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Forbidden domain code-points" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://a\u{0000}b/", base: None, expected: None },
    { input: "http://a\u{0001}b/", base: None, expected: None },
    { input: "http://a\u{0002}b/", base: None, expected: None },
    { input: "http://a\u{0003}b/", base: None, expected: None },
    { input: "http://a\u{0004}b/", base: None, expected: None },
    { input: "http://a\u{0005}b/", base: None, expected: None },
    { input: "http://a\u{0006}b/", base: None, expected: None },
    { input: "http://a\u{0007}b/", base: None, expected: None },
    { input: "http://a\u{0008}b/", base: None, expected: None },
    { input: "http://a\u{000B}b/", base: None, expected: None },
    { input: "http://a\u{000C}b/", base: None, expected: None },
    { input: "http://a\u{000E}b/", base: None, expected: None },
    { input: "http://a\u{000F}b/", base: None, expected: None },
    { input: "http://a\u{0010}b/", base: None, expected: None },
    { input: "http://a\u{0011}b/", base: None, expected: None },
    { input: "http://a\u{0012}b/", base: None, expected: None },
    { input: "http://a\u{0013}b/", base: None, expected: None },
    { input: "http://a\u{0014}b/", base: None, expected: None },
    { input: "http://a\u{0015}b/", base: None, expected: None },
    { input: "http://a\u{0016}b/", base: None, expected: None },
    { input: "http://a\u{0017}b/", base: None, expected: None },
    { input: "http://a\u{0018}b/", base: None, expected: None },
    { input: "http://a\u{0019}b/", base: None, expected: None },
    { input: "http://a\u{001A}b/", base: None, expected: None },
    { input: "http://a\u{001B}b/", base: None, expected: None },
    { input: "http://a\u{001C}b/", base: None, expected: None },
    { input: "http://a\u{001D}b/", base: None, expected: None },
    { input: "http://a\u{001E}b/", base: None, expected: None },
    { input: "http://a\u{001F}b/", base: None, expected: None },
    { input: "http://a b/", base: None, expected: None },
    { input: "http://a%b/", base: None, expected: None },
    { input: "http://a<b", base: None, expected: None },
    { input: "http://a>b", base: None, expected: None },
    { input: "http://a[b/", base: None, expected: None },
    { input: "http://a]b/", base: None, expected: None },
    { input: "http://a^b", base: None, expected: None },
    { input: "http://a|b/", base: None, expected: None },
    { input: "http://a\u{007F}b/", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Forbidden domain codepoints tabs and newlines are removed du" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://ho\tst/", base: None, expected: Some("http://host/") },
    { input: "http://ho\nst/", base: None, expected: Some("http://host/") },
    { input: "http://ho\rst/", base: None, expected: Some("http://host/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Encoded forbidden domain codepoints in special URLs" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://ho%00st/", base: None, expected: None },
    { input: "http://ho%01st/", base: None, expected: None },
    { input: "http://ho%02st/", base: None, expected: None },
    { input: "http://ho%03st/", base: None, expected: None },
    { input: "http://ho%04st/", base: None, expected: None },
    { input: "http://ho%05st/", base: None, expected: None },
    { input: "http://ho%06st/", base: None, expected: None },
    { input: "http://ho%07st/", base: None, expected: None },
    { input: "http://ho%08st/", base: None, expected: None },
    { input: "http://ho%09st/", base: None, expected: None },
    { input: "http://ho%0Ast/", base: None, expected: None },
    { input: "http://ho%0Bst/", base: None, expected: None },
    { input: "http://ho%0Cst/", base: None, expected: None },
    { input: "http://ho%0Dst/", base: None, expected: None },
    { input: "http://ho%0Est/", base: None, expected: None },
    { input: "http://ho%0Fst/", base: None, expected: None },
    { input: "http://ho%10st/", base: None, expected: None },
    { input: "http://ho%11st/", base: None, expected: None },
    { input: "http://ho%12st/", base: None, expected: None },
    { input: "http://ho%13st/", base: None, expected: None },
    { input: "http://ho%14st/", base: None, expected: None },
    { input: "http://ho%15st/", base: None, expected: None },
    { input: "http://ho%16st/", base: None, expected: None },
    { input: "http://ho%17st/", base: None, expected: None },
    { input: "http://ho%18st/", base: None, expected: None },
    { input: "http://ho%19st/", base: None, expected: None },
    { input: "http://ho%1Ast/", base: None, expected: None },
    { input: "http://ho%1Bst/", base: None, expected: None },
    { input: "http://ho%1Cst/", base: None, expected: None },
    { input: "http://ho%1Dst/", base: None, expected: None },
    { input: "http://ho%1Est/", base: None, expected: None },
    { input: "http://ho%1Fst/", base: None, expected: None },
    { input: "http://ho%20st/", base: None, expected: None },
    { input: "http://ho%23st/", base: None, expected: None },
    { input: "http://ho%25st/", base: None, expected: None },
    { input: "http://ho%2Fst/", base: None, expected: None },
    { input: "http://ho%3Ast/", base: None, expected: None },
    { input: "http://ho%3Cst/", base: None, expected: None },
    { input: "http://ho%3Est/", base: None, expected: None },
    { input: "http://ho%3Fst/", base: None, expected: None },
    { input: "http://ho%40st/", base: None, expected: None },
    { input: "http://ho%5Bst/", base: None, expected: None },
    { input: "http://ho%5Cst/", base: None, expected: None },
    { input: "http://ho%5Dst/", base: None, expected: None },
    { input: "http://ho%7Cst/", base: None, expected: None },
    { input: "http://ho%7Fst/", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Allowed hostdomain code points" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://!\"$&'()*+,-.;=_`{}~/", base: None, expected: Some("http://!\"$&'()*+,-.;=_`{}~/") },
    { input: "sc://\u{0001}\u{0002}\u{0003}\u{0004}\u{0005}\u{0006}\u{0007}\u{0008}\u{000B}\u{000C}\u{000E}\u{000F}\u{0010}\u{0011}\u{0012}\u{0013}\u{0014}\u{0015}\u{0016}\u{0017}\u{0018}\u{0019}\u{001A}\u{001B}\u{001C}\u{001D}\u{001E}\u{001F}\u{007F}!\"$%&'()*+,-.;=_`{}~/", base: None, expected: Some("sc://%01%02%03%04%05%06%07%08%0B%0C%0E%0F%10%11%12%13%14%15%16%17%18%19%1A%1B%1C%1D%1E%1F%7F!\"$%&'()*+,-.;=_`{}~/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Hosts and percent-encoding" {
  let test_cases : Array[WptTestVector] = [
    { input: "ftp://example.com%80/", base: None, expected: None },
    { input: "ftp://example.com%A0/", base: None, expected: None },
    { input: "https://example.com%80/", base: None, expected: None },
    { input: "https://example.com%A0/", base: None, expected: None },
    { input: "ftp://%e2%98%83", base: None, expected: Some("ftp://xn--n3h/") },
    { input: "https://%e2%98%83", base: None, expected: Some("https://xn--n3h/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: tests from jsdomwhatwg-url designed for code coverage" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://127.0.0.1:10100/relative_import.html", base: None, expected: Some("http://127.0.0.1:10100/relative_import.html") },
    { input: "http://facebook.com/?foo=%7B%22abc%22", base: None, expected: Some("http://facebook.com/?foo=%7B%22abc%22") },
    { input: "https://localhost:3000/jqueryui@1.2.3", base: None, expected: Some("https://localhost:3000/jqueryui@1.2.3") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: tabLFCR" {
  let test_cases : Array[WptTestVector] = [
    { input: "h\tt\nt\rp://h\to\ns\rt:9\t0\n0\r0/p\ta\nt\rh?q\tu\ne\rry#f\tr\na\rg", base: None, expected: Some("http://host:9000/path?query#frag") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Stringification of URL.searchParams" {
  let test_cases : Array[WptTestVector] = [
    { input: "?a=b&c=d", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar?a=b&c=d") },
    { input: "??a=b&c=d", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar??a=b&c=d") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Scheme only" {
  let test_cases : Array[WptTestVector] = [
    { input: "http:", base: Some("http://example.org/foo/bar"), expected: Some("http://example.org/foo/bar") },
    { input: "http:", base: Some("https://example.org/foo/bar"), expected: None },
    { input: "sc:", base: Some("https://example.org/foo/bar"), expected: Some("sc:") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Percent encoding of fragments" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://foo.bar/baz?qux#foo\u{0008}bar", base: None, expected: Some("http://foo.bar/baz?qux#foo%08bar") },
    { input: "http://foo.bar/baz?qux#foo\"bar", base: None, expected: Some("http://foo.bar/baz?qux#foo%22bar") },
    { input: "http://foo.bar/baz?qux#foo<bar", base: None, expected: Some("http://foo.bar/baz?qux#foo%3Cbar") },
    { input: "http://foo.bar/baz?qux#foo>bar", base: None, expected: Some("http://foo.bar/baz?qux#foo%3Ebar") },
    { input: "http://foo.bar/baz?qux#foo`bar", base: None, expected: Some("http://foo.bar/baz?qux#foo%60bar") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: IPv4 parsing (via httpsgithub.comnodejsnodepull10317)" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://1.2.3.4/", base: Some("http://other.com/"), expected: Some("http://1.2.3.4/") },
    { input: "http://1.2.3.4./", base: Some("http://other.com/"), expected: Some("http://1.2.3.4/") },
    { input: "http://192.168.257", base: Some("http://other.com/"), expected: Some("http://192.168.1.1/") },
    { input: "http://192.168.257.", base: Some("http://other.com/"), expected: Some("http://192.168.1.1/") },
    { input: "http://192.168.257.com", base: Some("http://other.com/"), expected: Some("http://192.168.257.com/") },
    { input: "http://256", base: Some("http://other.com/"), expected: Some("http://0.0.1.0/") },
    { input: "http://256.com", base: Some("http://other.com/"), expected: Some("http://256.com/") },
    { input: "http://999999999", base: Some("http://other.com/"), expected: Some("http://59.154.201.255/") },
    { input: "http://999999999.", base: Some("http://other.com/"), expected: Some("http://59.154.201.255/") },
    { input: "http://999999999.com", base: Some("http://other.com/"), expected: Some("http://999999999.com/") },
    { input: "http://10000000000", base: Some("http://other.com/"), expected: None },
    { input: "http://10000000000.com", base: Some("http://other.com/"), expected: Some("http://10000000000.com/") },
    { input: "http://4294967295", base: Some("http://other.com/"), expected: Some("http://255.255.255.255/") },
    { input: "http://4294967296", base: Some("http://other.com/"), expected: None },
    { input: "http://0xffffffff", base: Some("http://other.com/"), expected: Some("http://255.255.255.255/") },
    { input: "http://0xffffffff1", base: Some("http://other.com/"), expected: None },
    { input: "http://256.256.256.256", base: Some("http://other.com/"), expected: None },
    { input: "https://0x.0x.0", base: None, expected: Some("https://0.0.0.0/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: More IPv4 parsing (via httpsgithub.comjsdomwhatwg-urlissues9" {
  let test_cases : Array[WptTestVector] = [
    { input: "https://0x100000000/test", base: None, expected: None },
    { input: "https://256.0.0.1/test", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: file URLs containing percent-encoded Windows drive letters (" {
  let test_cases : Array[WptTestVector] = [
    { input: "file:///C%3A/", base: None, expected: Some("file:///C%3A/") },
    { input: "file:///C%7C/", base: None, expected: Some("file:///C%7C/") },
    { input: "file://%43%3A", base: None, expected: None },
    { input: "file://%43%7C", base: None, expected: None },
    { input: "file://%43|", base: None, expected: None },
    { input: "file://C%7C", base: None, expected: None },
    { input: "file://%43%7C/", base: None, expected: None },
    { input: "https://%43%7C/", base: None, expected: None },
    { input: "asdf://%43|/", base: None, expected: None },
    { input: "asdf://%43%7C/", base: None, expected: Some("asdf://%43%7C/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: file URLs relative to other file URLs (via httpsgithub.comjs" {
  let test_cases : Array[WptTestVector] = [
    { input: "pix/submit.gif", base: Some("file:///C:/Users/Domenic/Dropbox/GitHub/tmpvar/jsdom/test/level2/html/files/anchor.html"), expected: Some("file:///C:/Users/Domenic/Dropbox/GitHub/tmpvar/jsdom/test/level2/html/files/pix/submit.gif") },
    { input: "..", base: Some("file:///C:/"), expected: Some("file:///C:/") },
    { input: "..", base: Some("file:///"), expected: Some("file:///") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: More file URL tests by zcorpan and annevk" {
  let test_cases : Array[WptTestVector] = [
    { input: "/", base: Some("file:///C:/a/b"), expected: Some("file:///C:/") },
    { input: "/", base: Some("file://h/C:/a/b"), expected: Some("file://h/C:/") },
    { input: "/", base: Some("file://h/a/b"), expected: Some("file://h/") },
    { input: "//d:", base: Some("file:///C:/a/b"), expected: Some("file:///d:") },
    { input: "//d:/..", base: Some("file:///C:/a/b"), expected: Some("file:///d:/") },
    { input: "..", base: Some("file:///ab:/"), expected: Some("file:///") },
    { input: "..", base: Some("file:///1:/"), expected: Some("file:///") },
    { input: "", base: Some("file:///test?test#test"), expected: Some("file:///test?test") },
    { input: "file:", base: Some("file:///test?test#test"), expected: Some("file:///test?test") },
    { input: "?x", base: Some("file:///test?test#test"), expected: Some("file:///test?x") },
    { input: "file:?x", base: Some("file:///test?test#test"), expected: Some("file:///test?x") },
    { input: "#x", base: Some("file:///test?test#test"), expected: Some("file:///test?test#x") },
    { input: "file:#x", base: Some("file:///test?test#test"), expected: Some("file:///test?test#x") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: File URLs and many (back)slashes" {
  let test_cases : Array[WptTestVector] = [
    { input: "file:\\\\//", base: None, expected: Some("file:////") },
    { input: "file:\\\\\\\\", base: None, expected: Some("file:////") },
    { input: "file:\\\\\\\\?fox", base: None, expected: Some("file:////?fox") },
    { input: "file:\\\\\\\\#guppy", base: None, expected: Some("file:////#guppy") },
    { input: "file://spider///", base: None, expected: Some("file://spider///") },
    { input: "file:\\\\localhost//", base: None, expected: Some("file:////") },
    { input: "file:///localhost//cat", base: None, expected: Some("file:///localhost//cat") },
    { input: "file://\\/localhost//cat", base: None, expected: Some("file:////localhost//cat") },
    { input: "file://localhost//a//../..//", base: None, expected: Some("file://///") },
    { input: "/////mouse", base: Some("file:///elephant"), expected: Some("file://///mouse") },
    { input: "\\//pig", base: Some("file://lion/"), expected: Some("file:///pig") },
    { input: "\\/localhost//pig", base: Some("file://lion/"), expected: Some("file:////pig") },
    { input: "//localhost//pig", base: Some("file://lion/"), expected: Some("file:////pig") },
    { input: "/..//localhost//pig", base: Some("file://lion/"), expected: Some("file://lion//localhost//pig") },
    { input: "file://", base: Some("file://ape/"), expected: Some("file:///") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: File URLs with non-empty hosts" {
  let test_cases : Array[WptTestVector] = [
    { input: "/rooibos", base: Some("file://tea/"), expected: Some("file://tea/rooibos") },
    { input: "/?chai", base: Some("file://tea/"), expected: Some("file://tea/?chai") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Windows drive letter handling with the file base URL" {
  let test_cases : Array[WptTestVector] = [
    { input: "C|", base: Some("file://host/dir/file"), expected: Some("file://host/C:") },
    { input: "C|", base: Some("file://host/D:/dir1/dir2/file"), expected: Some("file://host/C:") },
    { input: "C|#", base: Some("file://host/dir/file"), expected: Some("file://host/C:#") },
    { input: "C|?", base: Some("file://host/dir/file"), expected: Some("file://host/C:?") },
    { input: "C|/", base: Some("file://host/dir/file"), expected: Some("file://host/C:/") },
    { input: "C|\n/", base: Some("file://host/dir/file"), expected: Some("file://host/C:/") },
    { input: "C|\\", base: Some("file://host/dir/file"), expected: Some("file://host/C:/") },
    { input: "C", base: Some("file://host/dir/file"), expected: Some("file://host/dir/C") },
    { input: "C|a", base: Some("file://host/dir/file"), expected: Some("file://host/dir/C|a") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Windows drive letter quirk in the file slash state" {
  let test_cases : Array[WptTestVector] = [
    { input: "/c:/foo/bar", base: Some("file:///c:/baz/qux"), expected: Some("file:///c:/foo/bar") },
    { input: "/c|/foo/bar", base: Some("file:///c:/baz/qux"), expected: Some("file:///c:/foo/bar") },
    { input: "file:\\c:\\foo\\bar", base: Some("file:///c:/baz/qux"), expected: Some("file:///c:/foo/bar") },
    { input: "/c:/foo/bar", base: Some("file://host/path"), expected: Some("file://host/c:/foo/bar") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Do not drop the host in the presence of a drive letter" {
  let test_cases : Array[WptTestVector] = [
    { input: "file://example.net/C:/", base: None, expected: Some("file://example.net/C:/") },
    { input: "file://1.2.3.4/C:/", base: None, expected: Some("file://1.2.3.4/C:/") },
    { input: "file://[1::8]/C:/", base: None, expected: Some("file://[1::8]/C:/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Copy the host from the base URL in the following cases" {
  let test_cases : Array[WptTestVector] = [
    { input: "C|/", base: Some("file://host/"), expected: Some("file://host/C:/") },
    { input: "/C:/", base: Some("file://host/"), expected: Some("file://host/C:/") },
    { input: "file:C:/", base: Some("file://host/"), expected: Some("file://host/C:/") },
    { input: "file:/C:/", base: Some("file://host/"), expected: Some("file://host/C:/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Copy the empty host from the input in the following cases" {
  let test_cases : Array[WptTestVector] = [
    { input: "//C:/", base: Some("file://host/"), expected: Some("file:///C:/") },
    { input: "file://C:/", base: Some("file://host/"), expected: Some("file:///C:/") },
    { input: "///C:/", base: Some("file://host/"), expected: Some("file:///C:/") },
    { input: "file:///C:/", base: Some("file://host/"), expected: Some("file:///C:/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Windows drive letter quirk (no host)" {
  let test_cases : Array[WptTestVector] = [
    { input: "file:/C|/", base: None, expected: Some("file:///C:/") },
    { input: "file://C|/", base: None, expected: Some("file:///C:/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: file URLs without base URL by Rimas Misevičius" {
  let test_cases : Array[WptTestVector] = [
    { input: "file:", base: None, expected: Some("file:///") },
    { input: "file:?q=v", base: None, expected: Some("file:///?q=v") },
    { input: "file:#frag", base: None, expected: Some("file:///#frag") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: file drive letter cases from httpscrbug.com1078698" {
  let test_cases : Array[WptTestVector] = [
    { input: "file:///Y:", base: None, expected: Some("file:///Y:") },
    { input: "file:///Y:/", base: None, expected: Some("file:///Y:/") },
    { input: "file:///./Y", base: None, expected: Some("file:///Y") },
    { input: "file:///./Y:", base: None, expected: Some("file:///Y:") },
    { input: "\\\\\\.\\Y:", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: file drive letter cases from httpscrbug.com1078698 but lower" {
  let test_cases : Array[WptTestVector] = [
    { input: "file:///y:", base: None, expected: Some("file:///y:") },
    { input: "file:///y:/", base: None, expected: Some("file:///y:/") },
    { input: "file:///./y", base: None, expected: Some("file:///y") },
    { input: "file:///./y:", base: None, expected: Some("file:///y:") },
    { input: "\\\\\\.\\y:", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Additional file URL tests for (httpsgithub.comwhatwgurlissue" {
  let test_cases : Array[WptTestVector] = [
    { input: "file://localhost//a//../..//foo", base: None, expected: Some("file://///foo") },
    { input: "file://localhost////foo", base: None, expected: Some("file://////foo") },
    { input: "file:////foo", base: None, expected: Some("file:////foo") },
    { input: "file:///one/two", base: Some("file:///"), expected: Some("file:///one/two") },
    { input: "file:////one/two", base: Some("file:///"), expected: Some("file:////one/two") },
    { input: "//one/two", base: Some("file:///"), expected: Some("file://one/two") },
    { input: "///one/two", base: Some("file:///"), expected: Some("file:///one/two") },
    { input: "////one/two", base: Some("file:///"), expected: Some("file:////one/two") },
    { input: "file:///.//", base: Some("file:////"), expected: Some("file:////") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: File URL tests for httpsgithub.comwhatwgurlissues549" {
  let test_cases : Array[WptTestVector] = [
    { input: "file:.//p", base: None, expected: Some("file:////p") },
    { input: "file:/.//p", base: None, expected: Some("file:////p") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: IPv6 tests" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://[1:0::]", base: Some("http://example.net/"), expected: Some("http://[1::]/") },
    { input: "http://[0:1:2:3:4:5:6:7:8]", base: Some("http://example.net/"), expected: None },
    { input: "https://[0::0::0]", base: None, expected: None },
    { input: "https://[0:.0]", base: None, expected: None },
    { input: "https://[0:0:]", base: None, expected: None },
    { input: "https://[0:1:2:3:4:5:6:7.0.0.0.1]", base: None, expected: None },
    { input: "https://[0:1.00.0.0.0]", base: None, expected: None },
    { input: "https://[0:1.290.0.0.0]", base: None, expected: None },
    { input: "https://[0:1.23.23]", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Empty host" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://?", base: None, expected: None },
    { input: "http://#", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Port overflow (232 81)" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://f:4294967377/c", base: Some("http://example.org/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Port overflow (264 81)" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://f:18446744073709551697/c", base: Some("http://example.org/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Port overflow (2128 81)" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://f:340282366920938463463374607431768211537/c", base: Some("http://example.org/"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Non-special-URL path tests" {
  let test_cases : Array[WptTestVector] = [
    { input: "sc://ñ", base: None, expected: Some("sc://%C3%B1") },
    { input: "sc://ñ?x", base: None, expected: Some("sc://%C3%B1?x") },
    { input: "sc://ñ#x", base: None, expected: Some("sc://%C3%B1#x") },
    { input: "#x", base: Some("sc://ñ"), expected: Some("sc://%C3%B1#x") },
    { input: "?x", base: Some("sc://ñ"), expected: Some("sc://%C3%B1?x") },
    { input: "sc://?", base: None, expected: Some("sc://?") },
    { input: "sc://#", base: None, expected: Some("sc://#") },
    { input: "///", base: Some("sc://x/"), expected: Some("sc:///") },
    { input: "////", base: Some("sc://x/"), expected: Some("sc:////") },
    { input: "////x/", base: Some("sc://x/"), expected: Some("sc:////x/") },
    { input: "tftp://foobar.com/someconfig;mode=netascii", base: None, expected: Some("tftp://foobar.com/someconfig;mode=netascii") },
    { input: "telnet://user:pass@foobar.com:23/", base: None, expected: Some("telnet://user:pass@foobar.com:23/") },
    { input: "ut2004://10.10.10.10:7777/Index.ut2", base: None, expected: Some("ut2004://10.10.10.10:7777/Index.ut2") },
    { input: "redis://foo:bar@somehost:6379/0?baz=bam&qux=baz", base: None, expected: Some("redis://foo:bar@somehost:6379/0?baz=bam&qux=baz") },
    { input: "rsync://foo@host:911/sup", base: None, expected: Some("rsync://foo@host:911/sup") },
    { input: "git://github.com/foo/bar.git", base: None, expected: Some("git://github.com/foo/bar.git") },
    { input: "irc://myserver.com:6999/channel?passwd", base: None, expected: Some("irc://myserver.com:6999/channel?passwd") },
    { input: "dns://fw.example.org:9999/foo.bar.org?type=TXT", base: None, expected: Some("dns://fw.example.org:9999/foo.bar.org?type=TXT") },
    { input: "ldap://localhost:389/ou=People,o=JNDITutorial", base: None, expected: Some("ldap://localhost:389/ou=People,o=JNDITutorial") },
    { input: "git+https://github.com/foo/bar", base: None, expected: Some("git+https://github.com/foo/bar") },
    { input: "urn:ietf:rfc:2648", base: None, expected: Some("urn:ietf:rfc:2648") },
    { input: "tag:joe@example.org,2001:foo/bar", base: None, expected: Some("tag:joe@example.org,2001:foo/bar") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Serialize . in path" {
  let test_cases : Array[WptTestVector] = [
    { input: "non-spec:/.//", base: None, expected: Some("non-spec:/.//") },
    { input: "non-spec:/..//", base: None, expected: Some("non-spec:/.//") },
    { input: "non-spec:/a/..//", base: None, expected: Some("non-spec:/.//") },
    { input: "non-spec:/.//path", base: None, expected: Some("non-spec:/.//path") },
    { input: "non-spec:/..//path", base: None, expected: Some("non-spec:/.//path") },
    { input: "non-spec:/a/..//path", base: None, expected: Some("non-spec:/.//path") },
    { input: "/.//path", base: Some("non-spec:/p"), expected: Some("non-spec:/.//path") },
    { input: "/..//path", base: Some("non-spec:/p"), expected: Some("non-spec:/.//path") },
    { input: "..//path", base: Some("non-spec:/p"), expected: Some("non-spec:/.//path") },
    { input: "a/..//path", base: Some("non-spec:/p"), expected: Some("non-spec:/.//path") },
    { input: "", base: Some("non-spec:/..//p"), expected: Some("non-spec:/.//p") },
    { input: "path", base: Some("non-spec:/..//p"), expected: Some("non-spec:/.//path") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Do not serialize . in path" {
  let test_cases : Array[WptTestVector] = [
    { input: "../path", base: Some("non-spec:/.//p"), expected: Some("non-spec:/path") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: percent encoded hosts in non-special-URLs" {
  let test_cases : Array[WptTestVector] = [
    { input: "non-special://%E2%80%A0/", base: None, expected: Some("non-special://%E2%80%A0/") },
    { input: "non-special://H%4fSt/path", base: None, expected: Some("non-special://H%4fSt/path") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: IPv6 in non-special-URLs" {
  let test_cases : Array[WptTestVector] = [
    { input: "non-special://[1:2:0:0:5:0:0:0]/", base: None, expected: Some("non-special://[1:2:0:0:5::]/") },
    { input: "non-special://[1:2:0:0:0:0:0:3]/", base: None, expected: Some("non-special://[1:2::3]/") },
    { input: "non-special://[1:2::3]:80/", base: None, expected: Some("non-special://[1:2::3]:80/") },
    { input: "non-special://[:80/", base: None, expected: None },
    { input: "blob:https://example.com:443/", base: None, expected: Some("blob:https://example.com:443/") },
    { input: "blob:http://example.org:88/", base: None, expected: Some("blob:http://example.org:88/") },
    { input: "blob:d3958f5c-0777-0845-9dcf-2cb28783acaf", base: None, expected: Some("blob:d3958f5c-0777-0845-9dcf-2cb28783acaf") },
    { input: "blob:", base: None, expected: Some("blob:") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: blob in blob" {
  let test_cases : Array[WptTestVector] = [
    { input: "blob:blob:", base: None, expected: Some("blob:blob:") },
    { input: "blob:blob:https://example.org/", base: None, expected: Some("blob:blob:https://example.org/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Non-http(s) in blob" {
  let test_cases : Array[WptTestVector] = [
    { input: "blob:about:blank", base: None, expected: Some("blob:about:blank") },
    { input: "blob:file://host/path", base: None, expected: Some("blob:file://host/path") },
    { input: "blob:ftp://host/path", base: None, expected: Some("blob:ftp://host/path") },
    { input: "blob:ws://example.org/", base: None, expected: Some("blob:ws://example.org/") },
    { input: "blob:wss://example.org/", base: None, expected: Some("blob:wss://example.org/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Percent-encoded http in blob" {
  let test_cases : Array[WptTestVector] = [
    { input: "blob:http%3a//example.org/", base: None, expected: Some("blob:http%3a//example.org/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Invalid IPv4 radix digits" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://0x7f.0.0.0x7g", base: None, expected: Some("http://0x7f.0.0.0x7g/") },
    { input: "http://0X7F.0.0.0X7G", base: None, expected: Some("http://0x7f.0.0.0x7g/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Invalid IPv4 portion of IPv6 address" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://[::127.0.0.0.1]", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Uncompressed IPv6 addresses with 0" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://[0:1:0:1:0:1:0:1]", base: None, expected: Some("http://[0:1:0:1:0:1:0:1]/") },
    { input: "http://[1:0:1:0:1:0:1:0]", base: None, expected: Some("http://[1:0:1:0:1:0:1:0]/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Percent-encoded query and fragment" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://example.org/test?\"", base: None, expected: Some("http://example.org/test?%22") },
    { input: "http://example.org/test?#", base: None, expected: Some("http://example.org/test?#") },
    { input: "http://example.org/test?<", base: None, expected: Some("http://example.org/test?%3C") },
    { input: "http://example.org/test?>", base: None, expected: Some("http://example.org/test?%3E") },
    { input: "http://example.org/test?⌣", base: None, expected: Some("http://example.org/test?%E2%8C%A3") },
    { input: "http://example.org/test?%23%23", base: None, expected: Some("http://example.org/test?%23%23") },
    { input: "http://example.org/test?%GH", base: None, expected: Some("http://example.org/test?%GH") },
    { input: "http://example.org/test?a#%EF", base: None, expected: Some("http://example.org/test?a#%EF") },
    { input: "http://example.org/test?a#%GH", base: None, expected: Some("http://example.org/test?a#%GH") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: URLs that require a non-aboutblank base. (Also serve as inva" {
  let test_cases : Array[WptTestVector] = [
    { input: "a", base: None, expected: None },
    { input: "a/", base: None, expected: None },
    { input: "a//", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Bases that dont fail to parse but fail to be bases" {
  let test_cases : Array[WptTestVector] = [
    { input: "test-a-colon.html", base: Some("a:"), expected: None },
    { input: "test-a-colon-b.html", base: Some("a:b"), expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Other base URL tests, that must succeed" {
  let test_cases : Array[WptTestVector] = [
    { input: "test-a-colon-slash.html", base: Some("a:/"), expected: Some("a:/test-a-colon-slash.html") },
    { input: "test-a-colon-slash-slash.html", base: Some("a://"), expected: Some("a:///test-a-colon-slash-slash.html") },
    { input: "test-a-colon-slash-b.html", base: Some("a:/b"), expected: Some("a:/test-a-colon-slash-b.html") },
    { input: "test-a-colon-slash-slash-b.html", base: Some("a://b"), expected: Some("a://b/test-a-colon-slash-slash-b.html") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Null code point in fragment" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://example.org/test?a#b\u{0000}c", base: None, expected: Some("http://example.org/test?a#b%00c") },
    { input: "non-spec://example.org/test?a#b\u{0000}c", base: None, expected: Some("non-spec://example.org/test?a#b%00c") },
    { input: "non-spec:/test?a#b\u{0000}c", base: None, expected: Some("non-spec:/test?a#b%00c") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: First scheme char - not allowed httpsgithub.comwhatwgurlissu" {
  let test_cases : Array[WptTestVector] = [
    { input: "10.0.0.7:8080/foo.html", base: Some("file:///some/dir/bar.html"), expected: Some("file:///some/dir/10.0.0.7:8080/foo.html") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Subsequent scheme chars - not allowed" {
  let test_cases : Array[WptTestVector] = [
    { input: "a!@$*=/foo.html", base: Some("file:///some/dir/bar.html"), expected: Some("file:///some/dir/a!@$*=/foo.html") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: First and subsequent scheme chars - allowed" {
  let test_cases : Array[WptTestVector] = [
    { input: "a1234567890-+.:foo/bar", base: Some("http://example.com/dir/file"), expected: Some("a1234567890-+.:foo/bar") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: IDNA ignored code points in file URLs hosts" {
  let test_cases : Array[WptTestVector] = [
    { input: "file://a­b/p", base: None, expected: Some("file://ab/p") },
    { input: "file://a%C2%ADb/p", base: None, expected: Some("file://ab/p") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: IDNA hostnames which get mapped to localhost" {
  let test_cases : Array[WptTestVector] = [
    { input: "file://loC𝐀𝐋𝐇𝐨𝐬𝐭/usr/bin", base: None, expected: Some("file:///usr/bin") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Empty host after the domain to ASCII" {
  let test_cases : Array[WptTestVector] = [
    { input: "file://­/p", base: None, expected: None },
    { input: "file://%C2%AD/p", base: None, expected: None },
    { input: "file://xn--/p", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: httpsbugzilla.mozilla.orgshow_bug.cgiid1647058" {
  let test_cases : Array[WptTestVector] = [
    { input: "#link", base: Some("https://example.org/##link"), expected: Some("https://example.org/#link") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: UTF-8 percent-encode of C0 control percent-encode set and su" {
  let test_cases : Array[WptTestVector] = [
    { input: "non-special:cannot-be-a-base-url-\u{0000}\u{0001}\u{001F}\u{001E}~\u{007F}", base: None, expected: Some("non-special:cannot-be-a-base-url-%00%01%1F%1E~%7F%C2%80") },
    { input: "non-special:cannot-be-a-base-url-!\"$%&'()*+,-.;<=>@[\\]^_`{|}~@/", base: None, expected: Some("non-special:cannot-be-a-base-url-!\"$%&'()*+,-.;<=>@[\\]^_`{|}~@/") },
    { input: "https://www.example.com/path{\u{007F}path.html?query'\u{007F}=query#fragment<\u{007F}fragment", base: None, expected: Some("https://www.example.com/path%7B%7Fpath.html?query%27%7F=query#fragment%3C%7Ffragment") },
    { input: "https://user:pass[\u{007F}@foo/bar", base: Some("http://example.org"), expected: Some("https://user:pass%5B%7F@foo/bar") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Tests for the distinct percent-encode sets" {
  let test_cases : Array[WptTestVector] = [
    { input: "foo:// !\"$%&'()*+,-.;<=>@[\\]^_`{|}~@host/", base: None, expected: Some("foo://%20!%22$%&'()*+,-.%3B%3C%3D%3E%40%5B%5C%5D%5E_%60%7B%7C%7D~@host/") },
    { input: "wss:// !\"$%&'()*+,-.;<=>@[]^_`{|}~@host/", base: None, expected: Some("wss://%20!%22$%&'()*+,-.%3B%3C%3D%3E%40%5B%5D%5E_%60%7B%7C%7D~@host/") },
    { input: "foo://joe: !\"$%&'()*+,-.:;<=>@[\\]^_`{|}~@host/", base: None, expected: Some("foo://joe:%20!%22$%&'()*+,-.%3A%3B%3C%3D%3E%40%5B%5C%5D%5E_%60%7B%7C%7D~@host/") },
    { input: "wss://joe: !\"$%&'()*+,-.:;<=>@[]^_`{|}~@host/", base: None, expected: Some("wss://joe:%20!%22$%&'()*+,-.%3A%3B%3C%3D%3E%40%5B%5D%5E_%60%7B%7C%7D~@host/") },
    { input: "foo://!\"$%&'()*+,-.;=_`{}~/", base: None, expected: Some("foo://!\"$%&'()*+,-.;=_`{}~/") },
    { input: "wss://!\"$&'()*+,-.;=_`{}~/", base: None, expected: Some("wss://!\"$&'()*+,-.;=_`{}~/") },
    { input: "foo://host/ !\"$%&'()*+,-./:;<=>@[\\]^_`{|}~", base: None, expected: Some("foo://host/%20!%22$%&'()*+,-./:;%3C=%3E@[\\]%5E_%60%7B|%7D~") },
    { input: "wss://host/ !\"$%&'()*+,-./:;<=>@[\\]^_`{|}~", base: None, expected: Some("wss://host/%20!%22$%&'()*+,-./:;%3C=%3E@[/]%5E_%60%7B|%7D~") },
    { input: "foo://host/dir/? !\"$%&'()*+,-./:;<=>?@[\\]^_`{|}~", base: None, expected: Some("foo://host/dir/?%20!%22$%&'()*+,-./:;%3C=%3E?@[\\]^_`{|}~") },
    { input: "wss://host/dir/? !\"$%&'()*+,-./:;<=>?@[\\]^_`{|}~", base: None, expected: Some("wss://host/dir/?%20!%22$%&%27()*+,-./:;%3C=%3E?@[\\]^_`{|}~") },
    { input: "foo://host/dir/# !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~", base: None, expected: Some("foo://host/dir/#%20!%22#$%&'()*+,-./:;%3C=%3E?@[\\]^_%60{|}~") },
    { input: "wss://host/dir/# !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~", base: None, expected: Some("wss://host/dir/#%20!%22#$%&'()*+,-./:;%3C=%3E?@[\\]^_%60{|}~") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Ensure that input schemes are not ignored when resolving non" {
  let test_cases : Array[WptTestVector] = [
    { input: "abc:rootless", base: Some("abc://host/path"), expected: Some("abc:rootless") },
    { input: "abc:rootless", base: Some("abc:/path"), expected: Some("abc:rootless") },
    { input: "abc:rootless", base: Some("abc:path"), expected: Some("abc:rootless") },
    { input: "abc:/rooted", base: Some("abc://host/path"), expected: Some("abc:/rooted") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Empty query and fragment with blank should throw an error" {
  let test_cases : Array[WptTestVector] = [
    { input: "#", base: None, expected: None },
    { input: "?", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Last component looks like a number, but not valid IPv4" {
  let test_cases : Array[WptTestVector] = [
    { input: "http://1.2.3.4.5", base: Some("http://other.com/"), expected: None },
    { input: "http://1.2.3.4.5.", base: Some("http://other.com/"), expected: None },
    { input: "http://0..0x300/", base: None, expected: None },
    { input: "http://0..0x300./", base: None, expected: None },
    { input: "http://256.256.256.256.256", base: Some("http://other.com/"), expected: None },
    { input: "http://256.256.256.256.256.", base: Some("http://other.com/"), expected: None },
    { input: "http://1.2.3.08", base: None, expected: None },
    { input: "http://1.2.3.08.", base: None, expected: None },
    { input: "http://1.2.3.09", base: None, expected: None },
    { input: "http://09.2.3.4", base: None, expected: None },
    { input: "http://09.2.3.4.", base: None, expected: None },
    { input: "http://01.2.3.4.5", base: None, expected: None },
    { input: "http://01.2.3.4.5.", base: None, expected: None },
    { input: "http://0x100.2.3.4", base: None, expected: None },
    { input: "http://0x100.2.3.4.", base: None, expected: None },
    { input: "http://0x1.2.3.4.5", base: None, expected: None },
    { input: "http://0x1.2.3.4.5.", base: None, expected: None },
    { input: "http://foo.1.2.3.4", base: None, expected: None },
    { input: "http://foo.1.2.3.4.", base: None, expected: None },
    { input: "http://foo.2.3.4", base: None, expected: None },
    { input: "http://foo.2.3.4.", base: None, expected: None },
    { input: "http://foo.09", base: None, expected: None },
    { input: "http://foo.09.", base: None, expected: None },
    { input: "http://foo.0x4", base: None, expected: None },
    { input: "http://foo.0x4.", base: None, expected: None },
    { input: "http://foo.09..", base: None, expected: Some("http://foo.09../") },
    { input: "http://0999999999999999999/", base: None, expected: None },
    { input: "http://foo.0x", base: None, expected: None },
    { input: "http://foo.0XFfFfFfFfFfFfFfFfFfAcE123", base: None, expected: None },
    { input: "http://💩.123/", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: U0000 and UFFFF in various places" {
  let test_cases : Array[WptTestVector] = [
    { input: "https://\u{0000}y", base: None, expected: None },
    { input: "https://x/\u{0000}y", base: None, expected: Some("https://x/%00y") },
    { input: "https://x/?\u{0000}y", base: None, expected: Some("https://x/?%00y") },
    { input: "https://x/?#\u{0000}y", base: None, expected: Some("https://x/?#%00y") },
    { input: "https://￿y", base: None, expected: None },
    { input: "https://x/￿y", base: None, expected: Some("https://x/%EF%BF%BFy") },
    { input: "https://x/?￿y", base: None, expected: Some("https://x/?%EF%BF%BFy") },
    { input: "https://x/?#￿y", base: None, expected: Some("https://x/?#%EF%BF%BFy") },
    { input: "non-special:\u{0000}y", base: None, expected: Some("non-special:%00y") },
    { input: "non-special:x/\u{0000}y", base: None, expected: Some("non-special:x/%00y") },
    { input: "non-special:x/?\u{0000}y", base: None, expected: Some("non-special:x/?%00y") },
    { input: "non-special:x/?#\u{0000}y", base: None, expected: Some("non-special:x/?#%00y") },
    { input: "non-special:￿y", base: None, expected: Some("non-special:%EF%BF%BFy") },
    { input: "non-special:x/￿y", base: None, expected: Some("non-special:x/%EF%BF%BFy") },
    { input: "non-special:x/?￿y", base: None, expected: Some("non-special:x/?%EF%BF%BFy") },
    { input: "non-special:x/?#￿y", base: None, expected: Some("non-special:x/?#%EF%BF%BFy") },
    { input: "", base: None, expected: None },
    { input: "https://example.com/\"quoted\"", base: None, expected: Some("https://example.com/%22quoted%22") },
    { input: "https://a%C2%ADb/", base: None, expected: Some("https://ab/") },
    { input: "https://­/", base: None, expected: None },
    { input: "https://%C2%AD/", base: None, expected: None },
    { input: "https://xn--/", base: None, expected: None },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Non-special schemes that some implementations might incorrec" {
  let test_cases : Array[WptTestVector] = [
    { input: "data://example.com:8080/pathname?search#hash", base: None, expected: Some("data://example.com:8080/pathname?search#hash") },
    { input: "data:///test", base: None, expected: Some("data:///test") },
    { input: "data://test/a/../b", base: None, expected: Some("data://test/b") },
    { input: "data://:443", base: None, expected: None },
    { input: "data://test:test", base: None, expected: None },
    { input: "data://[:1]", base: None, expected: None },
    { input: "javascript://example.com:8080/pathname?search#hash", base: None, expected: Some("javascript://example.com:8080/pathname?search#hash") },
    { input: "javascript:///test", base: None, expected: Some("javascript:///test") },
    { input: "javascript://test/a/../b", base: None, expected: Some("javascript://test/b") },
    { input: "javascript://:443", base: None, expected: None },
    { input: "javascript://test:test", base: None, expected: None },
    { input: "javascript://[:1]", base: None, expected: None },
    { input: "mailto://example.com:8080/pathname?search#hash", base: None, expected: Some("mailto://example.com:8080/pathname?search#hash") },
    { input: "mailto:///test", base: None, expected: Some("mailto:///test") },
    { input: "mailto://test/a/../b", base: None, expected: Some("mailto://test/b") },
    { input: "mailto://:443", base: None, expected: None },
    { input: "mailto://test:test", base: None, expected: None },
    { input: "mailto://[:1]", base: None, expected: None },
    { input: "intent://example.com:8080/pathname?search#hash", base: None, expected: Some("intent://example.com:8080/pathname?search#hash") },
    { input: "intent:///test", base: None, expected: Some("intent:///test") },
    { input: "intent://test/a/../b", base: None, expected: Some("intent://test/b") },
    { input: "intent://:443", base: None, expected: None },
    { input: "intent://test:test", base: None, expected: None },
    { input: "intent://[:1]", base: None, expected: None },
    { input: "urn://example.com:8080/pathname?search#hash", base: None, expected: Some("urn://example.com:8080/pathname?search#hash") },
    { input: "urn:///test", base: None, expected: Some("urn:///test") },
    { input: "urn://test/a/../b", base: None, expected: Some("urn://test/b") },
    { input: "urn://:443", base: None, expected: None },
    { input: "urn://test:test", base: None, expected: None },
    { input: "urn://[:1]", base: None, expected: None },
    { input: "turn://example.com:8080/pathname?search#hash", base: None, expected: Some("turn://example.com:8080/pathname?search#hash") },
    { input: "turn:///test", base: None, expected: Some("turn:///test") },
    { input: "turn://test/a/../b", base: None, expected: Some("turn://test/b") },
    { input: "turn://:443", base: None, expected: None },
    { input: "turn://test:test", base: None, expected: None },
    { input: "turn://[:1]", base: None, expected: None },
    { input: "stun://example.com:8080/pathname?search#hash", base: None, expected: Some("stun://example.com:8080/pathname?search#hash") },
    { input: "stun:///test", base: None, expected: Some("stun:///test") },
    { input: "stun://test/a/../b", base: None, expected: Some("stun://test/b") },
    { input: "stun://:443", base: None, expected: None },
    { input: "stun://test:test", base: None, expected: None },
    { input: "stun://[:1]", base: None, expected: None },
    { input: "w://x:0", base: None, expected: Some("w://x:0") },
    { input: "west://x:0", base: None, expected: Some("west://x:0") },
    { input: "android://x:0/a", base: None, expected: Some("android://x:0/a") },
    { input: "drivefs://x:0/a", base: None, expected: Some("drivefs://x:0/a") },
    { input: "chromeos-steam://x:0/a", base: None, expected: Some("chromeos-steam://x:0/a") },
    { input: "steam://x:0/a", base: None, expected: Some("steam://x:0/a") },
    { input: "materialized-view://x:0/a", base: None, expected: Some("materialized-view://x:0/a") },
    { input: "android-app://x:0", base: None, expected: Some("android-app://x:0") },
    { input: "chrome-distiller://x:0", base: None, expected: Some("chrome-distiller://x:0") },
    { input: "chrome-extension://x:0", base: None, expected: Some("chrome-extension://x:0") },
    { input: "chrome-native://x:0", base: None, expected: Some("chrome-native://x:0") },
    { input: "chrome-resource://x:0", base: None, expected: Some("chrome-resource://x:0") },
    { input: "chrome-search://x:0", base: None, expected: Some("chrome-search://x:0") },
    { input: "fuchsia-dir://x:0", base: None, expected: Some("fuchsia-dir://x:0") },
    { input: "isolated-app://x:0", base: None, expected: Some("isolated-app://x:0") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Scheme relative path starting with multiple slashes" {
  let test_cases : Array[WptTestVector] = [
    { input: "///test", base: Some("http://example.org/"), expected: Some("http://test/") },
    { input: "///\\//\\//test", base: Some("http://example.org/"), expected: Some("http://test/") },
    { input: "///example.org/path", base: Some("http://example.org/"), expected: Some("http://example.org/path") },
    { input: "///example.org/../path", base: Some("http://example.org/"), expected: Some("http://example.org/path") },
    { input: "///example.org/../../", base: Some("http://example.org/"), expected: Some("http://example.org/") },
    { input: "///example.org/../path/../../", base: Some("http://example.org/"), expected: Some("http://example.org/") },
    { input: "///example.org/../path/../../path", base: Some("http://example.org/"), expected: Some("http://example.org/path") },
    { input: "/\\/\\//example.org/../path", base: Some("http://example.org/"), expected: Some("http://example.org/path") },
    { input: "///abcdef/../", base: Some("file:///"), expected: Some("file:///") },
    { input: "/\\//\\/a/../", base: Some("file:///"), expected: Some("file://////") },
    { input: "//a/../", base: Some("file:///"), expected: Some("file://a/") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}

test "WPT: Non-special URL and backslashes" {
  let test_cases : Array[WptTestVector] = [
    { input: "non-special:\\\\opaque", base: None, expected: Some("non-special:\\\\opaque") },
    { input: "non-special:\\\\opaque/path", base: None, expected: Some("non-special:\\\\opaque/path") },
    { input: "non-special:\\\\opaque\\path", base: None, expected: Some("non-special:\\\\opaque\\path") },
    { input: "non-special:\\/opaque", base: None, expected: Some("non-special:\\/opaque") },
    { input: "non-special:/\\path", base: None, expected: Some("non-special:/\\path") },
    { input: "non-special://host\\a", base: None, expected: None },
    { input: "non-special://host/a\\b", base: None, expected: Some("non-special://host/a\\b") },
  ]
  for test_case in test_cases {
    let { input, base, expected } = test_case
    let result = match base {
      Some(b) => {
        let base_url = @url.Url::parse(b)
        guard base_url is Some(base_url) else { continue }
        @url.Url::parse(input, base=base_url)
      }
      None => @url.Url::parse(input)
    }
    match (result, expected) {
      (Some(url), Some(exp)) => assert_eq(url.to_string(), exp)
      (None, None) => ()
      (Some(url), None) => {
        fail("Expected failure but got: \{url.to_string().escape()}")
      }
      (None, Some(exp)) => {
        fail("Expected success but parsing failed. Expected: \{exp.escape()}")
      }
    }
  }
}
