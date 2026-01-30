///|
test "Url::parse basic" {
  let urls = [
    "https://user:pass@example.com:8080/path/to/resource?query=value#fragment", "http://example.com",
    "ftp://ftp.example.com/pub/file.txt", "file:///C:/path/to/file.txt",
  ]
  json_inspect(urls.map(fn(s) { Url::parse(s).map(fn(u) { u.to_string() }) }), content=[
    ["https://user:pass@example.com:8080/path/to/resource?query=value#fragment"],
    ["http://example.com/"],
    ["ftp://ftp.example.com/pub/file.txt"],
    ["file:///C:/path/to/file.txt"],
  ])
}

///|
test "Url::parse special schemes" {
  let test_cases = [
    ("http://example.com:80/", "http://example.com/"), // Default port removed
    ("https://example.com:443/", "https://example.com/"), // Default port removed
    ("http://example.com:8080/", "http://example.com:8080/"), // Non-default port kept
  ]
  json_inspect(
    test_cases.map(fn(case) {
      let (input, _) = case
      Url::parse(input).map(fn(u) { u.to_string() })
    }),
    content=[
      ["http://example.com/"],
      ["https://example.com/"],
      ["http://example.com:8080/"],
    ],
  )
}

///|
test "Url getters" {
  let url = Url::parse(
    "https://user:pass@example.com:8080/path/to/resource?query=value#fragment",
  )
  guard url is Some(url) else { fail("parse failed") }
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
  guard url is Some(url) else { fail("parse failed") }
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
  guard http is Some(http) else { fail("parse failed") }
  inspect(http.origin(), content="http://example.com:8080")
  // file: URLs have null origin
  let file = Url::parse("file:///path/to/file")
  guard file is Some(file) else { fail("parse failed") }
  inspect(file.origin(), content="null")
}

///|
test "Url with IPv6 host" {
  let url = Url::parse("http://[::1]:8080/path")
  guard url is Some(url) else { fail("parse failed") }
  inspect(url.hostname(), content="[::1]")
  inspect(url.port(), content="8080")
  inspect(url.to_string(), content="http://[::1]:8080/path")
}

///|
test "Url relative resolution" {
  let base = Url::parse("https://example.com/a/b/c")
  guard base is Some(base) else { fail("base parse failed") }
  // Test relative URL with base
  let relative = Url::parse("../d", base~)
  guard relative is Some(relative) else { fail("relative parse failed") }
  inspect(relative.to_string(), content="https://example.com/a/d")
}
