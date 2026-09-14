///|
/// The deprecated mutable setters must keep the pre-0.4.0 behavior: they
/// mutate the receiver in place and return Unit.
test "deprecated Url setters mutate in place" {
  let url = Url::parse("http://example.com/path")
  url.set_protocol("https:")
  inspect(url.protocol(), content="https:")
  url.set_username("newuser")
  inspect(url.username(), content="newuser")
  url.set_password("newpass")
  inspect(url.password(), content="newpass")
  url.set_port("9000")
  debug_inspect(url.port(), content="Some(9000)")
  url.set_pathname("/new/path")
  inspect(url.path(), content="/new/path")
  url.set_search("?newquery=1")
  inspect(url.search(), content="?newquery=1")
  url.set_hash("#newhash")
  inspect(url.hash(), content="#newhash")
  inspect(
    url.to_string(),
    content="https://newuser:newpass@example.com:9000/new/path?newquery=1#newhash",
  )
}

///|
/// A rejected value is silently ignored, matching the JavaScript URL setters.
/// The URL keeps its previous value instead of raising.
test "deprecated Url setters ignore rejected values" {
  let url = Url::parse("http://example.com/")
  url.set_port("99999")
  inspect(url.to_string(), content="http://example.com/")
  url.set_host("exa mple.com")
  inspect(url.to_string(), content="http://example.com/")
  url.set_protocol("mailto")
  inspect(url.to_string(), content="http://example.com/")
  // A URL with an opaque path rejects host and pathname changes.
  let opaque_url = Url::parse("mailto:someone@example.com")
  opaque_url.set_host("example.org")
  inspect(opaque_url.to_string(), content="mailto:someone@example.com")
  opaque_url.set_pathname("/other")
  inspect(opaque_url.to_string(), content="mailto:someone@example.com")
}

///|
test "deprecated Url::set_search_params mutates in place" {
  let url = Url::parse("https://example.com/")
  url.set_search_params(UrlSearchParams::parse("a=1&b=2"))
  inspect(url.search(), content="?a=1&b=2")
  url.set_search_params(UrlSearchParams([]))
  inspect(url.search(), content="")
}

///|
test "deprecated Url::set_href replaces the receiver" {
  let url = Url::parse("http://example.com/")
  url.set_href("ftp://ftp.example.com/pub")
  inspect(url.to_string(), content="ftp://ftp.example.com/pub")
  // Invalid input raises ValidationError and leaves the URL unchanged.
  let mut raised = false
  try url.set_href("not a url") catch {
    _ => raised = true
  } noraise {
    _ => ()
  }
  inspect(raised, content="true")
  inspect(url.to_string(), content="ftp://ftp.example.com/pub")
}
