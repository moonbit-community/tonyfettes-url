///|
test "typed getters and with methods preserve components and legacy views" {
  let url = @url.Url::parse(
    "https://u%20s:p%40s@example.com:8080/a%2Fb?q=%2F+#f%20x",
  )
  let copy = url
    .with_scheme(url.get_scheme())
    .with_username(url.get_username())
    .with_password(url.get_password())
    .with_host(url.get_host())
    .with_port(url.get_port())
    .with_path(url.get_path())
    .with_query(url.get_query())
    .with_fragment(url.get_fragment())
  assert_eq(copy.to_string(), url.to_string())
  assert_eq(url.get_scheme(), "https")
  assert_eq(url.get_host().map(h => h.to_string()), Some("example.com"))
  assert_eq(url.get_port(), Some(8080))
  assert_eq(url.get_path().segments().map(s => s.to_array()), Some(["a%2Fb"]))
  assert_eq(url.get_query(), Some("q=%2F+"))
  assert_eq(url.get_fragment(), Some("f%20x"))
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.port(), "8080")
  assert_eq(url.search(), "?q=%2F+")
  assert_eq(url.hash(), "#f%20x")
}

///|
test "query and fragment encode forbidden characters and preserve percent escapes" {
  let url = @url.Url::parse("https://example.com/")
  assert_eq(url.with_query(Some("x=%2F a#b\t")).search(), "?x=%2F%20a%23b%09")
  assert_eq(
    url.with_query(Some("x=%2F 中文")).search(),
    "?x=%2F%20%E4%B8%AD%E6%96%87",
  )
  assert_eq(url.with_fragment(Some("%2F x\n")).hash(), "#%2F%20x%0A")
  assert_eq(url.with_fragment(Some("%2F x")).hash(), "#%2F%20x")
  assert_eq(url.with_query(Some("'")).search(), "?%27")
  assert_eq(@url.Url::parse("foo:/").with_query(Some("'")).search(), "?'")
  // Leading delimiters are content, not stripped by the component updates.
  assert_eq(url.with_query(Some("?x")).search(), "??x")
  assert_eq(url.with_fragment(Some("#x")).hash(), "##x")
}

///|
test "absent and present empty query and fragment are distinct" {
  let url = @url.Url::parse("foo:/")
  assert_eq(url.with_query(None).with_fragment(None).to_string(), "foo:/")
  let empty = url.with_query(Some("")).with_fragment(Some(""))
  assert_eq(empty.to_string(), "foo:/?#")
  assert_eq(empty.get_query(), Some(""))
  assert_eq(empty.get_fragment(), Some(""))
  assert_eq(url.get_query(), None)
}

///|
test "updates and subsequent legacy setters are isolated in both directions" {
  let original = @url.Url::parse("https://user:pass@old.example:8080/a/b?q=1#f")
  let changed = original
    .with_host(@url.Url::parse("https://new.example/").get_host())
    .with_port(Some(443))
    .with_pathname("/x/../y%2Fz")
    .with_username("new user")
    .with_password("new pass")
  assert_eq(
    changed.to_string(),
    "https://new%20user:new%20pass@new.example/y%2Fz?q=1#f",
  )
  assert_eq(
    original.to_string(),
    "https://user:pass@old.example:8080/a/b?q=1#f",
  )
  original.set_pathname("/original")
  original.set_host("other.example:9000")
  assert_eq(changed.pathname(), "/y%2Fz")
  assert_eq(changed.host(), "new.example")
  changed.set_pathname("/changed")
  changed.set_search("?changed")
  assert_eq(original.pathname(), "/original")
  assert_eq(original.search(), "?q=1")
}

///|
test "path construction encodes separators and copies caller storage" {
  let segments = ["a/b", "c\\d", "%2F", "中文"]
  let path = @url.Path::from_segments(segments)
  segments[0] = "changed"
  let url = @url.Url::parse("https://example.com/").with_path(path)
  assert_eq(url.pathname(), "/a%2Fb/c%5Cd/%252F/%E4%B8%AD%E6%96%87")
  assert_eq(url.with_path(url.get_path()).to_string(), url.to_string())
  let dots = @url.Path::from_segments(["a", "..", "b", "."])
  assert_eq(url.with_path(dots).pathname(), "/b/")
  assert_eq(url.with_path(@url.Path::from_segments([])).pathname(), "/")
  let root = @url.Url::parse("https://example.com").get_path()
  assert_eq(root.to_string(), "/")
  assert_eq(
    @url.Url::parse("file:///old")
    .with_path(@url.Path::from_segments(["C|", "a"]))
    .pathname(),
    "/C:/a",
  )
}

///|
test "opaque_url paths and host removal preserve round trips" {
  let no_host = @url.Url::parse("foo://host").with_host(None)
  assert_eq(no_host.to_string(), "foo:/")
  assert_eq(@url.Url::parse(no_host.to_string()).get_path().is_opaque(), false)
  let opaque_url = no_host.with_path(@url.Path::from_opaque("text ?#%"))
  assert_eq(opaque_url.to_string(), "foo:text%20%3F%23%25")
  assert_eq(opaque_url.get_path().is_opaque(), true)
  assert_eq(
    opaque_url.with_path(opaque_url.get_path()).to_string(),
    opaque_url.to_string(),
  )
  try opaque_url.with_pathname("/x") catch {
    HasOpaquePath => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected an opaque_url-path error")
  }
  try no_host.with_path(@url.Path::from_opaque("/x")) catch {
    InvalidPath => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected invalid path")
  }
}

///|
test "invalid updates fail without modifying their receiver" {
  let url = @url.Url::parse("https://user@example.com:8080/a")
  try url.with_scheme("http:garbage") catch {
    InvalidScheme => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected invalid scheme")
  }
  try url.with_scheme("foo") catch {
    SpecialSchemeMismatch => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected scheme mismatch")
  }
  try url.with_host(None) catch {
    HostRequired => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected required host")
  }
  try url.with_scheme("file") catch {
    CannotHaveCredentialsOrPort => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected credential error")
  }
  try url.with_host(@url.Url::parse("foo://host/").get_host()) catch {
    @url.UpdateError::HostKindMismatch => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected host mismatch")
  }
  assert_eq(url.to_string(), "https://user@example.com:8080/a")
  assert_eq(url.with_scheme("HTTP").get_scheme(), "http")
  let file = @url.Url::parse("file:///a")
  try file.with_port(Some(8080)) catch {
    CannotHaveCredentialsOrPort => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected file port error")
  }
  try file.with_scheme("https") catch {
    HostRequired => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected file host error")
  }
}

///|
test "structured origins and legacy origin coexist" {
  let url = @url.Url::parse("https://example.com:443/a")
  let other = @url.Url::parse("https://example.com/b")
  assert_eq(url.get_origin().to_string(), url.origin())
  assert_eq(url.get_origin().is_same_origin(other.get_origin()), true)
  assert_eq(
    url.get_origin().is_same_origin(url.with_port(Some(8080)).get_origin()),
    false,
  )
  let blob = @url.Url::parse("blob:https://example.com/id")
  assert_eq(blob.get_origin().is_same_origin(url.get_origin()), true)
  assert_eq(blob.origin(), "null")
  let opaque_url = @url.Url::parse("file:///a").get_origin()
  assert_eq(opaque_url.to_string(), "null")
  assert_eq(opaque_url.is_same_origin(opaque_url), false)
}

///|
test "search params are detached and encoded opaque spaces are preserved" {
  let url = @url.Url::parse("https://example.com/?q=old")
  let params = url.get_search_params()
  params.set("q", "new value")
  let updated = url.with_search_params(params)
  params.set("q", "later")
  assert_eq(url.search(), "?q=old")
  assert_eq(updated.search(), "?q=new+value")
  // Encoded trailing spaces remain encoded when the query or fragment is removed.
  let opaque_url = @url.Url::parse("data:text ?q")
  assert_eq(opaque_url.with_query(None).to_string(), "data:text%20")
  assert_eq(
    opaque_url.with_search_params(@url.UrlSearchParams::new()).to_string(),
    "data:text%20",
  )
  let fragment = @url.Url::parse("data:text #f")
  assert_eq(fragment.with_fragment(None).to_string(), "data:text%20")
}

///|
test "typed getter update round trips across URL kinds" {
  for
    input in [
      "foo:", "foo:/", "foo://", "foo://host", "foo:/a/.//b", "file:///", "file:///C:/a",
      "https://[::1]:443/?#", "data:a%FF?%#%", "blob:https://example.com/id", "foo://[::1]:9000/a",
    ] {
    let url = @url.Url::parse(input)
    let copy = url
      .with_scheme(url.get_scheme())
      .with_path(url.get_path())
      .with_query(url.get_query())
      .with_fragment(url.get_fragment())
    assert_eq(copy.to_string(), url.to_string())
    if !url.get_path().is_opaque() {
      assert_eq(url.with_host(url.get_host()).to_string(), url.to_string())
    }
  }
}
