///|
test "Url::parse basic" {
  assert_eq(
    Url::parse(
      "https://user:pass@example.com:8080/path/to/resource?query=value#fragment",
    ).to_string(),
    "https://user:pass@example.com:8080/path/to/resource?query=value#fragment",
  )
  assert_eq(Url::parse("http://example.com").to_string(), "http://example.com/")
  assert_eq(
    Url::parse("ftp://ftp.example.com/pub/file.txt").to_string(),
    "ftp://ftp.example.com/pub/file.txt",
  )
  assert_eq(
    Url::parse("file:///C:/path/to/file.txt").to_string(),
    "file:///C:/path/to/file.txt",
  )
}

///|
test "Url::parse special schemes" {
  assert_eq(
    Url::parse("http://example.com:80").to_string(),
    "http://example.com/",
  )
  assert_eq(
    Url::parse("https://example.com:443").to_string(),
    "https://example.com/",
  )
  assert_eq(
    Url::parse("https://example.com:8080").to_string(),
    "https://example.com:8080/",
  )
}

///|
test "Url getters" {
  let url = Url::parse(
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
test "Url setters" {
  let url = Url::parse("http://example.com/path")
  url.set_protocol("https:")
  inspect(url.protocol(), content="https:")
  url.set_username("newuser")
  inspect(url.username(), content="newuser")
  url.set_password("newpass")
  inspect(url.password(), content="newpass")
  url.set_port("9000")
  inspect(url.port(), content="9000")
  url.set_pathname("/new/path")
  inspect(url.pathname(), content="/new/path")
  url.set_search("?newquery=1")
  inspect(url.search(), content="?newquery=1")
  url.set_hash("#newhash")
  inspect(url.hash(), content="#newhash")
}

///|
test "Url::origin" {
  // Special schemes have origin
  let http = Url::parse("http://example.com:8080/")
  inspect(http.origin(), content="http://example.com:8080")
  // file: URLs have null origin
  let file = Url::parse("file:///path/to/file")
  inspect(file.origin(), content="null")
}

///|
test "Url with IPv6 host" {
  let url = Url::parse("http://[::1]:8080/path")
  inspect(url.hostname(), content="[::1]")
  inspect(url.port(), content="8080")
  inspect(url.to_string(), content="http://[::1]:8080/path")
}

///|
test "Url relative resolution" {
  let base = Url::parse("https://example.com/a/b/c")
  // Test relative URL with base
  let relative = Url::parse("../d", base~)
  inspect(relative.to_string(), content="https://example.com/a/d")
}
