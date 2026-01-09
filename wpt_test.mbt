// Auto-generated from WPT urltestdata.json
// https://github.com/web-platform-tests/wpt/blob/master/url/resources/urltestdata.json
// Do not edit manually
//
// To regenerate: python3 scripts/generate_url_tests.py > url_generated_test.mbt

///|
test "WPT #0" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://example\t.\norg", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/")
}

///|
test "WPT #1" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://user:pass@foo:21/bar;par?b#c",
    base=base_url,
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://user:pass@foo:21/bar;par?b#c")
}

///|
test "WPT #2" {
  let result = @url.Url::parse("https://test:@test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://test@test/")
}

///|
test "WPT #3" {
  let result = @url.Url::parse("https://:@test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://test/")
}

///|
test "WPT #4" {
  let result = @url.Url::parse("non-special://test:@test/x")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special://test@test/x")
}

///|
test "WPT #5" {
  let result = @url.Url::parse("non-special://:@test/x")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special://test/x")
}

///|
test "WPT #6" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http:foo.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/foo.com")
}

///|
test "WPT #7" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("\t   :foo.com   \n", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:foo.com")
}

///|
test "WPT #8" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(" foo.com  ", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/foo.com")
}

///|
test "WPT #9" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("a:\t foo.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "a: foo.com")
}

///|
test "WPT #10" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:21/ b ? d # e ", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://f:21/%20b%20?%20d%20#%20e")
}

///|
test "WPT #11" {
  let result = @url.Url::parse("lolscheme:x x#x x")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "lolscheme:x x#x%20x")
}

///|
test "WPT #12" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:/c", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://f/c")
}

///|
test "WPT #13" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:0/c", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://f:0/c")
}

///|
test "WPT #14" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:00000000000000/c", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://f:0/c")
}

///|
test "WPT #15" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://f:00000000000000000000080/c",
    base=base_url,
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://f/c")
}

///|
test "WPT #16" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:b/c", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #17" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f: /c", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #18" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:\n/c", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://f/c")
}

///|
test "WPT #19" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:fifty-two/c", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #20" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:999999/c", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #21" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("non-special://f:999999/c", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #22" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f: 21 / b ? d # e ", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #23" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar")
}

///|
test "WPT #24" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("  \t", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar")
}

///|
test "WPT #25" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(":foo.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:foo.com/")
}

///|
test "WPT #26" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(":foo.com\\", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:foo.com/")
}

///|
test "WPT #27" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(":", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:")
}

///|
test "WPT #28" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(":a", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:a")
}

///|
test "WPT #29" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(":/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:/")
}

///|
test "WPT #30" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(":\\", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:/")
}

///|
test "WPT #31" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(":#", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:#")
}

///|
test "WPT #32" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar#")
}

///|
test "WPT #33" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar#/")
}

///|
test "WPT #34" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#\\", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar#\\")
}

///|
test "WPT #35" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#;?", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar#;?")
}

///|
test "WPT #36" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar?")
}

///|
test "WPT #37" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/")
}

///|
test "WPT #38" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(":23", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:23")
}

///|
test "WPT #39" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/:23", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/:23")
}

///|
test "WPT #40" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("\\x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/x")
}

///|
test "WPT #41" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("\\\\x\\hello", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://x/hello")
}

///|
test "WPT #42" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("::", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/::")
}

///|
test "WPT #43" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("::23", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/::23")
}

///|
test "WPT #44" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("foo://", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo://")
}

///|
test "WPT #45" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://a:b@c:29/d", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a:b@c:29/d")
}

///|
test "WPT #46" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http::@c:29", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/:@c:29")
}

///|
test "WPT #47" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://&a:foo(b]c@d:2/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://&a:foo(b%5Dc@d:2/")
}

///|
test "WPT #48" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://::@c@d:2", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://:%3A%40c@d:2/")
}

///|
test "WPT #49" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://foo.com:b@d/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.com:b@d/")
}

///|
test "WPT #50" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://foo.com/\\@", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.com//@")
}

///|
test "WPT #51" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http:\\\\foo.com\\", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.com/")
}

///|
test "WPT #52" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http:\\\\a\\b:c\\d@foo.com\\", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a/b:c/d@foo.com/")
}

///|
test "WPT #53" {
  let result = @url.Url::parse("http://a:b@c\\")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a:b@c/")
}

///|
test "WPT #54" {
  let result = @url.Url::parse("ws://a@b\\c")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://a@b/c")
}

///|
test "WPT #55" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("foo:/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo:/")
}

///|
test "WPT #56" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("foo:/bar.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo:/bar.com/")
}

///|
test "WPT #57" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("foo://///////", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo://///////")
}

///|
test "WPT #58" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("foo://///////bar.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo://///////bar.com/")
}

///|
test "WPT #59" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("foo:////://///", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo:////://///")
}

///|
test "WPT #60" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("c:/foo", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "c:/foo")
}

///|
test "WPT #61" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//foo/bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo/bar")
}

///|
test "WPT #62" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://foo/path;a??e#f#g", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo/path;a??e#f#g")
}

///|
test "WPT #63" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://foo/abcd?efgh?ijkl", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo/abcd?efgh?ijkl")
}

///|
test "WPT #64" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://foo/abcd#foo?bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo/abcd#foo?bar")
}

///|
test "WPT #65" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("[61:24:74]:98", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/[61:24:74]:98")
}

///|
test "WPT #66" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http:[61:27]/:foo", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/[61:27]/:foo")
}

///|
test "WPT #67" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[1::2]:3:4", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #68" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://2001::1", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #69" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://2001::1]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #70" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://2001::1]:80", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #71" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[2001::1]", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://[2001::1]/")
}

///|
test "WPT #72" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::127.0.0.1]", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://[::7f00:1]/")
}

///|
test "WPT #73" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::127.0.0.1.]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #74" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[0:0:0:0:0:0:13.1.68.3]", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://[::d01:4403]/")
}

///|
test "WPT #75" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[2001::1]:80", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://[2001::1]/")
}

///|
test "WPT #76" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/example.com/")
}

///|
test "WPT #77" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("ftp:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftp://example.com/")
}

///|
test "WPT #78" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("https:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://example.com/")
}

///|
test "WPT #79" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("madeupscheme:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "madeupscheme:/example.com/")
}

///|
test "WPT #80" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///example.com/")
}

///|
test "WPT #81" {
  let result = @url.Url::parse("file://example:1/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #82" {
  let result = @url.Url::parse("file://example:test/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #83" {
  let result = @url.Url::parse("file://example%/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #84" {
  let result = @url.Url::parse("file://[example]/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #85" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("ftps:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftps:/example.com/")
}

///|
test "WPT #86" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("gopher:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "gopher:/example.com/")
}

///|
test "WPT #87" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("ws:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://example.com/")
}

///|
test "WPT #88" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("wss:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://example.com/")
}

///|
test "WPT #89" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("data:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:/example.com/")
}

///|
test "WPT #90" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("javascript:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "javascript:/example.com/")
}

///|
test "WPT #91" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("mailto:/example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto:/example.com/")
}

///|
test "WPT #92" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/example.com/")
}

///|
test "WPT #93" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("ftp:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftp://example.com/")
}

///|
test "WPT #94" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("https:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://example.com/")
}

///|
test "WPT #95" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("madeupscheme:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "madeupscheme:example.com/")
}

///|
test "WPT #96" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("ftps:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftps:example.com/")
}

///|
test "WPT #97" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("gopher:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "gopher:example.com/")
}

///|
test "WPT #98" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("ws:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://example.com/")
}

///|
test "WPT #99" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("wss:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://example.com/")
}

///|
test "WPT #100" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("data:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:example.com/")
}

///|
test "WPT #101" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("javascript:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "javascript:example.com/")
}

///|
test "WPT #102" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("mailto:example.com/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto:example.com/")
}

///|
test "WPT #103" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/a/b/c", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/a/b/c")
}

///|
test "WPT #104" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/a/ /c", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/a/%20/c")
}

///|
test "WPT #105" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/a%2fc", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/a%2fc")
}

///|
test "WPT #106" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/a/%2f/c", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/a/%2f/c")
}

///|
test "WPT #107" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#β", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar#%CE%B2")
}

///|
test "WPT #108" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("data:text/html,test#test", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:text/html,test#test")
}

///|
test "WPT #109" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("tel:1234567890", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "tel:1234567890")
}

///|
test "WPT #110" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("ssh://example.com/foo/bar.git", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ssh://example.com/foo/bar.git")
}

///|
test "WPT #111" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:c:\\foo\\bar.html", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///c:/foo/bar.html")
}

///|
test "WPT #112" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("  File:c|////foo\\bar.html", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///c:////foo/bar.html")
}

///|
test "WPT #113" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|/foo/bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/foo/bar")
}

///|
test "WPT #114" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/C|\\foo\\bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/foo/bar")
}

///|
test "WPT #115" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//C|/foo/bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/foo/bar")
}

///|
test "WPT #116" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//server/file", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://server/file")
}

///|
test "WPT #117" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("\\\\server\\file", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://server/file")
}

///|
test "WPT #118" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/\\server/file", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://server/file")
}

///|
test "WPT #119" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:///foo/bar.txt", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///foo/bar.txt")
}

///|
test "WPT #120" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:///home/me", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///home/me")
}

///|
test "WPT #121" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #122" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #123" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///test", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///test")
}

///|
test "WPT #124" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file://test", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://test/")
}

///|
test "WPT #125" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file://localhost", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #126" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file://localhost/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #127" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file://localhost/test", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///test")
}

///|
test "WPT #128" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("test", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///tmp/mock/test")
}

///|
test "WPT #129" {
  let base_url = @url.Url::parse("file:///tmp/mock/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:test", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///tmp/mock/test")
}

///|
test "WPT #130" {
  let result = @url.Url::parse("file:///w|m")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///w|m")
}

///|
test "WPT #131" {
  let result = @url.Url::parse("file:///w||m")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///w||m")
}

///|
test "WPT #132" {
  let result = @url.Url::parse("file:///w|/m")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///w:/m")
}

///|
test "WPT #133" {
  let result = @url.Url::parse("file:C|/m/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/m/")
}

///|
test "WPT #134" {
  let result = @url.Url::parse("file:C||/m/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C||/m/")
}

///|
test "WPT #135" {
  let result = @url.Url::parse("http://example.com/././foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo")
}

///|
test "WPT #136" {
  let result = @url.Url::parse("http://example.com/./.foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/.foo")
}

///|
test "WPT #137" {
  let result = @url.Url::parse("http://example.com/foo/.")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/")
}

///|
test "WPT #138" {
  let result = @url.Url::parse("http://example.com/foo/./")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/")
}

///|
test "WPT #139" {
  let result = @url.Url::parse("http://example.com/foo/bar/..")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/")
}

///|
test "WPT #140" {
  let result = @url.Url::parse("http://example.com/foo/bar/../")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/")
}

///|
test "WPT #141" {
  let result = @url.Url::parse("http://example.com/foo/..bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/..bar")
}

///|
test "WPT #142" {
  let result = @url.Url::parse("http://example.com/foo/bar/../ton")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/ton")
}

///|
test "WPT #143" {
  let result = @url.Url::parse("http://example.com/foo/bar/../ton/../../a")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/a")
}

///|
test "WPT #144" {
  let result = @url.Url::parse("http://example.com/foo/../../..")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/")
}

///|
test "WPT #145" {
  let result = @url.Url::parse("http://example.com/foo/../../../ton")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/ton")
}

///|
test "WPT #146" {
  let result = @url.Url::parse("http://example.com/foo/%2e")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/")
}

///|
test "WPT #147" {
  let result = @url.Url::parse("http://example.com/foo/%2e%2")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/%2e%2")
}

///|
test "WPT #148" {
  let result = @url.Url::parse(
    "http://example.com/foo/%2e./%2e%2e/.%2e/%2e.bar",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/%2e.bar")
}

///|
test "WPT #149" {
  let result = @url.Url::parse("http://example.com////../..")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com//")
}

///|
test "WPT #150" {
  let result = @url.Url::parse("http://example.com/foo/bar//../..")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/")
}

///|
test "WPT #151" {
  let result = @url.Url::parse("http://example.com/foo/bar//..")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo/bar/")
}

///|
test "WPT #152" {
  let result = @url.Url::parse("http://example.com/foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo")
}

///|
test "WPT #153" {
  let result = @url.Url::parse("http://example.com/%20foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/%20foo")
}

///|
test "WPT #154" {
  let result = @url.Url::parse("http://example.com/foo%")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo%")
}

///|
test "WPT #155" {
  let result = @url.Url::parse("http://example.com/foo%2")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo%2")
}

///|
test "WPT #156" {
  let result = @url.Url::parse("http://example.com/foo%2zbar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo%2zbar")
}

///|
test "WPT #157" {
  let result = @url.Url::parse("http://example.com/foo%2Â©zbar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo%2%C3%82%C2%A9zbar")
}

///|
test "WPT #158" {
  let result = @url.Url::parse("http://example.com/foo%41%7a")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo%41%7a")
}

///|
test "WPT #159" {
  let result = @url.Url::parse("http://example.com/foo\t%91")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo%C2%91%91")
}

///|
test "WPT #160" {
  let result = @url.Url::parse("http://example.com/foo%00%51")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foo%00%51")
}

///|
test "WPT #161" {
  let result = @url.Url::parse("http://example.com/(%28:%3A%29)")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/(%28:%3A%29)")
}

///|
test "WPT #162" {
  let result = @url.Url::parse("http://example.com/%3A%3a%3C%3c")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/%3A%3a%3C%3c")
}

///|
test "WPT #163" {
  let result = @url.Url::parse("http://example.com/foo\tbar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/foobar")
}

///|
test "WPT #164" {
  let result = @url.Url::parse("http://example.com\\\\foo\\\\bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com//foo//bar")
}

///|
test "WPT #165" {
  let result = @url.Url::parse("http://example.com/%7Ffp3%3Eju%3Dduvgw%3Dd")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/%7Ffp3%3Eju%3Dduvgw%3Dd")
}

///|
test "WPT #166" {
  let result = @url.Url::parse("http://example.com/@asdf%40")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/@asdf%40")
}

///|
test "WPT #167" {
  let result = @url.Url::parse("http://example.com/你好你好")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "http://example.com/%E4%BD%A0%E5%A5%BD%E4%BD%A0%E5%A5%BD",
  )
}

///|
test "WPT #168" {
  let result = @url.Url::parse("http://example.com/‥/foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/%E2%80%A5/foo")
}

///|
test "WPT #169" {
  let result = @url.Url::parse("http://example.com/﻿/foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/%EF%BB%BF/foo")
}

///|
test "WPT #170" {
  let result = @url.Url::parse("http://example.com/‮/foo/‭/bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/%E2%80%AE/foo/%E2%80%AD/bar")
}

///|
test "WPT #171" {
  let result = @url.Url::parse("http://www.google.com/foo?bar=baz#")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.google.com/foo?bar=baz#")
}

///|
test "WPT #172" {
  let result = @url.Url::parse("http://www.google.com/foo?bar=baz# »")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.google.com/foo?bar=baz#%20%C2%BB")
}

///|
test "WPT #173" {
  let result = @url.Url::parse("data:test# »")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:test#%20%C2%BB")
}

///|
test "WPT #174" {
  let result = @url.Url::parse("http://www.google.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.google.com/")
}

///|
test "WPT #175" {
  let result = @url.Url::parse("http://192.0x00A80001")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://192.168.0.1/")
}

///|
test "WPT #176" {
  let result = @url.Url::parse("http://www/foo%2Ehtml")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www/foo%2Ehtml")
}

///|
test "WPT #177" {
  let result = @url.Url::parse("http://www/foo/%2E/html")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www/foo/html")
}

///|
test "WPT #178" {
  let result = @url.Url::parse("http://user:pass@/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #179" {
  let result = @url.Url::parse("http://%25DOMAIN:foobar@foodomain.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://%25DOMAIN:foobar@foodomain.com/")
}

///|
test "WPT #180" {
  let result = @url.Url::parse("http:\\\\www.google.com\\foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.google.com/foo")
}

///|
test "WPT #181" {
  let result = @url.Url::parse("http://foo:80/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo/")
}

///|
test "WPT #182" {
  let result = @url.Url::parse("http://foo:81/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo:81/")
}

///|
test "WPT #183" {
  let result = @url.Url::parse("httpa://foo:80/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "httpa://foo:80/")
}

///|
test "WPT #184" {
  let result = @url.Url::parse("http://foo:-80/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #185" {
  let result = @url.Url::parse("https://foo:443/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://foo/")
}

///|
test "WPT #186" {
  let result = @url.Url::parse("https://foo:80/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://foo:80/")
}

///|
test "WPT #187" {
  let result = @url.Url::parse("ftp://foo:21/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftp://foo/")
}

///|
test "WPT #188" {
  let result = @url.Url::parse("ftp://foo:80/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftp://foo:80/")
}

///|
test "WPT #189" {
  let result = @url.Url::parse("gopher://foo:70/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "gopher://foo:70/")
}

///|
test "WPT #190" {
  let result = @url.Url::parse("gopher://foo:443/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "gopher://foo:443/")
}

///|
test "WPT #191" {
  let result = @url.Url::parse("ws://foo:80/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://foo/")
}

///|
test "WPT #192" {
  let result = @url.Url::parse("ws://foo:81/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://foo:81/")
}

///|
test "WPT #193" {
  let result = @url.Url::parse("ws://foo:443/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://foo:443/")
}

///|
test "WPT #194" {
  let result = @url.Url::parse("ws://foo:815/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://foo:815/")
}

///|
test "WPT #195" {
  let result = @url.Url::parse("wss://foo:80/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://foo:80/")
}

///|
test "WPT #196" {
  let result = @url.Url::parse("wss://foo:81/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://foo:81/")
}

///|
test "WPT #197" {
  let result = @url.Url::parse("wss://foo:443/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://foo/")
}

///|
test "WPT #198" {
  let result = @url.Url::parse("wss://foo:815/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://foo:815/")
}

///|
test "WPT #199" {
  let result = @url.Url::parse("http:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/")
}

///|
test "WPT #200" {
  let result = @url.Url::parse("ftp:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftp://example.com/")
}

///|
test "WPT #201" {
  let result = @url.Url::parse("https:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://example.com/")
}

///|
test "WPT #202" {
  let result = @url.Url::parse("madeupscheme:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "madeupscheme:/example.com/")
}

///|
test "WPT #203" {
  let result = @url.Url::parse("file:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///example.com/")
}

///|
test "WPT #204" {
  let result = @url.Url::parse("ftps:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftps:/example.com/")
}

///|
test "WPT #205" {
  let result = @url.Url::parse("gopher:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "gopher:/example.com/")
}

///|
test "WPT #206" {
  let result = @url.Url::parse("ws:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://example.com/")
}

///|
test "WPT #207" {
  let result = @url.Url::parse("wss:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://example.com/")
}

///|
test "WPT #208" {
  let result = @url.Url::parse("data:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:/example.com/")
}

///|
test "WPT #209" {
  let result = @url.Url::parse("javascript:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "javascript:/example.com/")
}

///|
test "WPT #210" {
  let result = @url.Url::parse("mailto:/example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto:/example.com/")
}

///|
test "WPT #211" {
  let result = @url.Url::parse("http:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/")
}

///|
test "WPT #212" {
  let result = @url.Url::parse("ftp:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftp://example.com/")
}

///|
test "WPT #213" {
  let result = @url.Url::parse("https:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://example.com/")
}

///|
test "WPT #214" {
  let result = @url.Url::parse("madeupscheme:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "madeupscheme:example.com/")
}

///|
test "WPT #215" {
  let result = @url.Url::parse("ftps:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftps:example.com/")
}

///|
test "WPT #216" {
  let result = @url.Url::parse("gopher:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "gopher:example.com/")
}

///|
test "WPT #217" {
  let result = @url.Url::parse("ws:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ws://example.com/")
}

///|
test "WPT #218" {
  let result = @url.Url::parse("wss:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://example.com/")
}

///|
test "WPT #219" {
  let result = @url.Url::parse("data:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:example.com/")
}

///|
test "WPT #220" {
  let result = @url.Url::parse("javascript:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "javascript:example.com/")
}

///|
test "WPT #221" {
  let result = @url.Url::parse("mailto:example.com/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto:example.com/")
}

///|
test "WPT #222" {
  let result = @url.Url::parse("https://example.com/aaa/bbb/%2e%2e?query")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://example.com/aaa/?query")
}

///|
test "WPT #223" {
  let result = @url.Url::parse("http:@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/")
}

///|
test "WPT #224" {
  let result = @url.Url::parse("http:/@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/")
}

///|
test "WPT #225" {
  let result = @url.Url::parse("http://@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/")
}

///|
test "WPT #226" {
  let result = @url.Url::parse("http:a:b@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a:b@www.example.com/")
}

///|
test "WPT #227" {
  let result = @url.Url::parse("http:/a:b@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a:b@www.example.com/")
}

///|
test "WPT #228" {
  let result = @url.Url::parse("http://a:b@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a:b@www.example.com/")
}

///|
test "WPT #229" {
  let result = @url.Url::parse("http://@pple.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://pple.com/")
}

///|
test "WPT #230" {
  let result = @url.Url::parse("http::b@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://:b@www.example.com/")
}

///|
test "WPT #231" {
  let result = @url.Url::parse("http:/:b@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://:b@www.example.com/")
}

///|
test "WPT #232" {
  let result = @url.Url::parse("http://:b@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://:b@www.example.com/")
}

///|
test "WPT #233" {
  let result = @url.Url::parse("http:/:@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #234" {
  let result = @url.Url::parse("http://user@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #235" {
  let result = @url.Url::parse("http:@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #236" {
  let result = @url.Url::parse("http:/@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #237" {
  let result = @url.Url::parse("http://@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #238" {
  let result = @url.Url::parse("https:@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #239" {
  let result = @url.Url::parse("http:a:b@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #240" {
  let result = @url.Url::parse("http:/a:b@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #241" {
  let result = @url.Url::parse("http://a:b@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #242" {
  let result = @url.Url::parse("http::@/www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #243" {
  let result = @url.Url::parse("http:a:@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a@www.example.com/")
}

///|
test "WPT #244" {
  let result = @url.Url::parse("http:/a:@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a@www.example.com/")
}

///|
test "WPT #245" {
  let result = @url.Url::parse("http://a:@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://a@www.example.com/")
}

///|
test "WPT #246" {
  let result = @url.Url::parse("http://www.@pple.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.@pple.com/")
}

///|
test "WPT #247" {
  let result = @url.Url::parse("http:@:www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #248" {
  let result = @url.Url::parse("http:/@:www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #249" {
  let result = @url.Url::parse("http://@:www.example.com")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #250" {
  let result = @url.Url::parse("http://:@www.example.com")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/")
}

///|
test "WPT #251" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/")
}

///|
test "WPT #252" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/test.txt", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/test.txt")
}

///|
test "WPT #253" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(".", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/")
}

///|
test "WPT #254" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("..", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/")
}

///|
test "WPT #255" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("test.txt", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/test.txt")
}

///|
test "WPT #256" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("./test.txt", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/test.txt")
}

///|
test "WPT #257" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../test.txt", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/test.txt")
}

///|
test "WPT #258" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../aaa/test.txt", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/aaa/test.txt")
}

///|
test "WPT #259" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../../test.txt", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/test.txt")
}

///|
test "WPT #260" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("中/test.txt", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example.com/%E4%B8%AD/test.txt")
}

///|
test "WPT #261" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://www.example2.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example2.com/")
}

///|
test "WPT #262" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//www.example2.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.example2.com/")
}

///|
test "WPT #263" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:...", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///...")
}

///|
test "WPT #264" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:..", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #265" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:a", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///a")
}

///|
test "WPT #266" {
  let result = @url.Url::parse("file:.")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #267" {
  let base_url = @url.Url::parse("http://www.example.com/test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:.", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #268" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://ExAmPlE.CoM", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/")
}

///|
test "WPT #269" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://example example.com", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #270" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://Goo%20 goo%7C|.com", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #271" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #272" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[:]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #273" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://GOO 　goo.com", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #274" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://GOO​⁠﻿goo.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://googoo.com/")
}

///|
test "WPT #275" {
  let result = @url.Url::parse(
    "\u{0000}\u{001B}\u{0004}\u{0012} http://example.com/\u{001F} \r ",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.com/")
}

///|
test "WPT #276" {
  let result = @url.Url::parse("non-special:opaque  ")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:opaque")
}

///|
test "WPT #277" {
  let result = @url.Url::parse("non-special:opaque  ?hi")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:opaque %20?hi")
}

///|
test "WPT #278" {
  let result = @url.Url::parse("non-special:opaque  #hi")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:opaque %20#hi")
}

///|
test "WPT #279" {
  let result = @url.Url::parse("non-special:opaque  x?hi")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:opaque  x?hi")
}

///|
test "WPT #280" {
  let result = @url.Url::parse("non-special:opaque  x#hi")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:opaque  x#hi")
}

///|
test "WPT #281" {
  let result = @url.Url::parse("non-special:opaque \t\t  \t#hi")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:opaque  %20#hi")
}

///|
test "WPT #282" {
  let result = @url.Url::parse("non-special:opaque \t\t  #hi")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:opaque  %20#hi")
}

///|
test "WPT #283" {
  let result = @url.Url::parse("non-special:opaque\t\t  \r #hi")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:opaque  %20#hi")
}

///|
test "WPT #284" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://www.foo。bar.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://www.foo.bar.com/")
}

///|
test "WPT #285" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://﷐zyx.com", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #286" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://%ef%b7%90zyx.com", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #287" {
  let result = @url.Url::parse("https://�")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #288" {
  let result = @url.Url::parse("https://%EF%BF%BD")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #289" {
  let result = @url.Url::parse("https://x/�?�#�")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://x/%EF%BF%BD?%EF%BF%BD#%EF%BF%BD")
}

///|
test "WPT #290" {
  let result = @url.Url::parse("http://a.b.c.xn--pokxncvks")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #291" {
  let result = @url.Url::parse("http://10.0.0.xn--pokxncvks")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #292" {
  let result = @url.Url::parse("http://a.b.c.XN--pokxncvks")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #293" {
  let result = @url.Url::parse("http://a.b.c.Xn--pokxncvks")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #294" {
  let result = @url.Url::parse("http://10.0.0.XN--pokxncvks")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #295" {
  let result = @url.Url::parse("http://10.0.0.xN--pokxncvks")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #296" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://Ｇｏ.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://go.com/")
}

///|
test "WPT #297" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://％４１.com", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #298" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://%ef%bc%85%ef%bc%94%ef%bc%91.com",
    base=base_url,
  )
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #299" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://％００.com", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #300" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://%ef%bc%85%ef%bc%90%ef%bc%90.com",
    base=base_url,
  )
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #301" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://你好你好", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://xn--6qqa088eba/")
}

///|
test "WPT #302" {
  let result = @url.Url::parse("https://faß.ExAmPlE/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://xn--fa-hia.example/")
}

///|
test "WPT #303" {
  let result = @url.Url::parse("sc://faß.ExAmPlE/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://fa%C3%9F.ExAmPlE/")
}

///|
test "WPT #304" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://%zz%66%a.com", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #305" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://%25", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #306" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://hello%00", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #307" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://%30%78%63%30%2e%30%32%35%30.01",
    base=base_url,
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://192.168.0.1/")
}

///|
test "WPT #308" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://%30%78%63%30%2e%30%32%35%30.01%2e",
    base=base_url,
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://192.168.0.1/")
}

///|
test "WPT #309" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://192.168.0.257", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #310" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://%3g%78%63%30%2e%30%32%35%30%2E.01",
    base=base_url,
  )
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #311" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://192.168.0.1 hello", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #312" {
  let result = @url.Url::parse("https://x x:12")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #313" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://０Ｘｃ０．０２５０．０１",
    base=base_url,
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://192.168.0.1/")
}

///|
test "WPT #314" {
  let result = @url.Url::parse("http://./")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://./")
}

///|
test "WPT #315" {
  let result = @url.Url::parse("http://../")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://../")
}

///|
test "WPT #316" {
  let result = @url.Url::parse("h://.")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "h://.")
}

///|
test "WPT #317" {
  let result = @url.Url::parse("http://[www.google.com]/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #318" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[google.com]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #319" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::1.2.3.4x]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #320" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::1.2.3.]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #321" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::1.2.]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #322" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::.1.2]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #323" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::1.]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #324" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::.1]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #325" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[::%31]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #326" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://%5B::1]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #327" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://foo:💩@example.com/bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo:%F0%9F%92%A9@example.com/bar")
}

///|
test "WPT #328" {
  let base_url = @url.Url::parse("test:test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "test:test#")
}

///|
test "WPT #329" {
  let base_url = @url.Url::parse("mailto:x@x.com")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto:x@x.com#x")
}

///|
test "WPT #330" {
  let base_url = @url.Url::parse("data:,")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:,#x")
}

///|
test "WPT #331" {
  let base_url = @url.Url::parse("about:blank")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "about:blank#x")
}

///|
test "WPT #332" {
  let base_url = @url.Url::parse("about:blank")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#x:y", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "about:blank#x:y")
}

///|
test "WPT #333" {
  let base_url = @url.Url::parse("test:test?test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "test:test?test#")
}

///|
test "WPT #334" {
  let base_url = @url.Url::parse("http://doesnotmatter/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("https://@test@test@example:800/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://%40test%40test@example:800/")
}

///|
test "WPT #335" {
  let base_url = @url.Url::parse("http://doesnotmatter/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("https://@@@example", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://%40%40@example/")
}

///|
test "WPT #336" {
  let base_url = @url.Url::parse("http://doesnotmatter/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://`{}:`{}@h/`{}?`{}", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://%60%7B%7D:%60%7B%7D@h/%60%7B%7D?`{}")
}

///|
test "WPT #337" {
  let result = @url.Url::parse("http://host/?'")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://host/?%27")
}

///|
test "WPT #338" {
  let result = @url.Url::parse("notspecial://host/?'")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "notspecial://host/?'")
}

///|
test "WPT #339" {
  let base_url = @url.Url::parse("http://user@example.org/smth")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/some/path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://user@example.org/some/path")
}

///|
test "WPT #340" {
  let base_url = @url.Url::parse("http://user:pass@example.org:21/smth")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://user:pass@example.org:21/smth")
}

///|
test "WPT #341" {
  let base_url = @url.Url::parse("http://user:pass@example.org:21/smth")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/some/path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://user:pass@example.org:21/some/path")
}

///|
test "WPT #342" {
  let base_url = @url.Url::parse("sc:sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("i", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #343" {
  let base_url = @url.Url::parse("sc:sd/sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("i", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #344" {
  let base_url = @url.Url::parse("sc:/pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:/pa/i")
}

///|
test "WPT #345" {
  let base_url = @url.Url::parse("sc://ho/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://ho/i")
}

///|
test "WPT #346" {
  let base_url = @url.Url::parse("sc:///pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:///pa/i")
}

///|
test "WPT #347" {
  let base_url = @url.Url::parse("sc:sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../i", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #348" {
  let base_url = @url.Url::parse("sc:sd/sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../i", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #349" {
  let base_url = @url.Url::parse("sc:/pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:/i")
}

///|
test "WPT #350" {
  let base_url = @url.Url::parse("sc://ho/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://ho/i")
}

///|
test "WPT #351" {
  let base_url = @url.Url::parse("sc:///pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:///i")
}

///|
test "WPT #352" {
  let base_url = @url.Url::parse("sc:sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/i", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #353" {
  let base_url = @url.Url::parse("sc:sd/sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/i", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #354" {
  let base_url = @url.Url::parse("sc:/pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:/i")
}

///|
test "WPT #355" {
  let base_url = @url.Url::parse("sc://ho/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://ho/i")
}

///|
test "WPT #356" {
  let base_url = @url.Url::parse("sc:///pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:///i")
}

///|
test "WPT #357" {
  let base_url = @url.Url::parse("sc:sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?i", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #358" {
  let base_url = @url.Url::parse("sc:sd/sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?i", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #359" {
  let base_url = @url.Url::parse("sc:/pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:/pa/pa?i")
}

///|
test "WPT #360" {
  let base_url = @url.Url::parse("sc://ho/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://ho/pa?i")
}

///|
test "WPT #361" {
  let base_url = @url.Url::parse("sc:///pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:///pa/pa?i")
}

///|
test "WPT #362" {
  let base_url = @url.Url::parse("sc:sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:sd#i")
}

///|
test "WPT #363" {
  let base_url = @url.Url::parse("sc:sd/sd")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:sd/sd#i")
}

///|
test "WPT #364" {
  let base_url = @url.Url::parse("sc:/pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:/pa/pa#i")
}

///|
test "WPT #365" {
  let base_url = @url.Url::parse("sc://ho/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://ho/pa#i")
}

///|
test "WPT #366" {
  let base_url = @url.Url::parse("sc:///pa/pa")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#i", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:///pa/pa#i")
}

///|
test "WPT #367" {
  let result = @url.Url::parse("about:/../")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "about:/")
}

///|
test "WPT #368" {
  let result = @url.Url::parse("data:/../")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:/")
}

///|
test "WPT #369" {
  let result = @url.Url::parse("javascript:/../")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "javascript:/")
}

///|
test "WPT #370" {
  let result = @url.Url::parse("mailto:/../")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto:/")
}

///|
test "WPT #371" {
  let result = @url.Url::parse("sc://ñ.test/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://%C3%B1.test/")
}

///|
test "WPT #372" {
  let result = @url.Url::parse("sc://%/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://%/")
}

///|
test "WPT #373" {
  let result = @url.Url::parse("sc://@/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #374" {
  let result = @url.Url::parse("sc://te@s:t@/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #375" {
  let result = @url.Url::parse("sc://:/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #376" {
  let result = @url.Url::parse("sc://:12/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #377" {
  let base_url = @url.Url::parse("sc://ñ")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://%C3%B1/x")
}

///|
test "WPT #378" {
  let result = @url.Url::parse("sc:\\../")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:\\../")
}

///|
test "WPT #379" {
  let result = @url.Url::parse("sc::a@example.net")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc::a@example.net")
}

///|
test "WPT #380" {
  let result = @url.Url::parse("wow:%NBD")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wow:%NBD")
}

///|
test "WPT #381" {
  let result = @url.Url::parse("wow:%1G")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wow:%1G")
}

///|
test "WPT #382" {
  let result = @url.Url::parse("wow:￿")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wow:%EF%BF%BF")
}

///|
test "WPT #383" {
  let result = @url.Url::parse("sc://a\u{0000}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #384" {
  let result = @url.Url::parse("sc://a b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #385" {
  let result = @url.Url::parse("sc://a<b")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #386" {
  let result = @url.Url::parse("sc://a>b")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #387" {
  let result = @url.Url::parse("sc://a[b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #388" {
  let result = @url.Url::parse("sc://a\\b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #389" {
  let result = @url.Url::parse("sc://a]b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #390" {
  let result = @url.Url::parse("sc://a^b")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #391" {
  let result = @url.Url::parse("sc://a|b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #392" {
  let result = @url.Url::parse("foo://ho\tst/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo://host/")
}

///|
test "WPT #393" {
  let result = @url.Url::parse("foo://ho\nst/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo://host/")
}

///|
test "WPT #394" {
  let result = @url.Url::parse("foo://ho\rst/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo://host/")
}

///|
test "WPT #395" {
  let result = @url.Url::parse("http://a\u{0000}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #396" {
  let result = @url.Url::parse("http://a\u{0001}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #397" {
  let result = @url.Url::parse("http://a\u{0002}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #398" {
  let result = @url.Url::parse("http://a\u{0003}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #399" {
  let result = @url.Url::parse("http://a\u{0004}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #400" {
  let result = @url.Url::parse("http://a\u{0005}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #401" {
  let result = @url.Url::parse("http://a\u{0006}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #402" {
  let result = @url.Url::parse("http://a\u{0007}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #403" {
  let result = @url.Url::parse("http://a\u{0008}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #404" {
  let result = @url.Url::parse("http://a\u{000B}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #405" {
  let result = @url.Url::parse("http://a\u{000C}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #406" {
  let result = @url.Url::parse("http://a\u{000E}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #407" {
  let result = @url.Url::parse("http://a\u{000F}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #408" {
  let result = @url.Url::parse("http://a\u{0010}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #409" {
  let result = @url.Url::parse("http://a\u{0011}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #410" {
  let result = @url.Url::parse("http://a\u{0012}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #411" {
  let result = @url.Url::parse("http://a\u{0013}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #412" {
  let result = @url.Url::parse("http://a\u{0014}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #413" {
  let result = @url.Url::parse("http://a\u{0015}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #414" {
  let result = @url.Url::parse("http://a\u{0016}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #415" {
  let result = @url.Url::parse("http://a\u{0017}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #416" {
  let result = @url.Url::parse("http://a\u{0018}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #417" {
  let result = @url.Url::parse("http://a\u{0019}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #418" {
  let result = @url.Url::parse("http://a\u{001A}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #419" {
  let result = @url.Url::parse("http://a\u{001B}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #420" {
  let result = @url.Url::parse("http://a\u{001C}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #421" {
  let result = @url.Url::parse("http://a\u{001D}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #422" {
  let result = @url.Url::parse("http://a\u{001E}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #423" {
  let result = @url.Url::parse("http://a\u{001F}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #424" {
  let result = @url.Url::parse("http://a b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #425" {
  let result = @url.Url::parse("http://a%b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #426" {
  let result = @url.Url::parse("http://a<b")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #427" {
  let result = @url.Url::parse("http://a>b")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #428" {
  let result = @url.Url::parse("http://a[b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #429" {
  let result = @url.Url::parse("http://a]b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #430" {
  let result = @url.Url::parse("http://a^b")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #431" {
  let result = @url.Url::parse("http://a|b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #432" {
  let result = @url.Url::parse("http://a\u{007F}b/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #433" {
  let result = @url.Url::parse("http://ho\tst/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://host/")
}

///|
test "WPT #434" {
  let result = @url.Url::parse("http://ho\nst/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://host/")
}

///|
test "WPT #435" {
  let result = @url.Url::parse("http://ho\rst/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://host/")
}

///|
test "WPT #436" {
  let result = @url.Url::parse("http://ho%00st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #437" {
  let result = @url.Url::parse("http://ho%01st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #438" {
  let result = @url.Url::parse("http://ho%02st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #439" {
  let result = @url.Url::parse("http://ho%03st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #440" {
  let result = @url.Url::parse("http://ho%04st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #441" {
  let result = @url.Url::parse("http://ho%05st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #442" {
  let result = @url.Url::parse("http://ho%06st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #443" {
  let result = @url.Url::parse("http://ho%07st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #444" {
  let result = @url.Url::parse("http://ho%08st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #445" {
  let result = @url.Url::parse("http://ho%09st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #446" {
  let result = @url.Url::parse("http://ho%0Ast/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #447" {
  let result = @url.Url::parse("http://ho%0Bst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #448" {
  let result = @url.Url::parse("http://ho%0Cst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #449" {
  let result = @url.Url::parse("http://ho%0Dst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #450" {
  let result = @url.Url::parse("http://ho%0Est/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #451" {
  let result = @url.Url::parse("http://ho%0Fst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #452" {
  let result = @url.Url::parse("http://ho%10st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #453" {
  let result = @url.Url::parse("http://ho%11st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #454" {
  let result = @url.Url::parse("http://ho%12st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #455" {
  let result = @url.Url::parse("http://ho%13st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #456" {
  let result = @url.Url::parse("http://ho%14st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #457" {
  let result = @url.Url::parse("http://ho%15st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #458" {
  let result = @url.Url::parse("http://ho%16st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #459" {
  let result = @url.Url::parse("http://ho%17st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #460" {
  let result = @url.Url::parse("http://ho%18st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #461" {
  let result = @url.Url::parse("http://ho%19st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #462" {
  let result = @url.Url::parse("http://ho%1Ast/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #463" {
  let result = @url.Url::parse("http://ho%1Bst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #464" {
  let result = @url.Url::parse("http://ho%1Cst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #465" {
  let result = @url.Url::parse("http://ho%1Dst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #466" {
  let result = @url.Url::parse("http://ho%1Est/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #467" {
  let result = @url.Url::parse("http://ho%1Fst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #468" {
  let result = @url.Url::parse("http://ho%20st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #469" {
  let result = @url.Url::parse("http://ho%23st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #470" {
  let result = @url.Url::parse("http://ho%25st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #471" {
  let result = @url.Url::parse("http://ho%2Fst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #472" {
  let result = @url.Url::parse("http://ho%3Ast/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #473" {
  let result = @url.Url::parse("http://ho%3Cst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #474" {
  let result = @url.Url::parse("http://ho%3Est/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #475" {
  let result = @url.Url::parse("http://ho%3Fst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #476" {
  let result = @url.Url::parse("http://ho%40st/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #477" {
  let result = @url.Url::parse("http://ho%5Bst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #478" {
  let result = @url.Url::parse("http://ho%5Cst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #479" {
  let result = @url.Url::parse("http://ho%5Dst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #480" {
  let result = @url.Url::parse("http://ho%7Cst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #481" {
  let result = @url.Url::parse("http://ho%7Fst/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #482" {
  let result = @url.Url::parse("http://!\"$&'()*+,-.;=_`{}~/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://!\"$&'()*+,-.;=_`{}~/")
}

///|
test "WPT #483" {
  let result = @url.Url::parse(
    "sc://\u{0001}\u{0002}\u{0003}\u{0004}\u{0005}\u{0006}\u{0007}\u{0008}\u{000B}\u{000C}\u{000E}\u{000F}\u{0010}\u{0011}\u{0012}\u{0013}\u{0014}\u{0015}\u{0016}\u{0017}\u{0018}\u{0019}\u{001A}\u{001B}\u{001C}\u{001D}\u{001E}\u{001F}\u{007F}!\"$%&'()*+,-.;=_`{}~/",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "sc://%01%02%03%04%05%06%07%08%0B%0C%0E%0F%10%11%12%13%14%15%16%17%18%19%1A%1B%1C%1D%1E%1F%7F!\"$%&'()*+,-.;=_`{}~/",
  )
}

///|
test "WPT #484" {
  let result = @url.Url::parse("ftp://example.com%80/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #485" {
  let result = @url.Url::parse("ftp://example.com%A0/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #486" {
  let result = @url.Url::parse("https://example.com%80/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #487" {
  let result = @url.Url::parse("https://example.com%A0/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #488" {
  let result = @url.Url::parse("ftp://%e2%98%83")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ftp://xn--n3h/")
}

///|
test "WPT #489" {
  let result = @url.Url::parse("https://%e2%98%83")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://xn--n3h/")
}

///|
test "WPT #490" {
  let result = @url.Url::parse("http://127.0.0.1:10100/relative_import.html")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://127.0.0.1:10100/relative_import.html")
}

///|
test "WPT #491" {
  let result = @url.Url::parse("http://facebook.com/?foo=%7B%22abc%22")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://facebook.com/?foo=%7B%22abc%22")
}

///|
test "WPT #492" {
  let result = @url.Url::parse("https://localhost:3000/jqueryui@1.2.3")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://localhost:3000/jqueryui@1.2.3")
}

///|
test "WPT #493" {
  let result = @url.Url::parse(
    "h\tt\nt\rp://h\to\ns\rt:9\t0\n0\r0/p\ta\nt\rh?q\tu\ne\rry#f\tr\na\rg",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://host:9000/path?query#frag")
}

///|
test "WPT #494" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?a=b&c=d", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar?a=b&c=d")
}

///|
test "WPT #495" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("??a=b&c=d", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar??a=b&c=d")
}

///|
test "WPT #496" {
  let base_url = @url.Url::parse("http://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http:", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/foo/bar")
}

///|
test "WPT #497" {
  let base_url = @url.Url::parse("https://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http:", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #498" {
  let base_url = @url.Url::parse("https://example.org/foo/bar")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("sc:", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:")
}

///|
test "WPT #499" {
  let result = @url.Url::parse("http://foo.bar/baz?qux#foo\u{0008}bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.bar/baz?qux#foo%08bar")
}

///|
test "WPT #500" {
  let result = @url.Url::parse("http://foo.bar/baz?qux#foo\"bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.bar/baz?qux#foo%22bar")
}

///|
test "WPT #501" {
  let result = @url.Url::parse("http://foo.bar/baz?qux#foo<bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.bar/baz?qux#foo%3Cbar")
}

///|
test "WPT #502" {
  let result = @url.Url::parse("http://foo.bar/baz?qux#foo>bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.bar/baz?qux#foo%3Ebar")
}

///|
test "WPT #503" {
  let result = @url.Url::parse("http://foo.bar/baz?qux#foo`bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.bar/baz?qux#foo%60bar")
}

///|
test "WPT #504" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://1.2.3.4/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://1.2.3.4/")
}

///|
test "WPT #505" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://1.2.3.4./", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://1.2.3.4/")
}

///|
test "WPT #506" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://192.168.257", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://192.168.1.1/")
}

///|
test "WPT #507" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://192.168.257.", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://192.168.1.1/")
}

///|
test "WPT #508" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://192.168.257.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://192.168.257.com/")
}

///|
test "WPT #509" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://256", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://0.0.1.0/")
}

///|
test "WPT #510" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://256.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://256.com/")
}

///|
test "WPT #511" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://999999999", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://59.154.201.255/")
}

///|
test "WPT #512" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://999999999.", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://59.154.201.255/")
}

///|
test "WPT #513" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://999999999.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://999999999.com/")
}

///|
test "WPT #514" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://10000000000", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #515" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://10000000000.com", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://10000000000.com/")
}

///|
test "WPT #516" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://4294967295", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://255.255.255.255/")
}

///|
test "WPT #517" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://4294967296", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #518" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://0xffffffff", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://255.255.255.255/")
}

///|
test "WPT #519" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://0xffffffff1", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #520" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://256.256.256.256", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #521" {
  let result = @url.Url::parse("https://0x.0x.0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://0.0.0.0/")
}

///|
test "WPT #522" {
  let result = @url.Url::parse("https://0x100000000/test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #523" {
  let result = @url.Url::parse("https://256.0.0.1/test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #524" {
  let result = @url.Url::parse("file:///C%3A/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C%3A/")
}

///|
test "WPT #525" {
  let result = @url.Url::parse("file:///C%7C/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C%7C/")
}

///|
test "WPT #526" {
  let result = @url.Url::parse("file://%43%3A")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #527" {
  let result = @url.Url::parse("file://%43%7C")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #528" {
  let result = @url.Url::parse("file://%43|")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #529" {
  let result = @url.Url::parse("file://C%7C")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #530" {
  let result = @url.Url::parse("file://%43%7C/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #531" {
  let result = @url.Url::parse("https://%43%7C/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #532" {
  let result = @url.Url::parse("asdf://%43|/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #533" {
  let result = @url.Url::parse("asdf://%43%7C/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "asdf://%43%7C/")
}

///|
test "WPT #534" {
  let base_url = @url.Url::parse(
    "file:///C:/Users/Domenic/Dropbox/GitHub/tmpvar/jsdom/test/level2/html/files/anchor.html",
  )
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("pix/submit.gif", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "file:///C:/Users/Domenic/Dropbox/GitHub/tmpvar/jsdom/test/level2/html/files/pix/submit.gif",
  )
}

///|
test "WPT #535" {
  let base_url = @url.Url::parse("file:///C:/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("..", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/")
}

///|
test "WPT #536" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("..", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #537" {
  let base_url = @url.Url::parse("file:///C:/a/b")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/")
}

///|
test "WPT #538" {
  let base_url = @url.Url::parse("file://h/C:/a/b")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://h/C:/")
}

///|
test "WPT #539" {
  let base_url = @url.Url::parse("file://h/a/b")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://h/")
}

///|
test "WPT #540" {
  let base_url = @url.Url::parse("file:///C:/a/b")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//d:", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///d:")
}

///|
test "WPT #541" {
  let base_url = @url.Url::parse("file:///C:/a/b")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//d:/..", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///d:/")
}

///|
test "WPT #542" {
  let base_url = @url.Url::parse("file:///ab:/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("..", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #543" {
  let base_url = @url.Url::parse("file:///1:/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("..", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #544" {
  let base_url = @url.Url::parse("file:///test?test#test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///test?test")
}

///|
test "WPT #545" {
  let base_url = @url.Url::parse("file:///test?test#test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///test?test")
}

///|
test "WPT #546" {
  let base_url = @url.Url::parse("file:///test?test#test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///test?x")
}

///|
test "WPT #547" {
  let base_url = @url.Url::parse("file:///test?test#test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:?x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///test?x")
}

///|
test "WPT #548" {
  let base_url = @url.Url::parse("file:///test?test#test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///test?test#x")
}

///|
test "WPT #549" {
  let base_url = @url.Url::parse("file:///test?test#test")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:#x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///test?test#x")
}

///|
test "WPT #550" {
  let result = @url.Url::parse("file:\\\\//")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////")
}

///|
test "WPT #551" {
  let result = @url.Url::parse("file:\\\\\\\\")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////")
}

///|
test "WPT #552" {
  let result = @url.Url::parse("file:\\\\\\\\?fox")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////?fox")
}

///|
test "WPT #553" {
  let result = @url.Url::parse("file:\\\\\\\\#guppy")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////#guppy")
}

///|
test "WPT #554" {
  let result = @url.Url::parse("file://spider///")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://spider///")
}

///|
test "WPT #555" {
  let result = @url.Url::parse("file:\\\\localhost//")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////")
}

///|
test "WPT #556" {
  let result = @url.Url::parse("file:///localhost//cat")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///localhost//cat")
}

///|
test "WPT #557" {
  let result = @url.Url::parse("file://\\/localhost//cat")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////localhost//cat")
}

///|
test "WPT #558" {
  let result = @url.Url::parse("file://localhost//a//../..//")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://///")
}

///|
test "WPT #559" {
  let base_url = @url.Url::parse("file:///elephant")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/////mouse", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://///mouse")
}

///|
test "WPT #560" {
  let base_url = @url.Url::parse("file://lion/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("\\//pig", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///pig")
}

///|
test "WPT #561" {
  let base_url = @url.Url::parse("file://lion/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("\\/localhost//pig", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////pig")
}

///|
test "WPT #562" {
  let base_url = @url.Url::parse("file://lion/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//localhost//pig", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////pig")
}

///|
test "WPT #563" {
  let base_url = @url.Url::parse("file://lion/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/..//localhost//pig", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://lion//localhost//pig")
}

///|
test "WPT #564" {
  let base_url = @url.Url::parse("file://ape/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file://", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #565" {
  let base_url = @url.Url::parse("file://tea/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/rooibos", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://tea/rooibos")
}

///|
test "WPT #566" {
  let base_url = @url.Url::parse("file://tea/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/?chai", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://tea/?chai")
}

///|
test "WPT #567" {
  let base_url = @url.Url::parse("file://host/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:")
}

///|
test "WPT #568" {
  let base_url = @url.Url::parse("file://host/D:/dir1/dir2/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:")
}

///|
test "WPT #569" {
  let base_url = @url.Url::parse("file://host/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|#", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:#")
}

///|
test "WPT #570" {
  let base_url = @url.Url::parse("file://host/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|?", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:?")
}

///|
test "WPT #571" {
  let base_url = @url.Url::parse("file://host/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:/")
}

///|
test "WPT #572" {
  let base_url = @url.Url::parse("file://host/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|\n/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:/")
}

///|
test "WPT #573" {
  let base_url = @url.Url::parse("file://host/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|\\", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:/")
}

///|
test "WPT #574" {
  let base_url = @url.Url::parse("file://host/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/dir/C")
}

///|
test "WPT #575" {
  let base_url = @url.Url::parse("file://host/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|a", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/dir/C|a")
}

///|
test "WPT #576" {
  let base_url = @url.Url::parse("file:///c:/baz/qux")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/c:/foo/bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///c:/foo/bar")
}

///|
test "WPT #577" {
  let base_url = @url.Url::parse("file:///c:/baz/qux")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/c|/foo/bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///c:/foo/bar")
}

///|
test "WPT #578" {
  let base_url = @url.Url::parse("file:///c:/baz/qux")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:\\c:\\foo\\bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///c:/foo/bar")
}

///|
test "WPT #579" {
  let base_url = @url.Url::parse("file://host/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/c:/foo/bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/c:/foo/bar")
}

///|
test "WPT #580" {
  let result = @url.Url::parse("file://example.net/C:/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://example.net/C:/")
}

///|
test "WPT #581" {
  let result = @url.Url::parse("file://1.2.3.4/C:/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://1.2.3.4/C:/")
}

///|
test "WPT #582" {
  let result = @url.Url::parse("file://[1::8]/C:/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://[1::8]/C:/")
}

///|
test "WPT #583" {
  let base_url = @url.Url::parse("file://host/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("C|/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:/")
}

///|
test "WPT #584" {
  let base_url = @url.Url::parse("file://host/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/C:/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:/")
}

///|
test "WPT #585" {
  let base_url = @url.Url::parse("file://host/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:C:/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:/")
}

///|
test "WPT #586" {
  let base_url = @url.Url::parse("file://host/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:/C:/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://host/C:/")
}

///|
test "WPT #587" {
  let base_url = @url.Url::parse("file://host/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//C:/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/")
}

///|
test "WPT #588" {
  let base_url = @url.Url::parse("file://host/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file://C:/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/")
}

///|
test "WPT #589" {
  let base_url = @url.Url::parse("file://host/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///C:/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/")
}

///|
test "WPT #590" {
  let base_url = @url.Url::parse("file://host/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:///C:/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/")
}

///|
test "WPT #591" {
  let result = @url.Url::parse("file:/C|/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/")
}

///|
test "WPT #592" {
  let result = @url.Url::parse("file://C|/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///C:/")
}

///|
test "WPT #593" {
  let result = @url.Url::parse("file:")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #594" {
  let result = @url.Url::parse("file:?q=v")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///?q=v")
}

///|
test "WPT #595" {
  let result = @url.Url::parse("file:#frag")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///#frag")
}

///|
test "WPT #596" {
  let result = @url.Url::parse("file:///Y:")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///Y:")
}

///|
test "WPT #597" {
  let result = @url.Url::parse("file:///Y:/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///Y:/")
}

///|
test "WPT #598" {
  let result = @url.Url::parse("file:///./Y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///Y")
}

///|
test "WPT #599" {
  let result = @url.Url::parse("file:///./Y:")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///Y:")
}

///|
test "WPT #600" {
  let result = @url.Url::parse("\\\\\\.\\Y:")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #601" {
  let result = @url.Url::parse("file:///y:")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///y:")
}

///|
test "WPT #602" {
  let result = @url.Url::parse("file:///y:/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///y:/")
}

///|
test "WPT #603" {
  let result = @url.Url::parse("file:///./y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///y")
}

///|
test "WPT #604" {
  let result = @url.Url::parse("file:///./y:")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///y:")
}

///|
test "WPT #605" {
  let result = @url.Url::parse("\\\\\\.\\y:")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #606" {
  let result = @url.Url::parse("file://localhost//a//../..//foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://///foo")
}

///|
test "WPT #607" {
  let result = @url.Url::parse("file://localhost////foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://////foo")
}

///|
test "WPT #608" {
  let result = @url.Url::parse("file:////foo")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////foo")
}

///|
test "WPT #609" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:///one/two", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///one/two")
}

///|
test "WPT #610" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:////one/two", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////one/two")
}

///|
test "WPT #611" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//one/two", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://one/two")
}

///|
test "WPT #612" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///one/two", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///one/two")
}

///|
test "WPT #613" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("////one/two", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////one/two")
}

///|
test "WPT #614" {
  let base_url = @url.Url::parse("file:////")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("file:///.//", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////")
}

///|
test "WPT #615" {
  let result = @url.Url::parse("file:.//p")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////p")
}

///|
test "WPT #616" {
  let result = @url.Url::parse("file:/.//p")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:////p")
}

///|
test "WPT #617" {
  let base_url = @url.Url::parse("http://example.net/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[1:0::]", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://[1::]/")
}

///|
test "WPT #618" {
  let base_url = @url.Url::parse("http://example.net/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://[0:1:2:3:4:5:6:7:8]", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #619" {
  let result = @url.Url::parse("https://[0::0::0]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #620" {
  let result = @url.Url::parse("https://[0:.0]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #621" {
  let result = @url.Url::parse("https://[0:0:]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #622" {
  let result = @url.Url::parse("https://[0:1:2:3:4:5:6:7.0.0.0.1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #623" {
  let result = @url.Url::parse("https://[0:1.00.0.0.0]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #624" {
  let result = @url.Url::parse("https://[0:1.290.0.0.0]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #625" {
  let result = @url.Url::parse("https://[0:1.23.23]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #626" {
  let result = @url.Url::parse("http://?")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #627" {
  let result = @url.Url::parse("http://#")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #628" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:4294967377/c", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #629" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://f:18446744073709551697/c", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #630" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "http://f:340282366920938463463374607431768211537/c",
    base=base_url,
  )
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #631" {
  let result = @url.Url::parse("sc://ñ")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://%C3%B1")
}

///|
test "WPT #632" {
  let result = @url.Url::parse("sc://ñ?x")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://%C3%B1?x")
}

///|
test "WPT #633" {
  let result = @url.Url::parse("sc://ñ#x")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://%C3%B1#x")
}

///|
test "WPT #634" {
  let base_url = @url.Url::parse("sc://ñ")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://%C3%B1#x")
}

///|
test "WPT #635" {
  let base_url = @url.Url::parse("sc://ñ")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("?x", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://%C3%B1?x")
}

///|
test "WPT #636" {
  let result = @url.Url::parse("sc://?")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://?")
}

///|
test "WPT #637" {
  let result = @url.Url::parse("sc://#")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc://#")
}

///|
test "WPT #638" {
  let base_url = @url.Url::parse("sc://x/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:///")
}

///|
test "WPT #639" {
  let base_url = @url.Url::parse("sc://x/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("////", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:////")
}

///|
test "WPT #640" {
  let base_url = @url.Url::parse("sc://x/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("////x/", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "sc:////x/")
}

///|
test "WPT #641" {
  let result = @url.Url::parse("tftp://foobar.com/someconfig;mode=netascii")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "tftp://foobar.com/someconfig;mode=netascii")
}

///|
test "WPT #642" {
  let result = @url.Url::parse("telnet://user:pass@foobar.com:23/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "telnet://user:pass@foobar.com:23/")
}

///|
test "WPT #643" {
  let result = @url.Url::parse("ut2004://10.10.10.10:7777/Index.ut2")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ut2004://10.10.10.10:7777/Index.ut2")
}

///|
test "WPT #644" {
  let result = @url.Url::parse(
    "redis://foo:bar@somehost:6379/0?baz=bam&qux=baz",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "redis://foo:bar@somehost:6379/0?baz=bam&qux=baz")
}

///|
test "WPT #645" {
  let result = @url.Url::parse("rsync://foo@host:911/sup")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "rsync://foo@host:911/sup")
}

///|
test "WPT #646" {
  let result = @url.Url::parse("git://github.com/foo/bar.git")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "git://github.com/foo/bar.git")
}

///|
test "WPT #647" {
  let result = @url.Url::parse("irc://myserver.com:6999/channel?passwd")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "irc://myserver.com:6999/channel?passwd")
}

///|
test "WPT #648" {
  let result = @url.Url::parse("dns://fw.example.org:9999/foo.bar.org?type=TXT")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "dns://fw.example.org:9999/foo.bar.org?type=TXT")
}

///|
test "WPT #649" {
  let result = @url.Url::parse("ldap://localhost:389/ou=People,o=JNDITutorial")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "ldap://localhost:389/ou=People,o=JNDITutorial")
}

///|
test "WPT #650" {
  let result = @url.Url::parse("git+https://github.com/foo/bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "git+https://github.com/foo/bar")
}

///|
test "WPT #651" {
  let result = @url.Url::parse("urn:ietf:rfc:2648")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "urn:ietf:rfc:2648")
}

///|
test "WPT #652" {
  let result = @url.Url::parse("tag:joe@example.org,2001:foo/bar")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "tag:joe@example.org,2001:foo/bar")
}

///|
test "WPT #653" {
  let result = @url.Url::parse("non-spec:/.//")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//")
}

///|
test "WPT #654" {
  let result = @url.Url::parse("non-spec:/..//")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//")
}

///|
test "WPT #655" {
  let result = @url.Url::parse("non-spec:/a/..//")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//")
}

///|
test "WPT #656" {
  let result = @url.Url::parse("non-spec:/.//path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//path")
}

///|
test "WPT #657" {
  let result = @url.Url::parse("non-spec:/..//path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//path")
}

///|
test "WPT #658" {
  let result = @url.Url::parse("non-spec:/a/..//path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//path")
}

///|
test "WPT #659" {
  let base_url = @url.Url::parse("non-spec:/p")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/.//path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//path")
}

///|
test "WPT #660" {
  let base_url = @url.Url::parse("non-spec:/p")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/..//path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//path")
}

///|
test "WPT #661" {
  let base_url = @url.Url::parse("non-spec:/p")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("..//path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//path")
}

///|
test "WPT #662" {
  let base_url = @url.Url::parse("non-spec:/p")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("a/..//path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//path")
}

///|
test "WPT #663" {
  let base_url = @url.Url::parse("non-spec:/..//p")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//p")
}

///|
test "WPT #664" {
  let base_url = @url.Url::parse("non-spec:/..//p")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/.//path")
}

///|
test "WPT #665" {
  let base_url = @url.Url::parse("non-spec:/.//p")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("../path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/path")
}

///|
test "WPT #666" {
  let result = @url.Url::parse("non-special://%E2%80%A0/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special://%E2%80%A0/")
}

///|
test "WPT #667" {
  let result = @url.Url::parse("non-special://H%4fSt/path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special://H%4fSt/path")
}

///|
test "WPT #668" {
  let result = @url.Url::parse("non-special://[1:2:0:0:5:0:0:0]/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special://[1:2:0:0:5::]/")
}

///|
test "WPT #669" {
  let result = @url.Url::parse("non-special://[1:2:0:0:0:0:0:3]/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special://[1:2::3]/")
}

///|
test "WPT #670" {
  let result = @url.Url::parse("non-special://[1:2::3]:80/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special://[1:2::3]:80/")
}

///|
test "WPT #671" {
  let result = @url.Url::parse("non-special://[:80/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #672" {
  let result = @url.Url::parse("blob:https://example.com:443/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:https://example.com:443/")
}

///|
test "WPT #673" {
  let result = @url.Url::parse("blob:http://example.org:88/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:http://example.org:88/")
}

///|
test "WPT #674" {
  let result = @url.Url::parse("blob:d3958f5c-0777-0845-9dcf-2cb28783acaf")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:d3958f5c-0777-0845-9dcf-2cb28783acaf")
}

///|
test "WPT #675" {
  let result = @url.Url::parse("blob:")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:")
}

///|
test "WPT #676" {
  let result = @url.Url::parse("blob:blob:")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:blob:")
}

///|
test "WPT #677" {
  let result = @url.Url::parse("blob:blob:https://example.org/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:blob:https://example.org/")
}

///|
test "WPT #678" {
  let result = @url.Url::parse("blob:about:blank")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:about:blank")
}

///|
test "WPT #679" {
  let result = @url.Url::parse("blob:file://host/path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:file://host/path")
}

///|
test "WPT #680" {
  let result = @url.Url::parse("blob:ftp://host/path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:ftp://host/path")
}

///|
test "WPT #681" {
  let result = @url.Url::parse("blob:ws://example.org/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:ws://example.org/")
}

///|
test "WPT #682" {
  let result = @url.Url::parse("blob:wss://example.org/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:wss://example.org/")
}

///|
test "WPT #683" {
  let result = @url.Url::parse("blob:http%3a//example.org/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "blob:http%3a//example.org/")
}

///|
test "WPT #684" {
  let result = @url.Url::parse("http://0x7f.0.0.0x7g")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://0x7f.0.0.0x7g/")
}

///|
test "WPT #685" {
  let result = @url.Url::parse("http://0X7F.0.0.0X7G")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://0x7f.0.0.0x7g/")
}

///|
test "WPT #686" {
  let result = @url.Url::parse("http://[::127.0.0.0.1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #687" {
  let result = @url.Url::parse("http://[0:1:0:1:0:1:0:1]")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://[0:1:0:1:0:1:0:1]/")
}

///|
test "WPT #688" {
  let result = @url.Url::parse("http://[1:0:1:0:1:0:1:0]")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://[1:0:1:0:1:0:1:0]/")
}

///|
test "WPT #689" {
  let result = @url.Url::parse("http://example.org/test?\"")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?%22")
}

///|
test "WPT #690" {
  let result = @url.Url::parse("http://example.org/test?#")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?#")
}

///|
test "WPT #691" {
  let result = @url.Url::parse("http://example.org/test?<")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?%3C")
}

///|
test "WPT #692" {
  let result = @url.Url::parse("http://example.org/test?>")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?%3E")
}

///|
test "WPT #693" {
  let result = @url.Url::parse("http://example.org/test?⌣")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?%E2%8C%A3")
}

///|
test "WPT #694" {
  let result = @url.Url::parse("http://example.org/test?%23%23")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?%23%23")
}

///|
test "WPT #695" {
  let result = @url.Url::parse("http://example.org/test?%GH")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?%GH")
}

///|
test "WPT #696" {
  let result = @url.Url::parse("http://example.org/test?a#%EF")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?a#%EF")
}

///|
test "WPT #697" {
  let result = @url.Url::parse("http://example.org/test?a#%GH")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?a#%GH")
}

///|
test "WPT #698" {
  let result = @url.Url::parse("a")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #699" {
  let result = @url.Url::parse("a/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #700" {
  let result = @url.Url::parse("a//")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #701" {
  let base_url = @url.Url::parse("a:")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("test-a-colon.html", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #702" {
  let base_url = @url.Url::parse("a:b")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("test-a-colon-b.html", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #703" {
  let base_url = @url.Url::parse("a:/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("test-a-colon-slash.html", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "a:/test-a-colon-slash.html")
}

///|
test "WPT #704" {
  let base_url = @url.Url::parse("a://")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("test-a-colon-slash-slash.html", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "a:///test-a-colon-slash-slash.html")
}

///|
test "WPT #705" {
  let base_url = @url.Url::parse("a:/b")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("test-a-colon-slash-b.html", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "a:/test-a-colon-slash-b.html")
}

///|
test "WPT #706" {
  let base_url = @url.Url::parse("a://b")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("test-a-colon-slash-slash-b.html", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "a://b/test-a-colon-slash-slash-b.html")
}

///|
test "WPT #707" {
  let result = @url.Url::parse("http://example.org/test?a#b\u{0000}c")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/test?a#b%00c")
}

///|
test "WPT #708" {
  let result = @url.Url::parse("non-spec://example.org/test?a#b\u{0000}c")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec://example.org/test?a#b%00c")
}

///|
test "WPT #709" {
  let result = @url.Url::parse("non-spec:/test?a#b\u{0000}c")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-spec:/test?a#b%00c")
}

///|
test "WPT #710" {
  let base_url = @url.Url::parse("file:///some/dir/bar.html")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("10.0.0.7:8080/foo.html", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///some/dir/10.0.0.7:8080/foo.html")
}

///|
test "WPT #711" {
  let base_url = @url.Url::parse("file:///some/dir/bar.html")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("a!@$*=/foo.html", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///some/dir/a!@$*=/foo.html")
}

///|
test "WPT #712" {
  let base_url = @url.Url::parse("http://example.com/dir/file")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("a1234567890-+.:foo/bar", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "a1234567890-+.:foo/bar")
}

///|
test "WPT #713" {
  let result = @url.Url::parse("file://a­b/p")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://ab/p")
}

///|
test "WPT #714" {
  let result = @url.Url::parse("file://a%C2%ADb/p")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://ab/p")
}

///|
test "WPT #715" {
  let result = @url.Url::parse("file://loC𝐀𝐋𝐇𝐨𝐬𝐭/usr/bin")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///usr/bin")
}

///|
test "WPT #716" {
  let result = @url.Url::parse("file://­/p")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #717" {
  let result = @url.Url::parse("file://%C2%AD/p")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #718" {
  let result = @url.Url::parse("file://xn--/p")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #719" {
  let base_url = @url.Url::parse("https://example.org/##link")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("#link", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://example.org/#link")
}

///|
test "WPT #720" {
  let result = @url.Url::parse(
    "non-special:cannot-be-a-base-url-\u{0000}\u{0001}\u{001F}\u{001E}~\u{007F}",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "non-special:cannot-be-a-base-url-%00%01%1F%1E~%7F%C2%80",
  )
}

///|
test "WPT #721" {
  let result = @url.Url::parse(
    "non-special:cannot-be-a-base-url-!\"$%&'()*+,-.;<=>@[\\]^_`{|}~@/",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "non-special:cannot-be-a-base-url-!\"$%&'()*+,-.;<=>@[\\]^_`{|}~@/",
  )
}

///|
test "WPT #722" {
  let result = @url.Url::parse(
    "https://www.example.com/path{\u{007F}path.html?query'\u{007F}=query#fragment<\u{007F}fragment",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "https://www.example.com/path%7B%7Fpath.html?query%27%7F=query#fragment%3C%7Ffragment",
  )
}

///|
test "WPT #723" {
  let base_url = @url.Url::parse("http://example.org")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "https://user:pass[\u{007F}@foo/bar",
    base=base_url,
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://user:pass%5B%7F@foo/bar")
}

///|
test "WPT #724" {
  let result = @url.Url::parse("foo:// !\"$%&'()*+,-.;<=>@[\\]^_`{|}~@host/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "foo://%20!%22$%&'()*+,-.%3B%3C%3D%3E%40%5B%5C%5D%5E_%60%7B%7C%7D~@host/",
  )
}

///|
test "WPT #725" {
  let result = @url.Url::parse("wss:// !\"$%&'()*+,-.;<=>@[]^_`{|}~@host/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "wss://%20!%22$%&'()*+,-.%3B%3C%3D%3E%40%5B%5D%5E_%60%7B%7C%7D~@host/",
  )
}

///|
test "WPT #726" {
  let result = @url.Url::parse(
    "foo://joe: !\"$%&'()*+,-.:;<=>@[\\]^_`{|}~@host/",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "foo://joe:%20!%22$%&'()*+,-.%3A%3B%3C%3D%3E%40%5B%5C%5D%5E_%60%7B%7C%7D~@host/",
  )
}

///|
test "WPT #727" {
  let result = @url.Url::parse("wss://joe: !\"$%&'()*+,-.:;<=>@[]^_`{|}~@host/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "wss://joe:%20!%22$%&'()*+,-.%3A%3B%3C%3D%3E%40%5B%5D%5E_%60%7B%7C%7D~@host/",
  )
}

///|
test "WPT #728" {
  let result = @url.Url::parse("foo://!\"$%&'()*+,-.;=_`{}~/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "foo://!\"$%&'()*+,-.;=_`{}~/")
}

///|
test "WPT #729" {
  let result = @url.Url::parse("wss://!\"$&'()*+,-.;=_`{}~/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "wss://!\"$&'()*+,-.;=_`{}~/")
}

///|
test "WPT #730" {
  let result = @url.Url::parse("foo://host/ !\"$%&'()*+,-./:;<=>@[\\]^_`{|}~")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "foo://host/%20!%22$%&'()*+,-./:;%3C=%3E@[\\]%5E_%60%7B|%7D~",
  )
}

///|
test "WPT #731" {
  let result = @url.Url::parse("wss://host/ !\"$%&'()*+,-./:;<=>@[\\]^_`{|}~")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "wss://host/%20!%22$%&'()*+,-./:;%3C=%3E@[/]%5E_%60%7B|%7D~",
  )
}

///|
test "WPT #732" {
  let result = @url.Url::parse(
    "foo://host/dir/? !\"$%&'()*+,-./:;<=>?@[\\]^_`{|}~",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "foo://host/dir/?%20!%22$%&'()*+,-./:;%3C=%3E?@[\\]^_`{|}~",
  )
}

///|
test "WPT #733" {
  let result = @url.Url::parse(
    "wss://host/dir/? !\"$%&'()*+,-./:;<=>?@[\\]^_`{|}~",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "wss://host/dir/?%20!%22$%&%27()*+,-./:;%3C=%3E?@[\\]^_`{|}~",
  )
}

///|
test "WPT #734" {
  let result = @url.Url::parse(
    "foo://host/dir/# !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "foo://host/dir/#%20!%22#$%&'()*+,-./:;%3C=%3E?@[\\]^_%60{|}~",
  )
}

///|
test "WPT #735" {
  let result = @url.Url::parse(
    "wss://host/dir/# !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "wss://host/dir/#%20!%22#$%&'()*+,-./:;%3C=%3E?@[\\]^_%60{|}~",
  )
}

///|
test "WPT #736" {
  let base_url = @url.Url::parse("abc://host/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("abc:rootless", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "abc:rootless")
}

///|
test "WPT #737" {
  let base_url = @url.Url::parse("abc:/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("abc:rootless", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "abc:rootless")
}

///|
test "WPT #738" {
  let base_url = @url.Url::parse("abc:path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("abc:rootless", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "abc:rootless")
}

///|
test "WPT #739" {
  let base_url = @url.Url::parse("abc://host/path")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("abc:/rooted", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "abc:/rooted")
}

///|
test "WPT #740" {
  let result = @url.Url::parse("#")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #741" {
  let result = @url.Url::parse("?")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #742" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://1.2.3.4.5", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #743" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://1.2.3.4.5.", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #744" {
  let result = @url.Url::parse("http://0..0x300/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #745" {
  let result = @url.Url::parse("http://0..0x300./")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #746" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://256.256.256.256.256", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #747" {
  let base_url = @url.Url::parse("http://other.com/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("http://256.256.256.256.256.", base=base_url)
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #748" {
  let result = @url.Url::parse("http://1.2.3.08")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #749" {
  let result = @url.Url::parse("http://1.2.3.08.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #750" {
  let result = @url.Url::parse("http://1.2.3.09")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #751" {
  let result = @url.Url::parse("http://09.2.3.4")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #752" {
  let result = @url.Url::parse("http://09.2.3.4.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #753" {
  let result = @url.Url::parse("http://01.2.3.4.5")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #754" {
  let result = @url.Url::parse("http://01.2.3.4.5.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #755" {
  let result = @url.Url::parse("http://0x100.2.3.4")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #756" {
  let result = @url.Url::parse("http://0x100.2.3.4.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #757" {
  let result = @url.Url::parse("http://0x1.2.3.4.5")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #758" {
  let result = @url.Url::parse("http://0x1.2.3.4.5.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #759" {
  let result = @url.Url::parse("http://foo.1.2.3.4")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #760" {
  let result = @url.Url::parse("http://foo.1.2.3.4.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #761" {
  let result = @url.Url::parse("http://foo.2.3.4")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #762" {
  let result = @url.Url::parse("http://foo.2.3.4.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #763" {
  let result = @url.Url::parse("http://foo.09")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #764" {
  let result = @url.Url::parse("http://foo.09.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #765" {
  let result = @url.Url::parse("http://foo.0x4")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #766" {
  let result = @url.Url::parse("http://foo.0x4.")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #767" {
  let result = @url.Url::parse("http://foo.09..")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://foo.09../")
}

///|
test "WPT #768" {
  let result = @url.Url::parse("http://0999999999999999999/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #769" {
  let result = @url.Url::parse("http://foo.0x")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #770" {
  let result = @url.Url::parse("http://foo.0XFfFfFfFfFfFfFfFfFfAcE123")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #771" {
  let result = @url.Url::parse("http://💩.123/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #772" {
  let result = @url.Url::parse("https://\u{0000}y")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #773" {
  let result = @url.Url::parse("https://x/\u{0000}y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://x/%00y")
}

///|
test "WPT #774" {
  let result = @url.Url::parse("https://x/?\u{0000}y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://x/?%00y")
}

///|
test "WPT #775" {
  let result = @url.Url::parse("https://x/?#\u{0000}y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://x/?#%00y")
}

///|
test "WPT #776" {
  let result = @url.Url::parse("https://￿y")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #777" {
  let result = @url.Url::parse("https://x/￿y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://x/%EF%BF%BFy")
}

///|
test "WPT #778" {
  let result = @url.Url::parse("https://x/?￿y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://x/?%EF%BF%BFy")
}

///|
test "WPT #779" {
  let result = @url.Url::parse("https://x/?#￿y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://x/?#%EF%BF%BFy")
}

///|
test "WPT #780" {
  let result = @url.Url::parse("non-special:\u{0000}y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:%00y")
}

///|
test "WPT #781" {
  let result = @url.Url::parse("non-special:x/\u{0000}y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:x/%00y")
}

///|
test "WPT #782" {
  let result = @url.Url::parse("non-special:x/?\u{0000}y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:x/?%00y")
}

///|
test "WPT #783" {
  let result = @url.Url::parse("non-special:x/?#\u{0000}y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:x/?#%00y")
}

///|
test "WPT #784" {
  let result = @url.Url::parse("non-special:￿y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:%EF%BF%BFy")
}

///|
test "WPT #785" {
  let result = @url.Url::parse("non-special:x/￿y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:x/%EF%BF%BFy")
}

///|
test "WPT #786" {
  let result = @url.Url::parse("non-special:x/?￿y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:x/?%EF%BF%BFy")
}

///|
test "WPT #787" {
  let result = @url.Url::parse("non-special:x/?#￿y")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:x/?#%EF%BF%BFy")
}

///|
test "WPT #788" {
  let result = @url.Url::parse("")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #789" {
  let result = @url.Url::parse("https://example.com/\"quoted\"")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://example.com/%22quoted%22")
}

///|
test "WPT #790" {
  let result = @url.Url::parse("https://a%C2%ADb/")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "https://ab/")
}

///|
test "WPT #791" {
  let result = @url.Url::parse("https://­/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #792" {
  let result = @url.Url::parse("https://%C2%AD/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #793" {
  let result = @url.Url::parse("https://xn--/")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #794" {
  let result = @url.Url::parse("data://example.com:8080/pathname?search#hash")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data://example.com:8080/pathname?search#hash")
}

///|
test "WPT #795" {
  let result = @url.Url::parse("data:///test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data:///test")
}

///|
test "WPT #796" {
  let result = @url.Url::parse("data://test/a/../b")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "data://test/b")
}

///|
test "WPT #797" {
  let result = @url.Url::parse("data://:443")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #798" {
  let result = @url.Url::parse("data://test:test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #799" {
  let result = @url.Url::parse("data://[:1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #800" {
  let result = @url.Url::parse(
    "javascript://example.com:8080/pathname?search#hash",
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(
    url.to_string(),
    "javascript://example.com:8080/pathname?search#hash",
  )
}

///|
test "WPT #801" {
  let result = @url.Url::parse("javascript:///test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "javascript:///test")
}

///|
test "WPT #802" {
  let result = @url.Url::parse("javascript://test/a/../b")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "javascript://test/b")
}

///|
test "WPT #803" {
  let result = @url.Url::parse("javascript://:443")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #804" {
  let result = @url.Url::parse("javascript://test:test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #805" {
  let result = @url.Url::parse("javascript://[:1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #806" {
  let result = @url.Url::parse("mailto://example.com:8080/pathname?search#hash")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto://example.com:8080/pathname?search#hash")
}

///|
test "WPT #807" {
  let result = @url.Url::parse("mailto:///test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto:///test")
}

///|
test "WPT #808" {
  let result = @url.Url::parse("mailto://test/a/../b")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "mailto://test/b")
}

///|
test "WPT #809" {
  let result = @url.Url::parse("mailto://:443")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #810" {
  let result = @url.Url::parse("mailto://test:test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #811" {
  let result = @url.Url::parse("mailto://[:1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #812" {
  let result = @url.Url::parse("intent://example.com:8080/pathname?search#hash")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "intent://example.com:8080/pathname?search#hash")
}

///|
test "WPT #813" {
  let result = @url.Url::parse("intent:///test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "intent:///test")
}

///|
test "WPT #814" {
  let result = @url.Url::parse("intent://test/a/../b")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "intent://test/b")
}

///|
test "WPT #815" {
  let result = @url.Url::parse("intent://:443")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #816" {
  let result = @url.Url::parse("intent://test:test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #817" {
  let result = @url.Url::parse("intent://[:1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #818" {
  let result = @url.Url::parse("urn://example.com:8080/pathname?search#hash")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "urn://example.com:8080/pathname?search#hash")
}

///|
test "WPT #819" {
  let result = @url.Url::parse("urn:///test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "urn:///test")
}

///|
test "WPT #820" {
  let result = @url.Url::parse("urn://test/a/../b")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "urn://test/b")
}

///|
test "WPT #821" {
  let result = @url.Url::parse("urn://:443")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #822" {
  let result = @url.Url::parse("urn://test:test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #823" {
  let result = @url.Url::parse("urn://[:1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #824" {
  let result = @url.Url::parse("turn://example.com:8080/pathname?search#hash")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "turn://example.com:8080/pathname?search#hash")
}

///|
test "WPT #825" {
  let result = @url.Url::parse("turn:///test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "turn:///test")
}

///|
test "WPT #826" {
  let result = @url.Url::parse("turn://test/a/../b")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "turn://test/b")
}

///|
test "WPT #827" {
  let result = @url.Url::parse("turn://:443")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #828" {
  let result = @url.Url::parse("turn://test:test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #829" {
  let result = @url.Url::parse("turn://[:1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #830" {
  let result = @url.Url::parse("stun://example.com:8080/pathname?search#hash")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "stun://example.com:8080/pathname?search#hash")
}

///|
test "WPT #831" {
  let result = @url.Url::parse("stun:///test")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "stun:///test")
}

///|
test "WPT #832" {
  let result = @url.Url::parse("stun://test/a/../b")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "stun://test/b")
}

///|
test "WPT #833" {
  let result = @url.Url::parse("stun://:443")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #834" {
  let result = @url.Url::parse("stun://test:test")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #835" {
  let result = @url.Url::parse("stun://[:1]")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #836" {
  let result = @url.Url::parse("w://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "w://x:0")
}

///|
test "WPT #837" {
  let result = @url.Url::parse("west://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "west://x:0")
}

///|
test "WPT #838" {
  let result = @url.Url::parse("android://x:0/a")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "android://x:0/a")
}

///|
test "WPT #839" {
  let result = @url.Url::parse("drivefs://x:0/a")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "drivefs://x:0/a")
}

///|
test "WPT #840" {
  let result = @url.Url::parse("chromeos-steam://x:0/a")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "chromeos-steam://x:0/a")
}

///|
test "WPT #841" {
  let result = @url.Url::parse("steam://x:0/a")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "steam://x:0/a")
}

///|
test "WPT #842" {
  let result = @url.Url::parse("materialized-view://x:0/a")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "materialized-view://x:0/a")
}

///|
test "WPT #843" {
  let result = @url.Url::parse("android-app://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "android-app://x:0")
}

///|
test "WPT #844" {
  let result = @url.Url::parse("chrome-distiller://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "chrome-distiller://x:0")
}

///|
test "WPT #845" {
  let result = @url.Url::parse("chrome-extension://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "chrome-extension://x:0")
}

///|
test "WPT #846" {
  let result = @url.Url::parse("chrome-native://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "chrome-native://x:0")
}

///|
test "WPT #847" {
  let result = @url.Url::parse("chrome-resource://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "chrome-resource://x:0")
}

///|
test "WPT #848" {
  let result = @url.Url::parse("chrome-search://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "chrome-search://x:0")
}

///|
test "WPT #849" {
  let result = @url.Url::parse("fuchsia-dir://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "fuchsia-dir://x:0")
}

///|
test "WPT #850" {
  let result = @url.Url::parse("isolated-app://x:0")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "isolated-app://x:0")
}

///|
test "WPT #851" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///test", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://test/")
}

///|
test "WPT #852" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///\\//\\//test", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://test/")
}

///|
test "WPT #853" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///example.org/path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/path")
}

///|
test "WPT #854" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///example.org/../path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/path")
}

///|
test "WPT #855" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///example.org/../../", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/")
}

///|
test "WPT #856" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///example.org/../path/../../", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/")
}

///|
test "WPT #857" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse(
    "///example.org/../path/../../path",
    base=base_url,
  )
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/path")
}

///|
test "WPT #858" {
  let base_url = @url.Url::parse("http://example.org/")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/\\/\\//example.org/../path", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "http://example.org/path")
}

///|
test "WPT #859" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("///abcdef/../", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file:///")
}

///|
test "WPT #860" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("/\\//\\/a/../", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://////")
}

///|
test "WPT #861" {
  let base_url = @url.Url::parse("file:///")
  guard base_url is Some(base_url) else { return }
  let result = @url.Url::parse("//a/../", base=base_url)
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "file://a/")
}

///|
test "WPT #862" {
  let result = @url.Url::parse("non-special:\\\\opaque")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:\\\\opaque")
}

///|
test "WPT #863" {
  let result = @url.Url::parse("non-special:\\\\opaque/path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:\\\\opaque/path")
}

///|
test "WPT #864" {
  let result = @url.Url::parse("non-special:\\\\opaque\\path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:\\\\opaque\\path")
}

///|
test "WPT #865" {
  let result = @url.Url::parse("non-special:\\/opaque")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:\\/opaque")
}

///|
test "WPT #866" {
  let result = @url.Url::parse("non-special:/\\path")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special:/\\path")
}

///|
test "WPT #867" {
  let result = @url.Url::parse("non-special://host\\a")
  guard result is None else {
    fail("Expected failure but got: \{result.unwrap().to_string().escape()}")
  }
}

///|
test "WPT #868" {
  let result = @url.Url::parse("non-special://host/a\\b")
  guard result is Some(url) else { fail("Expected success but parsing failed") }
  assert_eq(url.to_string(), "non-special://host/a\\b")
}
