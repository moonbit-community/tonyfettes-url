///|
using @test {assert_eq}

///|
test "parse basic" {
  assert_eq(
    @url.Url::parse(
      "https://user:pass@example.com:8080/path/to/resource?query=value#fragment",
    ).to_string(),
    "https://user:pass@example.com:8080/path/to/resource?query=value#fragment",
  )
  assert_eq(
    @url.Url::parse("http://example.com").to_string(),
    "http://example.com/",
  )
  assert_eq(
    @url.Url::parse("ftp://ftp.example.com/pub/file.txt").to_string(),
    "ftp://ftp.example.com/pub/file.txt",
  )
  assert_eq(
    @url.Url::parse("file:///C:/path/to/file.txt").to_string(),
    "file:///C:/path/to/file.txt",
  )
}

///|
test "parse special schemes" {
  assert_eq(
    @url.Url::parse("http://example.com:80").to_string(),
    "http://example.com/",
  )
  assert_eq(
    @url.Url::parse("https://example.com:443").to_string(),
    "https://example.com/",
  )
  assert_eq(
    @url.Url::parse("https://example.com:8080").to_string(),
    "https://example.com:8080/",
  )
}

///|
test "Url getters" {
  let url = @url.Url::parse(
    "https://user:pass@example.com:8080/path/to/resource?query=value#fragment",
  )
  inspect(url.protocol(), content="https:")
  inspect(url.username(), content="user")
  inspect(url.password(), content="pass")
  inspect(url.host(), content="example.com:8080")
  inspect(url.hostname(), content="example.com")
  inspect(url.port(), content="8080")
  inspect(url.pathname(), content="/path/to/resource")
  inspect(url.search(), content="?query=value")
  inspect(url.hash(), content="#fragment")
  inspect(url.origin(), content="https://example.com:8080")
}

///|
test "Url with_* builders" {
  let url = @url.Url::parse("http://example.com/path")
    .with_protocol("https:")
    .with_username("newuser")
    .with_password("newpass")
    .with_port("9000")
    .with_pathname("/new/path")
    .with_search("?newquery=1")
    .with_hash("#newhash")
  inspect(url.protocol(), content="https:")
  inspect(url.username(), content="newuser")
  inspect(url.password(), content="newpass")
  inspect(url.port(), content="9000")
  inspect(url.pathname(), content="/new/path")
  inspect(url.search(), content="?newquery=1")
  inspect(url.hash(), content="#newhash")
  inspect(
    url.href(),
    content="https://newuser:newpass@example.com:9000/new/path?newquery=1#newhash",
  )
}

///|
test "Url with_* leaves the receiver unchanged" {
  let url = @url.Url::parse("http://example.com/path")
  let updated = url.with_pathname("/other")
  inspect(url.href(), content="http://example.com/path")
  inspect(updated.href(), content="http://example.com/other")
}

///|
test "Url with_* raises when the component cannot be set" {
  let url = @url.Url::parse("mailto:someone@example.com")
  // Opaque path: host cannot be set
  try url.with_host("example.org") catch {
    err => inspect(err, content="UrlHasOpaquePath")
  } noraise {
    _ => fail("expected with_host to fail")
  }
  // No host: username/password/port cannot be set
  try url.with_username("user") catch {
    err => inspect(err, content="CannotHaveUsernamePasswordPort")
  } noraise {
    _ => fail("expected with_username to fail")
  }
  // Special <-> non-special scheme changes are not allowed
  let http = @url.Url::parse("http://example.com/")
  try http.with_protocol("mailto") catch {
    err => inspect(err, content="SchemeChangeNotAllowed")
  } noraise {
    _ => fail("expected with_protocol to fail")
  }
  // Out-of-range port
  try http.with_port("99999") catch {
    err => inspect(err, content="PortOutOfRange")
  } noraise {
    _ => fail("expected with_port to fail")
  }
}

///|
test "Url::origin" {
  // Special schemes have origin
  let http = @url.Url::parse("http://example.com:8080/")
  inspect(http.origin(), content="http://example.com:8080")
  // file: URLs have null origin
  let file = @url.Url::parse("file:///path/to/file")
  inspect(file.origin(), content="null")
}

///|
test "Url with IPv6 host" {
  let url = @url.Url::parse("http://[::1]:8080/path")
  inspect(url.hostname(), content="[::1]")
  inspect(url.port(), content="8080")
  inspect(url.to_string(), content="http://[::1]:8080/path")
}

///|
test "Url relative resolution" {
  let base = @url.Url::parse("https://example.com/a/b/c")
  // Test relative URL with base
  let relative = @url.Url::parse("../d", base~)
  inspect(relative.to_string(), content="https://example.com/a/d")
}

///|
test "Url::to_json" {
  // Per WHATWG spec, toJSON() returns the serialization (same as href/toString)
  let url = @url.Url::parse("https://example.com/path?query=1#hash")
  inspect(
    url.to_json().stringify(),
    content="\"https://example.com/path?query=1#hash\"",
  )
  // Test with all URL components
  let full = @url.Url::parse("https://user:pass@example.com:8080/path?q=1#frag")
  inspect(
    full.to_json().stringify(),
    content="\"https://user:pass@example.com:8080/path?q=1#frag\"",
  )
}
