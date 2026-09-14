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
test "Url::parse raises the validation error that stopped the parser" {
  let inputs = [
    "http://:80/", "http://example.com:99999/", "http://example.com:abc/", "no-scheme",
    "http://exa mple.com/", "http://[::1/",
  ]
  let outcomes = inputs.map(input => {
    let outcome = try @url.Url::parse(input) catch {
      err => Err(err)
    } noraise {
      url => Ok(url.to_string())
    }
    (input, outcome)
  })
  debug_inspect(
    outcomes,
    content=(
      #|[
      #|  ("http://:80/", Err(HostMissing)),
      #|  ("http://example.com:99999/", Err(PortOutOfRange)),
      #|  ("http://example.com:abc/", Err(PortInvalid)),
      #|  ("no-scheme", Err(MissingSchemeNonRelativeUrl)),
      #|  ("http://exa mple.com/", Err(HostInvalidCodePoint)),
      #|  ("http://[::1/", Err(IPv6Unclosed)),
      #|]
    ),
  )
}

///|
test "Url::parse collects non-fatal validation errors" {
  let errors = []
  let url = @url.Url::parse(
    "https:/user@example.com\\a",
    validation_errors=errors,
  )
  assert_eq(url.to_string(), "https://user@example.com/a")
  debug_inspect(
    errors,
    content=(
      #|[
      #|  SpecialSchemeMissingFollowingSolidus,
      #|  SpecialSchemeMissingFollowingSolidus,
      #|  InvalidCredentials,
      #|  InvalidReverseSolidus,
      #|]
    ),
  )
  // Without an array the warnings are simply dropped.
  assert_eq(
    @url.Url::parse("https:/example.com").to_string(),
    "https://example.com/",
  )
}

///|
test "Url getters" {
  let url = @url.Url::parse(
    "https://user:pass@example.com:8080/path/to/resource?query=value#fragment",
  )
  assert_eq(url.scheme(), "https")
  assert_eq(url.username(), "user")
  assert_eq(url.password(), "pass")
  debug_inspect(
    url.host(),
    content=(
      #|Some(Domain("example.com"))
    ),
  )
  debug_inspect(
    url.port(),
    content=(
      #|Some(8080)
    ),
  )
  assert_eq(url.path().to_string(), "/path/to/resource")
  debug_inspect(
    url.query(),
    content=(
      #|Some("query=value")
    ),
  )
  debug_inspect(
    url.fragment(),
    content=(
      #|Some("fragment")
    ),
  )
  assert_eq(url.origin().to_string(), "https://example.com:8080")
}

///|
test "Url getters for absent components" {
  let url = @url.Url::parse("mailto:someone@example.com")
  debug_inspect(
    url.host(),
    content=(
      #|None
    ),
  )
  debug_inspect(
    url.port(),
    content=(
      #|None
    ),
  )
  assert_eq(url.path().to_string(), "someone@example.com")
  debug_inspect(
    url.query(),
    content=(
      #|None
    ),
  )
  debug_inspect(
    url.fragment(),
    content=(
      #|None
    ),
  )
  // An empty query or fragment is present but empty, unlike an absent one.
  let empty = @url.Url::parse("http://example.com/?#")
  debug_inspect(
    empty.query(),
    content=(
      #|Some("")
    ),
  )
  debug_inspect(
    empty.fragment(),
    content=(
      #|Some("")
    ),
  )
  assert_eq(empty.to_string(), "http://example.com/?#")
}

///|
test "Url with IPv6 host" {
  let url = @url.Url::parse("http://[::1]:8080/path")
  debug_inspect(
    url.host(),
    content=(
      #|Some(IPv6(IPv6(<FixedArray: [0, 0, 0, 0, 0, 0, 0, 1]>)))
    ),
  )
  debug_inspect(
    url.port(),
    content=(
      #|Some(8080)
    ),
  )
  assert_eq(url.to_string(), "http://[::1]:8080/path")
}

///|
test "Url::with_* return a new URL and leave the original untouched" {
  let url = @url.Url::parse("http://example.com/path")
  let updated = url
    .with_scheme("HTTPS")
    .with_username("new user")
    .with_password("new:pass")
    .with_host(Some(@url.Host::parse("example.org")))
    .with_port(Some(9000))
    .with_path(@url.Url::parse("http://x/a/b c").path())
    .with_query(Some("q=a b"))
    .with_fragment(Some("frag"))
  assert_eq(
    updated.to_string(),
    "https://new%20user:new%3Apass@example.org:9000/a/b%20c?q=a%20b#frag",
  )
  assert_eq(url.to_string(), "http://example.com/path")
}

///|
test "Url::with_scheme normalizes case and the default port" {
  let url = @url.Url::parse("http://example.com:443/")
  assert_eq(url.with_scheme("HTTPS").to_string(), "https://example.com/")
  assert_eq(url.with_scheme("ws").to_string(), "ws://example.com:443/")
}

///|
test "Url::with_port drops the default port" {
  let url = @url.Url::parse("https://example.com:8080/")
  assert_eq(url.with_port(Some(443)).to_string(), "https://example.com/")
  assert_eq(url.with_port(None).to_string(), "https://example.com/")
  assert_eq(url.with_port(Some(80)).to_string(), "https://example.com:80/")
}

///|
test "Url::with_host" {
  let non_special = @url.Url::parse("foo://example.com/a")
  assert_eq(non_special.with_host(None).to_string(), "foo:/a")
  let file = @url.Url::parse("file://example.com/tmp/x")
  assert_eq(
    file.with_host(Some(@url.Host::parse("localhost"))).to_string(),
    "file:///tmp/x",
  )
  let http = @url.Url::parse("http://example.com/")
  assert_eq(
    http.with_host(Some(@url.Host::parse("[::1]"))).to_string(),
    "http://[::1]/",
  )
}

///|
test "Url::with_query and Url::with_fragment accept None and empty" {
  let url = @url.Url::parse("http://example.com/?a=1#top")
  assert_eq(url.with_query(None).to_string(), "http://example.com/#top")
  assert_eq(url.with_query(Some("")).to_string(), "http://example.com/?#top")
  assert_eq(url.with_fragment(None).to_string(), "http://example.com/?a=1")
  assert_eq(url.with_fragment(Some("")).to_string(), "http://example.com/?a=1#")
}

///|
test "Url::with_search_params" {
  let url = @url.Url::parse("https://example.com/?x=1")
  let params = @url.UrlSearchParams([("a", "1"), ("b", "two words")])
  assert_eq(
    url.with_search_params(params).to_string(),
    "https://example.com/?a=1&b=two+words",
  )
  assert_eq(
    url.with_search_params(UrlSearchParams([])).to_string(),
    "https://example.com/",
  )
}

///|
test "Url::with_* rejects what the spec forbids" {
  let http = @url.Url::parse("http://example.com/")
  let with_credentials = @url.Url::parse("http://user:pass@example.com/")
  let file = @url.Url::parse("file:///tmp/x")
  let mailto = @url.Url::parse("mailto:someone@example.com")
  let opaque_host = @url.Host::parse("x", is_opaque=true)
  let domain = @url.Host::parse("example.com")
  let checks : Array[(String, () -> @url.Url raise @url.UpdateError)] = [
    ("special to non-special scheme", () => http.with_scheme("mailto")),
    ("scheme syntax", () => http.with_scheme("1http")),
    ("file scheme with credentials", () => with_credentials.with_scheme("file")),
    ("file with empty host to http", () => file.with_scheme("http")),
    ("special URL without host", () => http.with_host(None)),
    ("opaque host on special URL", () => http.with_host(Some(opaque_host))),
    ("host on opaque path", () => mailto.with_host(Some(domain))),
    ("username on opaque path", () => mailto.with_username("x")),
    ("port on file URL", () => file.with_port(Some(80))),
    ("opaque path on special URL", () => http.with_path(mailto.path())),
  ]
  let outcomes = checks.map(check => {
    let (label, update) = check
    let outcome = try update() catch {
      err => Err(err)
    } noraise {
      url => Ok(url.to_string())
    }
    (label, outcome)
  })
  debug_inspect(
    outcomes,
    content=(
      #|[
      #|  ("special to non-special scheme", Err(SpecialSchemeMismatch)),
      #|  ("scheme syntax", Err(InvalidScheme)),
      #|  ("file scheme with credentials", Err(CannotHaveCredentialsOrPort)),
      #|  ("file with empty host to http", Err(HostRequired)),
      #|  ("special URL without host", Err(HostRequired)),
      #|  ("opaque host on special URL", Err(HostKindMismatch)),
      #|  ("host on opaque path", Err(HasOpaquePath)),
      #|  ("username on opaque path", Err(CannotHaveCredentialsOrPort)),
      #|  ("port on file URL", Err(CannotHaveCredentialsOrPort)),
      #|  ("opaque path on special URL", Err(InvalidPath)),
      #|]
    ),
  )
}

///|
test "Url::origin" {
  let http = @url.Url::parse("http://example.com:8080/")
  assert_eq(http.origin().to_string(), "http://example.com:8080")
  assert_eq(
    @url.Url::parse("file:///path/to/file").origin().to_string(),
    "null",
  )
  assert_eq(
    @url.Url::parse("blob:https://example.com/uuid").origin().to_string(),
    "https://example.com",
  )
  assert_eq(
    @url.Url::parse("blob:data:text/plain,x").origin().to_string(),
    "null",
  )
  let same = @url.Url::parse("http://example.com:8080/other").origin()
  inspect(http.origin().is_same_origin(same), content="true")
  // Opaque origins are never same origin, not even with themselves.
  let opaque_origin = @url.Url::parse("data:text/plain,a").origin()
  inspect(opaque_origin.is_same_origin(opaque_origin), content="false")
}

///|
test "Url::to_json" {
  // Per WHATWG spec, toJSON() returns the serialization (same as toString)
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

///|
test "Host and IP addresses serialize to JSON as strings" {
  inspect(@url.Host::parse("[::1]").to_json().stringify(), content="\"[::1]\"")
  inspect(
    @url.Host::parse("127.0.0.1").to_json().stringify(),
    content="\"127.0.0.1\"",
  )
  inspect(
    @url.Host::parse("Example.COM").to_json().stringify(),
    content="\"example.com\"",
  )
}
