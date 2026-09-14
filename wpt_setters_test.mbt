// Auto-generated from WPT setters_tests.json
// https://github.com/web-platform-tests/wpt/blob/master/url/resources/setters_tests.json
// Do not edit manually
//
// To regenerate:
//   moon run --target native scripts/generate_wpt_setters_tests.mbtx > wpt_setters_test.mbt
//
// Only the protocol, username, password, pathname, search and hash sections
// are generated: their JavaScript setters have typed counterparts with the
// same rules. Rejected updates are ignored as the JavaScript setters do, and
// the expected values are the JavaScript getter views, computed here from
// the typed getters.

///|
fn js_href(url : @url.Url) -> String {
  url.to_string()
}

///|
fn js_protocol(url : @url.Url) -> String {
  "\{url.scheme()}:"
}

///|
fn js_port(url : @url.Url) -> String {
  if url.port() is Some(port) {
    port.to_string()
  } else {
    ""
  }
}

///|
fn js_pathname(url : @url.Url) -> String {
  url.path().to_string()
}

///|
fn js_search(url : @url.Url) -> String {
  match url.query() {
    Some("") | None => ""
    Some(query) => "?\{query}"
  }
}

///|
fn js_hash(url : @url.Url) -> String {
  match url.fragment() {
    Some("") | None => ""
    Some(fragment) => "#\{fragment}"
  }
}

///|
test "WPT setters protocol #0" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #1" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("b") catch {
    _ => ()
  }
  assert_eq(js_href(url), "b://example.net")
  assert_eq(js_protocol(url), "b:")
}

///|
test "WPT setters protocol #2" {
  let url = @url.Url::parse("javascript:alert(1)")
  url.set_scheme("defuse") catch {
    _ => ()
  }
  assert_eq(js_href(url), "defuse:alert(1)")
  assert_eq(js_protocol(url), "defuse:")
}

///|
test "WPT setters protocol #3" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("B") catch {
    _ => ()
  }
  assert_eq(js_href(url), "b://example.net")
  assert_eq(js_protocol(url), "b:")
}

///|
test "WPT setters protocol #4" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("\u{E9}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #5" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("0b") catch {
    _ => ()
  }
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #6" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("+b") catch {
    _ => ()
  }
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #7" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("bC0+-.") catch {
    _ => ()
  }
  assert_eq(js_href(url), "bc0+-.://example.net")
  assert_eq(js_protocol(url), "bc0+-.:")
}

///|
test "WPT setters protocol #8" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("b,c") catch {
    _ => ()
  }
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #9" {
  let url = @url.Url::parse("a://example.net")
  url.set_scheme("b\u{E9}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #10" {
  let url = @url.Url::parse("http://test@example.net")
  url.set_scheme("file") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://test@example.net/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #11" {
  let url = @url.Url::parse("https://example.net:1234")
  url.set_scheme("file") catch {
    _ => ()
  }
  assert_eq(js_href(url), "https://example.net:1234/")
  assert_eq(js_protocol(url), "https:")
}

///|
test "WPT setters protocol #12" {
  let url = @url.Url::parse("wss://x:x@example.net:1234")
  url.set_scheme("file") catch {
    _ => ()
  }
  assert_eq(js_href(url), "wss://x:x@example.net:1234/")
  assert_eq(js_protocol(url), "wss:")
}

///|
test "WPT setters protocol #13" {
  let url = @url.Url::parse("file://localhost/")
  url.set_scheme("http") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file:///")
  assert_eq(js_protocol(url), "file:")
}

///|
test "WPT setters protocol #14" {
  let url = @url.Url::parse("file:///test")
  url.set_scheme("https") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file:///test")
  assert_eq(js_protocol(url), "file:")
}

///|
test "WPT setters protocol #15" {
  let url = @url.Url::parse("file:")
  url.set_scheme("wss") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file:///")
  assert_eq(js_protocol(url), "file:")
}

///|
test "WPT setters protocol #16" {
  let url = @url.Url::parse("http://example.net")
  url.set_scheme("b") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #17" {
  let url = @url.Url::parse("file://hi/path")
  url.set_scheme("s") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file://hi/path")
  assert_eq(js_protocol(url), "file:")
}

///|
test "WPT setters protocol #18" {
  let url = @url.Url::parse("https://example.net")
  url.set_scheme("s") catch {
    _ => ()
  }
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_protocol(url), "https:")
}

///|
test "WPT setters protocol #19" {
  let url = @url.Url::parse("ftp://example.net")
  url.set_scheme("test") catch {
    _ => ()
  }
  assert_eq(js_href(url), "ftp://example.net/")
  assert_eq(js_protocol(url), "ftp:")
}

///|
test "WPT setters protocol #20" {
  let url = @url.Url::parse("mailto:me@example.net")
  url.set_scheme("http") catch {
    _ => ()
  }
  assert_eq(js_href(url), "mailto:me@example.net")
  assert_eq(js_protocol(url), "mailto:")
}

///|
test "WPT setters protocol #21" {
  let url = @url.Url::parse("ssh://me@example.net")
  url.set_scheme("http") catch {
    _ => ()
  }
  assert_eq(js_href(url), "ssh://me@example.net")
  assert_eq(js_protocol(url), "ssh:")
}

///|
test "WPT setters protocol #22" {
  let url = @url.Url::parse("ssh://me@example.net")
  url.set_scheme("https") catch {
    _ => ()
  }
  assert_eq(js_href(url), "ssh://me@example.net")
  assert_eq(js_protocol(url), "ssh:")
}

///|
test "WPT setters protocol #23" {
  let url = @url.Url::parse("ssh://me@example.net")
  url.set_scheme("file") catch {
    _ => ()
  }
  assert_eq(js_href(url), "ssh://me@example.net")
  assert_eq(js_protocol(url), "ssh:")
}

///|
test "WPT setters protocol #24" {
  let url = @url.Url::parse("ssh://example.net")
  url.set_scheme("file") catch {
    _ => ()
  }
  assert_eq(js_href(url), "ssh://example.net")
  assert_eq(js_protocol(url), "ssh:")
}

///|
test "WPT setters protocol #25" {
  let url = @url.Url::parse("nonsense:///test")
  url.set_scheme("https") catch {
    _ => ()
  }
  assert_eq(js_href(url), "nonsense:///test")
  assert_eq(js_protocol(url), "nonsense:")
}

///|
test "WPT setters protocol #26" {
  let url = @url.Url::parse("http://example.net")
  url.set_scheme("https") catch {
    _ => ()
  }
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_protocol(url), "https:")
}

///|
test "WPT setters protocol #27" {
  let url = @url.Url::parse("data:text/html,<p>Test")
  url.set_scheme("view-source+data") catch {
    _ => ()
  }
  assert_eq(js_href(url), "view-source+data:text/html,<p>Test")
  assert_eq(js_protocol(url), "view-source+data:")
}

///|
test "WPT setters protocol #28" {
  let url = @url.Url::parse("http://foo.com:443/")
  url.set_scheme("https") catch {
    _ => ()
  }
  assert_eq(js_href(url), "https://foo.com/")
  assert_eq(js_protocol(url), "https:")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters protocol #29" {
  let url = @url.Url::parse("http://test/")
  url.set_scheme("https") catch {
    _ => ()
  }
  assert_eq(js_href(url), "https://test/")
  assert_eq(js_protocol(url), "https:")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters protocol #30" {
  let url = @url.Url::parse("http://test/")
  url.set_scheme("https") catch {
    _ => ()
  }
  assert_eq(js_href(url), "https://test/")
  assert_eq(js_protocol(url), "https:")
}

///|
test "WPT setters protocol #31" {
  let url = @url.Url::parse("http://test/")
  url.set_scheme("https\u{0}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://test/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #32" {
  let url = @url.Url::parse("http://test/")
  url.set_scheme("https\u{C}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://test/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #33" {
  let url = @url.Url::parse("http://test/")
  url.set_scheme("https\u{E}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://test/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #34" {
  let url = @url.Url::parse("http://test/")
  url.set_scheme("https ") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://test/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters username #0" {
  let url = @url.Url::parse("file:///home/you/index.html")
  url.set_username("me") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file:///home/you/index.html")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #1" {
  let url = @url.Url::parse("unix:/run/foo.socket")
  url.set_username("me") catch {
    _ => ()
  }
  assert_eq(js_href(url), "unix:/run/foo.socket")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #2" {
  let url = @url.Url::parse("mailto:you@example.net")
  url.set_username("me") catch {
    _ => ()
  }
  assert_eq(js_href(url), "mailto:you@example.net")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #3" {
  let url = @url.Url::parse("javascript:alert(1)")
  url.set_username("wario") catch {
    _ => ()
  }
  assert_eq(js_href(url), "javascript:alert(1)")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #4" {
  let url = @url.Url::parse("http://example.net")
  url.set_username("me") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://me@example.net/")
  assert_eq(url.username(), "me")
}

///|
test "WPT setters username #5" {
  let url = @url.Url::parse("http://:secret@example.net")
  url.set_username("me") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://me:secret@example.net/")
  assert_eq(url.username(), "me")
}

///|
test "WPT setters username #6" {
  let url = @url.Url::parse("http://me@example.net")
  url.set_username("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #7" {
  let url = @url.Url::parse("http://me:secret@example.net")
  url.set_username("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://:secret@example.net/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #8" {
  let url = @url.Url::parse("http://example.net")
  url.set_username(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  ) catch {
    _ => ()
  }
  assert_eq(
    js_href(url),
    "http://%00%01%09%0A%0D%1F%20!%22%23$%&'()*+,-.%2F09%3A%3B%3C%3D%3E%3F%40AZ%5B%5C%5D%5E_%60az%7B%7C%7D~%7F%C2%80%C2%81%C3%89%C3%A9@example.net/",
  )
  assert_eq(
    url.username(),
    "%00%01%09%0A%0D%1F%20!%22%23$%&'()*+,-.%2F09%3A%3B%3C%3D%3E%3F%40AZ%5B%5C%5D%5E_%60az%7B%7C%7D~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters username #9" {
  let url = @url.Url::parse("http://example.net")
  url.set_username("%c3%89t\u{E9}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://%c3%89t%C3%A9@example.net/")
  assert_eq(url.username(), "%c3%89t%C3%A9")
}

///|
test "WPT setters username #10" {
  let url = @url.Url::parse("sc:///")
  url.set_username("x") catch {
    _ => ()
  }
  assert_eq(js_href(url), "sc:///")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #11" {
  let url = @url.Url::parse("javascript://x/")
  url.set_username("wario") catch {
    _ => ()
  }
  assert_eq(js_href(url), "javascript://wario@x/")
  assert_eq(url.username(), "wario")
}

///|
test "WPT setters username #12" {
  let url = @url.Url::parse("file://test/")
  url.set_username("test") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file://test/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters password #0" {
  let url = @url.Url::parse("file:///home/me/index.html")
  url.set_password("secret") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file:///home/me/index.html")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #1" {
  let url = @url.Url::parse("unix:/run/foo.socket")
  url.set_password("secret") catch {
    _ => ()
  }
  assert_eq(js_href(url), "unix:/run/foo.socket")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #2" {
  let url = @url.Url::parse("mailto:me@example.net")
  url.set_password("secret") catch {
    _ => ()
  }
  assert_eq(js_href(url), "mailto:me@example.net")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #3" {
  let url = @url.Url::parse("http://example.net")
  url.set_password("secret") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://:secret@example.net/")
  assert_eq(url.password(), "secret")
}

///|
test "WPT setters password #4" {
  let url = @url.Url::parse("http://me@example.net")
  url.set_password("secret") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://me:secret@example.net/")
  assert_eq(url.password(), "secret")
}

///|
test "WPT setters password #5" {
  let url = @url.Url::parse("http://:secret@example.net")
  url.set_password("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #6" {
  let url = @url.Url::parse("http://me:secret@example.net")
  url.set_password("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://me@example.net/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #7" {
  let url = @url.Url::parse("http://example.net")
  url.set_password(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  ) catch {
    _ => ()
  }
  assert_eq(
    js_href(url),
    "http://:%00%01%09%0A%0D%1F%20!%22%23$%&'()*+,-.%2F09%3A%3B%3C%3D%3E%3F%40AZ%5B%5C%5D%5E_%60az%7B%7C%7D~%7F%C2%80%C2%81%C3%89%C3%A9@example.net/",
  )
  assert_eq(
    url.password(),
    "%00%01%09%0A%0D%1F%20!%22%23$%&'()*+,-.%2F09%3A%3B%3C%3D%3E%3F%40AZ%5B%5C%5D%5E_%60az%7B%7C%7D~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters password #8" {
  let url = @url.Url::parse("http://example.net")
  url.set_password("%c3%89t\u{E9}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://:%c3%89t%C3%A9@example.net/")
  assert_eq(url.password(), "%c3%89t%C3%A9")
}

///|
test "WPT setters password #9" {
  let url = @url.Url::parse("sc:///")
  url.set_password("x") catch {
    _ => ()
  }
  assert_eq(js_href(url), "sc:///")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #10" {
  let url = @url.Url::parse("javascript://x/")
  url.set_password("bowser") catch {
    _ => ()
  }
  assert_eq(js_href(url), "javascript://:bowser@x/")
  assert_eq(url.password(), "bowser")
}

///|
test "WPT setters password #11" {
  let url = @url.Url::parse("file://test/")
  url.set_password("test") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file://test/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters pathname #0" {
  let url = @url.Url::parse("mailto:me@example.net")
  url.set_pathname("/foo") catch {
    _ => ()
  }
  assert_eq(js_href(url), "mailto:me@example.net")
  assert_eq(js_pathname(url), "me@example.net")
}

///|
test "WPT setters pathname #1" {
  let url = @url.Url::parse("data:original")
  url.set_pathname("new value") catch {
    _ => ()
  }
  assert_eq(js_href(url), "data:original")
  assert_eq(js_pathname(url), "original")
}

///|
test "WPT setters pathname #2" {
  let url = @url.Url::parse("sc:original")
  url.set_pathname("new value") catch {
    _ => ()
  }
  assert_eq(js_href(url), "sc:original")
  assert_eq(js_pathname(url), "original")
}

///|
test "WPT setters pathname #3" {
  let url = @url.Url::parse("file:///some/path")
  url.set_pathname("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file:///")
  assert_eq(js_pathname(url), "/")
}

///|
test "WPT setters pathname #4" {
  let url = @url.Url::parse("foo://somehost/some/path")
  url.set_pathname("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "foo://somehost")
  assert_eq(js_pathname(url), "")
}

///|
test "WPT setters pathname #5" {
  let url = @url.Url::parse("foo:///some/path")
  url.set_pathname("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "foo://")
  assert_eq(js_pathname(url), "")
}

///|
test "WPT setters pathname #6" {
  let url = @url.Url::parse("foo:/some/path")
  url.set_pathname("") catch {
    _ => ()
  }
  assert_eq(js_href(url), "foo:/")
  assert_eq(js_pathname(url), "/")
}

///|
test "WPT setters pathname #7" {
  let url = @url.Url::parse("foo:/some/path")
  url.set_pathname("test") catch {
    _ => ()
  }
  assert_eq(js_href(url), "foo:/test")
  assert_eq(js_pathname(url), "/test")
}

///|
test "WPT setters pathname #8" {
  let url = @url.Url::parse("unix:/run/foo.socket?timeout=10")
  url.set_pathname("/var/log/../run/bar.socket") catch {
    _ => ()
  }
  assert_eq(js_href(url), "unix:/var/run/bar.socket?timeout=10")
  assert_eq(js_pathname(url), "/var/run/bar.socket")
}

///|
test "WPT setters pathname #9" {
  let url = @url.Url::parse("https://example.net#nav")
  url.set_pathname("home") catch {
    _ => ()
  }
  assert_eq(js_href(url), "https://example.net/home#nav")
  assert_eq(js_pathname(url), "/home")
}

///|
test "WPT setters pathname #10" {
  let url = @url.Url::parse("https://example.net#nav")
  url.set_pathname("../home") catch {
    _ => ()
  }
  assert_eq(js_href(url), "https://example.net/home#nav")
  assert_eq(js_pathname(url), "/home")
}

///|
test "WPT setters pathname #11" {
  let url = @url.Url::parse("http://example.net/home?lang=fr#nav")
  url.set_pathname("\\a\\%2E\\b\\%2e.\\c") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/a/c?lang=fr#nav")
  assert_eq(js_pathname(url), "/a/c")
}

///|
test "WPT setters pathname #12" {
  let url = @url.Url::parse("view-source+http://example.net/home?lang=fr#nav")
  url.set_pathname("\\a\\%2E\\b\\%2e.\\c") catch {
    _ => ()
  }
  assert_eq(
    js_href(url),
    "view-source+http://example.net/\\a\\%2E\\b\\%2e.\\c?lang=fr#nav",
  )
  assert_eq(js_pathname(url), "/\\a\\%2E\\b\\%2e.\\c")
}

///|
test "WPT setters pathname #13" {
  let url = @url.Url::parse("a:/")
  url.set_pathname(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  ) catch {
    _ => ()
  }
  assert_eq(
    js_href(url),
    "a:/%00%01%1F%20!%22%23$%&'()*+,-./09:;%3C=%3E%3F@AZ[\\]%5E_%60az%7B|%7D~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
  assert_eq(
    js_pathname(url),
    "/%00%01%1F%20!%22%23$%&'()*+,-./09:;%3C=%3E%3F@AZ[\\]%5E_%60az%7B|%7D~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters pathname #14" {
  let url = @url.Url::parse("http://example.net")
  url.set_pathname("%2e%2E%c3%89t\u{E9}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/%2e%2E%c3%89t%C3%A9")
  assert_eq(js_pathname(url), "/%2e%2E%c3%89t%C3%A9")
}

///|
test "WPT setters pathname #15" {
  let url = @url.Url::parse("http://example.net")
  url.set_pathname("?") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/%3F")
  assert_eq(js_pathname(url), "/%3F")
}

///|
test "WPT setters pathname #16" {
  let url = @url.Url::parse("http://example.net")
  url.set_pathname("#") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/%23")
  assert_eq(js_pathname(url), "/%23")
}

///|
test "WPT setters pathname #17" {
  let url = @url.Url::parse("sc://example.net")
  url.set_pathname("?") catch {
    _ => ()
  }
  assert_eq(js_href(url), "sc://example.net/%3F")
  assert_eq(js_pathname(url), "/%3F")
}

///|
test "WPT setters pathname #18" {
  let url = @url.Url::parse("sc://example.net")
  url.set_pathname("#") catch {
    _ => ()
  }
  assert_eq(js_href(url), "sc://example.net/%23")
  assert_eq(js_pathname(url), "/%23")
}

///|
test "WPT setters pathname #19" {
  let url = @url.Url::parse("http://example.net")
  url.set_pathname("/?\u{E9}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/%3F%C3%A9")
  assert_eq(js_pathname(url), "/%3F%C3%A9")
}

///|
test "WPT setters pathname #20" {
  let url = @url.Url::parse("http://example.net")
  url.set_pathname("/#\u{E9}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/%23%C3%A9")
  assert_eq(js_pathname(url), "/%23%C3%A9")
}

///|
test "WPT setters pathname #21" {
  let url = @url.Url::parse("file://monkey/")
  url.set_pathname("\\\\") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file://monkey//")
  assert_eq(js_pathname(url), "//")
}

///|
test "WPT setters pathname #22" {
  let url = @url.Url::parse("file:///unicorn")
  url.set_pathname("//\\/") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file://////")
  assert_eq(js_pathname(url), "////")
}

///|
test "WPT setters pathname #23" {
  let url = @url.Url::parse("file:///unicorn")
  url.set_pathname("//monkey/..//") catch {
    _ => ()
  }
  assert_eq(js_href(url), "file://///")
  assert_eq(js_pathname(url), "///")
}

///|
test "WPT setters pathname #24" {
  let url = @url.Url::parse("non-spec:/")
  url.set_pathname("/.//p") catch {
    _ => ()
  }
  assert_eq(js_href(url), "non-spec:/.//p")
  assert_eq(js_pathname(url), "//p")
}

///|
test "WPT setters pathname #25" {
  let url = @url.Url::parse("non-spec:/")
  url.set_pathname("/..//p") catch {
    _ => ()
  }
  assert_eq(js_href(url), "non-spec:/.//p")
  assert_eq(js_pathname(url), "//p")
}

///|
test "WPT setters pathname #26" {
  let url = @url.Url::parse("non-spec:/")
  url.set_pathname("//p") catch {
    _ => ()
  }
  assert_eq(js_href(url), "non-spec:/.//p")
  assert_eq(js_pathname(url), "//p")
}

///|
test "WPT setters pathname #27" {
  let url = @url.Url::parse("non-spec:/.//")
  url.set_pathname("p") catch {
    _ => ()
  }
  assert_eq(js_href(url), "non-spec:/p")
  assert_eq(js_pathname(url), "/p")
}

///|
test "WPT setters pathname #28" {
  let url = @url.Url::parse("data:/nospace")
  url.set_pathname("space ") catch {
    _ => ()
  }
  assert_eq(js_href(url), "data:/space%20")
  assert_eq(js_pathname(url), "/space%20")
}

///|
test "WPT setters pathname #29" {
  let url = @url.Url::parse("sc:/nospace")
  url.set_pathname("space ") catch {
    _ => ()
  }
  assert_eq(js_href(url), "sc:/space%20")
  assert_eq(js_pathname(url), "/space%20")
}

///|
test "WPT setters pathname #30" {
  let url = @url.Url::parse("http://example.net")
  url.set_pathname(" ") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/%20")
  assert_eq(js_pathname(url), "/%20")
}

///|
test "WPT setters pathname #31" {
  let url = @url.Url::parse("http://example.net")
  url.set_pathname("\u{0}") catch {
    _ => ()
  }
  assert_eq(js_href(url), "http://example.net/%00")
  assert_eq(js_pathname(url), "/%00")
}

///|
test "WPT setters pathname #32" {
  let url = @url.Url::parse("foo://path/to")
  url.set_pathname("/..") catch {
    _ => ()
  }
  assert_eq(js_href(url), "foo://path/")
  assert_eq(js_pathname(url), "/")
}

///|
test "WPT setters search #0" {
  let url = @url.Url::parse("https://example.net#nav")
  url.set_query(Some("lang=fr"))
  assert_eq(js_href(url), "https://example.net/?lang=fr#nav")
  assert_eq(js_search(url), "?lang=fr")
}

///|
test "WPT setters search #1" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  url.set_query(Some("lang=fr"))
  assert_eq(js_href(url), "https://example.net/?lang=fr#nav")
  assert_eq(js_search(url), "?lang=fr")
}

///|
test "WPT setters search #2" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  url.set_query(Some("lang=fr"))
  assert_eq(js_href(url), "https://example.net/?lang=fr#nav")
  assert_eq(js_search(url), "?lang=fr")
}

///|
test "WPT setters search #3" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  url.set_query(Some("?lang=fr"))
  assert_eq(js_href(url), "https://example.net/??lang=fr#nav")
  assert_eq(js_search(url), "??lang=fr")
}

///|
test "WPT setters search #4" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  url.set_query(Some(""))
  assert_eq(js_href(url), "https://example.net/?#nav")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #5" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  url.set_query(None)
  assert_eq(js_href(url), "https://example.net/#nav")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #6" {
  let url = @url.Url::parse("https://example.net?lang=en-US")
  url.set_query(None)
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #7" {
  let url = @url.Url::parse("https://example.net")
  url.set_query(None)
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #8" {
  let url = @url.Url::parse("a:/")
  url.set_query(
    Some(
      "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
    ),
  )
  assert_eq(
    js_href(url),
    "a:/?%00%01%1F%20!%22%23$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_`az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
  assert_eq(
    js_search(url),
    "?%00%01%1F%20!%22%23$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_`az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters search #9" {
  let url = @url.Url::parse("http://example.net")
  url.set_query(Some("%c3%89t\u{E9}"))
  assert_eq(js_href(url), "http://example.net/?%c3%89t%C3%A9")
  assert_eq(js_search(url), "?%c3%89t%C3%A9")
}

///|
test "WPT setters search #10" {
  let url = @url.Url::parse("data:space ?query")
  url.set_query(None)
  assert_eq(js_href(url), "data:space%20")
  assert_eq(js_pathname(url), "space%20")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #11" {
  let url = @url.Url::parse("sc:space ?query")
  url.set_query(None)
  assert_eq(js_href(url), "sc:space%20")
  assert_eq(js_pathname(url), "space%20")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #12" {
  let url = @url.Url::parse("data:space  ?query#fragment")
  url.set_query(None)
  assert_eq(js_href(url), "data:space %20#fragment")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #13" {
  let url = @url.Url::parse("sc:space  ?query#fragment")
  url.set_query(None)
  assert_eq(js_href(url), "sc:space %20#fragment")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #14" {
  let url = @url.Url::parse("http://example.net")
  url.set_query(Some(" "))
  assert_eq(js_href(url), "http://example.net/?%20")
  assert_eq(js_search(url), "?%20")
}

///|
test "WPT setters search #15" {
  let url = @url.Url::parse("http://example.net")
  url.set_query(Some("\u{0}"))
  assert_eq(js_href(url), "http://example.net/?%00")
  assert_eq(js_search(url), "?%00")
}

///|
test "WPT setters hash #0" {
  let url = @url.Url::parse("https://example.net")
  url.set_fragment(Some("main"))
  assert_eq(js_href(url), "https://example.net/#main")
  assert_eq(js_hash(url), "#main")
}

///|
test "WPT setters hash #1" {
  let url = @url.Url::parse("https://example.net#nav")
  url.set_fragment(Some("main"))
  assert_eq(js_href(url), "https://example.net/#main")
  assert_eq(js_hash(url), "#main")
}

///|
test "WPT setters hash #2" {
  let url = @url.Url::parse("https://example.net?lang=en-US")
  url.set_fragment(Some("#nav"))
  assert_eq(js_href(url), "https://example.net/?lang=en-US##nav")
  assert_eq(js_hash(url), "##nav")
}

///|
test "WPT setters hash #3" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  url.set_fragment(Some("main"))
  assert_eq(js_href(url), "https://example.net/?lang=en-US#main")
  assert_eq(js_hash(url), "#main")
}

///|
test "WPT setters hash #4" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  url.set_fragment(Some(""))
  assert_eq(js_href(url), "https://example.net/?lang=en-US#")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #5" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  url.set_fragment(None)
  assert_eq(js_href(url), "https://example.net/?lang=en-US")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #6" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some("foo bar"))
  assert_eq(js_href(url), "http://example.net/#foo%20bar")
  assert_eq(js_hash(url), "#foo%20bar")
}

///|
test "WPT setters hash #7" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some("foo\"bar"))
  assert_eq(js_href(url), "http://example.net/#foo%22bar")
  assert_eq(js_hash(url), "#foo%22bar")
}

///|
test "WPT setters hash #8" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some("foo<bar"))
  assert_eq(js_href(url), "http://example.net/#foo%3Cbar")
  assert_eq(js_hash(url), "#foo%3Cbar")
}

///|
test "WPT setters hash #9" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some("foo>bar"))
  assert_eq(js_href(url), "http://example.net/#foo%3Ebar")
  assert_eq(js_hash(url), "#foo%3Ebar")
}

///|
test "WPT setters hash #10" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some("foo`bar"))
  assert_eq(js_href(url), "http://example.net/#foo%60bar")
  assert_eq(js_hash(url), "#foo%60bar")
}

///|
test "WPT setters hash #11" {
  let url = @url.Url::parse("a:/")
  url.set_fragment(
    Some(
      "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
    ),
  )
  assert_eq(
    js_href(url),
    "a:/#%00%01%1F%20!%22#$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_%60az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
  assert_eq(
    js_hash(url),
    "#%00%01%1F%20!%22#$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_%60az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters hash #12" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some("a\u{0}b"))
  assert_eq(js_href(url), "http://example.net/#a%00b")
  assert_eq(js_hash(url), "#a%00b")
}

///|
test "WPT setters hash #13" {
  let url = @url.Url::parse("non-spec:/")
  url.set_fragment(Some("a\u{0}b"))
  assert_eq(js_href(url), "non-spec:/#a%00b")
  assert_eq(js_hash(url), "#a%00b")
}

///|
test "WPT setters hash #14" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some("%c3%89t\u{E9}"))
  assert_eq(js_href(url), "http://example.net/#%c3%89t%C3%A9")
  assert_eq(js_hash(url), "#%c3%89t%C3%A9")
}

///|
test "WPT setters hash #15" {
  let url = @url.Url::parse("javascript:alert(1)")
  url.set_fragment(Some("castle"))
  assert_eq(js_href(url), "javascript:alert(1)#castle")
  assert_eq(js_hash(url), "#castle")
}

///|
test "WPT setters hash #16" {
  let url = @url.Url::parse(
    "data:space                                                                                                                                  #fragment",
  )
  url.set_fragment(None)
  assert_eq(
    js_href(url),
    "data:space                                                                                                                                 %20",
  )
  assert_eq(
    js_pathname(url),
    "space                                                                                                                                 %20",
  )
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #17" {
  let url = @url.Url::parse("sc:space    #fragment")
  url.set_fragment(None)
  assert_eq(js_href(url), "sc:space   %20")
  assert_eq(js_pathname(url), "space   %20")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #18" {
  let url = @url.Url::parse("data:space  ?query#fragment")
  url.set_fragment(None)
  assert_eq(js_href(url), "data:space %20?query")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #19" {
  let url = @url.Url::parse("sc:space  ?query#fragment")
  url.set_fragment(None)
  assert_eq(js_href(url), "sc:space %20?query")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #20" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some(" "))
  assert_eq(js_href(url), "http://example.net/#%20")
  assert_eq(js_hash(url), "#%20")
}

///|
test "WPT setters hash #21" {
  let url = @url.Url::parse("http://example.net")
  url.set_fragment(Some("\u{0}"))
  assert_eq(js_href(url), "http://example.net/#%00")
  assert_eq(js_hash(url), "#%00")
}

///|
test "WPT setters hash #22" {
  let url = @url.Url::parse("data:text/plain,test")
  url.set_fragment(Some("<foo> <bar>"))
  assert_eq(js_href(url), "data:text/plain,test#%3Cfoo%3E%20%3Cbar%3E")
  assert_eq(js_hash(url), "#%3Cfoo%3E%20%3Cbar%3E")
}

///|
test "WPT setters hash #23" {
  let url = @url.Url::parse("about:blank")
  url.set_fragment(Some("<foo> <bar>"))
  assert_eq(js_href(url), "about:blank#%3Cfoo%3E%20%3Cbar%3E")
  assert_eq(js_hash(url), "#%3Cfoo%3E%20%3Cbar%3E")
}

///|
test "WPT setters hash #24" {
  let url = @url.Url::parse("data:text/plain,test")
  url.set_fragment(
    Some(
      "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
    ),
  )
  assert_eq(
    js_href(url),
    "data:text/plain,test#%00%01%1F%20!%22#$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_%60az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
  assert_eq(
    js_hash(url),
    "#%00%01%1F%20!%22#$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_%60az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters hash #25" {
  let url = @url.Url::parse("about:blank")
  url.set_fragment(
    Some(
      "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
    ),
  )
  assert_eq(
    js_href(url),
    "about:blank#%00%01%1F%20!%22#$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_%60az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
  assert_eq(
    js_hash(url),
    "#%00%01%1F%20!%22#$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_%60az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}
