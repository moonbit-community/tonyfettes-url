// Auto-generated from WPT setters_tests.json
// https://github.com/web-platform-tests/wpt/blob/master/url/resources/setters_tests.json
// Do not edit manually
//
// To regenerate: python3 scripts/generate_wpt_setters_tests.py > wpt_setters_wbtest.mbt
//
// These tests exercise the deprecated JavaScript-style setters, so they live
// in a white-box file where intra-package deprecation warnings are skipped.
// The expected values are the JavaScript getter views, computed here from the
// typed getters.

///|
fn js_href(url : Url) -> String {
  url.to_string()
}

///|
fn js_protocol(url : Url) -> String {
  "\{url.scheme()}:"
}

///|
fn js_hostname(url : Url) -> String {
  if url.host() is Some(host) {
    host.to_string()
  } else {
    ""
  }
}

///|
fn js_port(url : Url) -> String {
  if url.port() is Some(port) {
    port.to_string()
  } else {
    ""
  }
}

///|
fn js_host(url : Url) -> String {
  let hostname = js_hostname(url)
  if url.port() is Some(port) {
    "\{hostname}:\{port}"
  } else {
    hostname
  }
}

///|
fn js_pathname(url : Url) -> String {
  url.path().to_string()
}

///|
fn js_search(url : Url) -> String {
  match url.query() {
    Some("") | None => ""
    Some(query) => "?\{query}"
  }
}

///|
fn js_hash(url : Url) -> String {
  match url.fragment() {
    Some("") | None => ""
    Some(fragment) => "#\{fragment}"
  }
}

///|
test "WPT setters href #0" {
  let url = Url::parse("file:///var/log/system.log")
  url.set_href("http://0300.168.0xF0")
  assert_eq(js_href(url), "http://192.168.0.240/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #0" {
  let url = Url::parse("a://example.net")
  url.set_protocol("")
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #1" {
  let url = Url::parse("a://example.net")
  url.set_protocol("b")
  assert_eq(js_href(url), "b://example.net")
  assert_eq(js_protocol(url), "b:")
}

///|
test "WPT setters protocol #2" {
  let url = Url::parse("javascript:alert(1)")
  url.set_protocol("defuse")
  assert_eq(js_href(url), "defuse:alert(1)")
  assert_eq(js_protocol(url), "defuse:")
}

///|
test "WPT setters protocol #3" {
  let url = Url::parse("a://example.net")
  url.set_protocol("B")
  assert_eq(js_href(url), "b://example.net")
  assert_eq(js_protocol(url), "b:")
}

///|
test "WPT setters protocol #4" {
  let url = Url::parse("a://example.net")
  url.set_protocol("\u{E9}")
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #5" {
  let url = Url::parse("a://example.net")
  url.set_protocol("0b")
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #6" {
  let url = Url::parse("a://example.net")
  url.set_protocol("+b")
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #7" {
  let url = Url::parse("a://example.net")
  url.set_protocol("bC0+-.")
  assert_eq(js_href(url), "bc0+-.://example.net")
  assert_eq(js_protocol(url), "bc0+-.:")
}

///|
test "WPT setters protocol #8" {
  let url = Url::parse("a://example.net")
  url.set_protocol("b,c")
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #9" {
  let url = Url::parse("a://example.net")
  url.set_protocol("b\u{E9}")
  assert_eq(js_href(url), "a://example.net")
  assert_eq(js_protocol(url), "a:")
}

///|
test "WPT setters protocol #10" {
  let url = Url::parse("http://test@example.net")
  url.set_protocol("file")
  assert_eq(js_href(url), "http://test@example.net/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #11" {
  let url = Url::parse("https://example.net:1234")
  url.set_protocol("file")
  assert_eq(js_href(url), "https://example.net:1234/")
  assert_eq(js_protocol(url), "https:")
}

///|
test "WPT setters protocol #12" {
  let url = Url::parse("wss://x:x@example.net:1234")
  url.set_protocol("file")
  assert_eq(js_href(url), "wss://x:x@example.net:1234/")
  assert_eq(js_protocol(url), "wss:")
}

///|
test "WPT setters protocol #13" {
  let url = Url::parse("file://localhost/")
  url.set_protocol("http")
  assert_eq(js_href(url), "file:///")
  assert_eq(js_protocol(url), "file:")
}

///|
test "WPT setters protocol #14" {
  let url = Url::parse("file:///test")
  url.set_protocol("https")
  assert_eq(js_href(url), "file:///test")
  assert_eq(js_protocol(url), "file:")
}

///|
test "WPT setters protocol #15" {
  let url = Url::parse("file:")
  url.set_protocol("wss")
  assert_eq(js_href(url), "file:///")
  assert_eq(js_protocol(url), "file:")
}

///|
test "WPT setters protocol #16" {
  let url = Url::parse("http://example.net")
  url.set_protocol("b")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #17" {
  let url = Url::parse("file://hi/path")
  url.set_protocol("s")
  assert_eq(js_href(url), "file://hi/path")
  assert_eq(js_protocol(url), "file:")
}

///|
test "WPT setters protocol #18" {
  let url = Url::parse("https://example.net")
  url.set_protocol("s")
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_protocol(url), "https:")
}

///|
test "WPT setters protocol #19" {
  let url = Url::parse("ftp://example.net")
  url.set_protocol("test")
  assert_eq(js_href(url), "ftp://example.net/")
  assert_eq(js_protocol(url), "ftp:")
}

///|
test "WPT setters protocol #20" {
  let url = Url::parse("mailto:me@example.net")
  url.set_protocol("http")
  assert_eq(js_href(url), "mailto:me@example.net")
  assert_eq(js_protocol(url), "mailto:")
}

///|
test "WPT setters protocol #21" {
  let url = Url::parse("ssh://me@example.net")
  url.set_protocol("http")
  assert_eq(js_href(url), "ssh://me@example.net")
  assert_eq(js_protocol(url), "ssh:")
}

///|
test "WPT setters protocol #22" {
  let url = Url::parse("ssh://me@example.net")
  url.set_protocol("https")
  assert_eq(js_href(url), "ssh://me@example.net")
  assert_eq(js_protocol(url), "ssh:")
}

///|
test "WPT setters protocol #23" {
  let url = Url::parse("ssh://me@example.net")
  url.set_protocol("file")
  assert_eq(js_href(url), "ssh://me@example.net")
  assert_eq(js_protocol(url), "ssh:")
}

///|
test "WPT setters protocol #24" {
  let url = Url::parse("ssh://example.net")
  url.set_protocol("file")
  assert_eq(js_href(url), "ssh://example.net")
  assert_eq(js_protocol(url), "ssh:")
}

///|
test "WPT setters protocol #25" {
  let url = Url::parse("nonsense:///test")
  url.set_protocol("https")
  assert_eq(js_href(url), "nonsense:///test")
  assert_eq(js_protocol(url), "nonsense:")
}

///|
test "WPT setters protocol #26" {
  let url = Url::parse("http://example.net")
  url.set_protocol("https:foo : bar")
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_protocol(url), "https:")
}

///|
test "WPT setters protocol #27" {
  let url = Url::parse("data:text/html,<p>Test")
  url.set_protocol("view-source+data:foo : bar")
  assert_eq(js_href(url), "view-source+data:text/html,<p>Test")
  assert_eq(js_protocol(url), "view-source+data:")
}

///|
test "WPT setters protocol #28" {
  let url = Url::parse("http://foo.com:443/")
  url.set_protocol("https")
  assert_eq(js_href(url), "https://foo.com/")
  assert_eq(js_protocol(url), "https:")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters protocol #29" {
  let url = Url::parse("http://test/")
  url.set_protocol("h\r\ntt\tps")
  assert_eq(js_href(url), "https://test/")
  assert_eq(js_protocol(url), "https:")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters protocol #30" {
  let url = Url::parse("http://test/")
  url.set_protocol("https\r")
  assert_eq(js_href(url), "https://test/")
  assert_eq(js_protocol(url), "https:")
}

///|
test "WPT setters protocol #31" {
  let url = Url::parse("http://test/")
  url.set_protocol("https\u{0}")
  assert_eq(js_href(url), "http://test/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #32" {
  let url = Url::parse("http://test/")
  url.set_protocol("https\u{C}")
  assert_eq(js_href(url), "http://test/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #33" {
  let url = Url::parse("http://test/")
  url.set_protocol("https\u{E}")
  assert_eq(js_href(url), "http://test/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters protocol #34" {
  let url = Url::parse("http://test/")
  url.set_protocol("https ")
  assert_eq(js_href(url), "http://test/")
  assert_eq(js_protocol(url), "http:")
}

///|
test "WPT setters username #0" {
  let url = Url::parse("file:///home/you/index.html")
  url.set_username("me")
  assert_eq(js_href(url), "file:///home/you/index.html")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #1" {
  let url = Url::parse("unix:/run/foo.socket")
  url.set_username("me")
  assert_eq(js_href(url), "unix:/run/foo.socket")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #2" {
  let url = Url::parse("mailto:you@example.net")
  url.set_username("me")
  assert_eq(js_href(url), "mailto:you@example.net")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #3" {
  let url = Url::parse("javascript:alert(1)")
  url.set_username("wario")
  assert_eq(js_href(url), "javascript:alert(1)")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #4" {
  let url = Url::parse("http://example.net")
  url.set_username("me")
  assert_eq(js_href(url), "http://me@example.net/")
  assert_eq(url.username(), "me")
}

///|
test "WPT setters username #5" {
  let url = Url::parse("http://:secret@example.net")
  url.set_username("me")
  assert_eq(js_href(url), "http://me:secret@example.net/")
  assert_eq(url.username(), "me")
}

///|
test "WPT setters username #6" {
  let url = Url::parse("http://me@example.net")
  url.set_username("")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #7" {
  let url = Url::parse("http://me:secret@example.net")
  url.set_username("")
  assert_eq(js_href(url), "http://:secret@example.net/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #8" {
  let url = Url::parse("http://example.net")
  url.set_username(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  )
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
  let url = Url::parse("http://example.net")
  url.set_username("%c3%89t\u{E9}")
  assert_eq(js_href(url), "http://%c3%89t%C3%A9@example.net/")
  assert_eq(url.username(), "%c3%89t%C3%A9")
}

///|
test "WPT setters username #10" {
  let url = Url::parse("sc:///")
  url.set_username("x")
  assert_eq(js_href(url), "sc:///")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #11" {
  let url = Url::parse("javascript://x/")
  url.set_username("wario")
  assert_eq(js_href(url), "javascript://wario@x/")
  assert_eq(url.username(), "wario")
}

///|
test "WPT setters username #12" {
  let url = Url::parse("file://test/")
  url.set_username("test")
  assert_eq(js_href(url), "file://test/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters password #0" {
  let url = Url::parse("file:///home/me/index.html")
  url.set_password("secret")
  assert_eq(js_href(url), "file:///home/me/index.html")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #1" {
  let url = Url::parse("unix:/run/foo.socket")
  url.set_password("secret")
  assert_eq(js_href(url), "unix:/run/foo.socket")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #2" {
  let url = Url::parse("mailto:me@example.net")
  url.set_password("secret")
  assert_eq(js_href(url), "mailto:me@example.net")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #3" {
  let url = Url::parse("http://example.net")
  url.set_password("secret")
  assert_eq(js_href(url), "http://:secret@example.net/")
  assert_eq(url.password(), "secret")
}

///|
test "WPT setters password #4" {
  let url = Url::parse("http://me@example.net")
  url.set_password("secret")
  assert_eq(js_href(url), "http://me:secret@example.net/")
  assert_eq(url.password(), "secret")
}

///|
test "WPT setters password #5" {
  let url = Url::parse("http://:secret@example.net")
  url.set_password("")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #6" {
  let url = Url::parse("http://me:secret@example.net")
  url.set_password("")
  assert_eq(js_href(url), "http://me@example.net/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #7" {
  let url = Url::parse("http://example.net")
  url.set_password(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  )
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
  let url = Url::parse("http://example.net")
  url.set_password("%c3%89t\u{E9}")
  assert_eq(js_href(url), "http://:%c3%89t%C3%A9@example.net/")
  assert_eq(url.password(), "%c3%89t%C3%A9")
}

///|
test "WPT setters password #9" {
  let url = Url::parse("sc:///")
  url.set_password("x")
  assert_eq(js_href(url), "sc:///")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #10" {
  let url = Url::parse("javascript://x/")
  url.set_password("bowser")
  assert_eq(js_href(url), "javascript://:bowser@x/")
  assert_eq(url.password(), "bowser")
}

///|
test "WPT setters password #11" {
  let url = Url::parse("file://test/")
  url.set_password("test")
  assert_eq(js_href(url), "file://test/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters host #0" {
  let url = Url::parse("sc://x/")
  url.set_host("\u{0}")
  assert_eq(js_href(url), "sc://x/")
  assert_eq(js_host(url), "x")
  assert_eq(js_hostname(url), "x")
}

///|
test "WPT setters host #1" {
  let url = Url::parse("sc://x/")
  url.set_host("\t")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters host #2" {
  let url = Url::parse("sc://x/")
  url.set_host("\n")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters host #3" {
  let url = Url::parse("sc://x/")
  url.set_host("\r")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters host #4" {
  let url = Url::parse("sc://x/")
  url.set_host(" ")
  assert_eq(js_href(url), "sc://x/")
  assert_eq(js_host(url), "x")
  assert_eq(js_hostname(url), "x")
}

///|
test "WPT setters host #5" {
  let url = Url::parse("sc://x/")
  url.set_host("#")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters host #6" {
  let url = Url::parse("sc://x/")
  url.set_host("/")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters host #7" {
  let url = Url::parse("sc://x/")
  url.set_host("?")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters host #8" {
  let url = Url::parse("sc://x/")
  url.set_host("@")
  assert_eq(js_href(url), "sc://x/")
  assert_eq(js_host(url), "x")
  assert_eq(js_hostname(url), "x")
}

///|
test "WPT setters host #9" {
  let url = Url::parse("sc://x/")
  url.set_host("\u{DF}")
  assert_eq(js_href(url), "sc://%C3%9F/")
  assert_eq(js_host(url), "%C3%9F")
  assert_eq(js_hostname(url), "%C3%9F")
}

///|
test "WPT setters host #10" {
  let url = Url::parse("https://x/")
  url.set_host("\u{DF}")
  assert_eq(js_href(url), "https://xn--zca/")
  assert_eq(js_host(url), "xn--zca")
  assert_eq(js_hostname(url), "xn--zca")
}

///|
test "WPT setters host #11" {
  let url = Url::parse("mailto:me@example.net")
  url.set_host("example.com")
  assert_eq(js_href(url), "mailto:me@example.net")
  assert_eq(js_host(url), "")
}

///|
test "WPT setters host #12" {
  let url = Url::parse("data:text/plain,Stuff")
  url.set_host("example.net")
  assert_eq(js_href(url), "data:text/plain,Stuff")
  assert_eq(js_host(url), "")
}

///|
test "WPT setters host #13" {
  let url = Url::parse("http://example.net")
  url.set_host("example.com:8080")
  assert_eq(js_href(url), "http://example.com:8080/")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #14" {
  let url = Url::parse("http://example.net:8080")
  url.set_host("example.com")
  assert_eq(js_href(url), "http://example.com:8080/")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #15" {
  let url = Url::parse("http://example.net:8080")
  url.set_host("example.com:")
  assert_eq(js_href(url), "http://example.com:8080/")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #16" {
  let url = Url::parse("http://example.net")
  url.set_host("")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
}

///|
test "WPT setters host #17" {
  let url = Url::parse("view-source+http://example.net/foo")
  url.set_host("")
  assert_eq(js_href(url), "view-source+http:///foo")
  assert_eq(js_host(url), "")
}

///|
test "WPT setters host #18" {
  let url = Url::parse("a:/foo")
  url.set_host("example.net")
  assert_eq(js_href(url), "a://example.net/foo")
  assert_eq(js_host(url), "example.net")
}

///|
test "WPT setters host #19" {
  let url = Url::parse("http://example.net")
  url.set_host("0x7F000001:8080")
  assert_eq(js_href(url), "http://127.0.0.1:8080/")
  assert_eq(js_host(url), "127.0.0.1:8080")
  assert_eq(js_hostname(url), "127.0.0.1")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #20" {
  let url = Url::parse("http://example.net")
  url.set_host("[::0:01]:2")
  assert_eq(js_href(url), "http://[::1]:2/")
  assert_eq(js_host(url), "[::1]:2")
  assert_eq(js_hostname(url), "[::1]")
  assert_eq(js_port(url), "2")
}

///|
test "WPT setters host #21" {
  let url = Url::parse("http://example.net")
  url.set_host("[2001:db8::2]:4002")
  assert_eq(js_href(url), "http://[2001:db8::2]:4002/")
  assert_eq(js_host(url), "[2001:db8::2]:4002")
  assert_eq(js_hostname(url), "[2001:db8::2]")
  assert_eq(js_port(url), "4002")
}

///|
test "WPT setters host #22" {
  let url = Url::parse("http://example.net")
  url.set_host("example.com:80")
  assert_eq(js_href(url), "http://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #23" {
  let url = Url::parse("https://example.net")
  url.set_host("example.com:443")
  assert_eq(js_href(url), "https://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #24" {
  let url = Url::parse("https://example.net")
  url.set_host("example.com:80")
  assert_eq(js_href(url), "https://example.com:80/")
  assert_eq(js_host(url), "example.com:80")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "80")
}

///|
test "WPT setters host #25" {
  let url = Url::parse("http://example.net:8080")
  url.set_host("example.com:80")
  assert_eq(js_href(url), "http://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #26" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com/stuff")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #27" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com:8080/stuff")
  assert_eq(js_href(url), "http://example.com:8080/path")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #28" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com?stuff")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #29" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com?stuff:8080")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #30" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com:8080?stuff")
  assert_eq(js_href(url), "http://example.com:8080/path")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #31" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com#stuff")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #32" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com:8080#stuff")
  assert_eq(js_href(url), "http://example.com:8080/path")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #33" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com\\stuff")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #34" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com:8080\\stuff")
  assert_eq(js_href(url), "http://example.com:8080/path")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #35" {
  let url = Url::parse("view-source+http://example.net/path")
  url.set_host("example.com\\stuff")
  assert_eq(js_href(url), "view-source+http://example.net/path")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #36" {
  let url = Url::parse("view-source+http://example.net/path")
  url.set_host("example.com:8080stuff2")
  assert_eq(js_href(url), "view-source+http://example.com:8080/path")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #37" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com:8080stuff2")
  assert_eq(js_href(url), "http://example.com:8080/path")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #38" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com:8080+2")
  assert_eq(js_href(url), "http://example.com:8080/path")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #39" {
  let url = Url::parse("http://example.net:8080")
  url.set_host("example.com:invalid")
  assert_eq(js_href(url), "http://example.com:8080/")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #40" {
  let url = Url::parse("http://example.net:8080/test")
  url.set_host("[::1]:invalid")
  assert_eq(js_href(url), "http://[::1]:8080/test")
  assert_eq(js_host(url), "[::1]:8080")
  assert_eq(js_hostname(url), "[::1]")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #41" {
  let url = Url::parse("http://example.net:8080/test")
  url.set_host("[::1]")
  assert_eq(js_href(url), "http://[::1]:8080/test")
  assert_eq(js_host(url), "[::1]:8080")
  assert_eq(js_hostname(url), "[::1]")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters host #42" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com:65535")
  assert_eq(js_href(url), "http://example.com:65535/path")
  assert_eq(js_host(url), "example.com:65535")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "65535")
}

///|
test "WPT setters host #43" {
  let url = Url::parse("http://example.net/path")
  url.set_host("example.com:65536")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #44" {
  let url = Url::parse("http://example.net/")
  url.set_host("[google.com]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters host #45" {
  let url = Url::parse("http://example.net/")
  url.set_host("[::1.2.3.4x]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters host #46" {
  let url = Url::parse("http://example.net/")
  url.set_host("[::1.2.3.]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters host #47" {
  let url = Url::parse("http://example.net/")
  url.set_host("[::1.2.]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters host #48" {
  let url = Url::parse("http://example.net/")
  url.set_host("[::1.]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters host #49" {
  let url = Url::parse("file://y/")
  url.set_host("x:123")
  assert_eq(js_href(url), "file://y/")
  assert_eq(js_host(url), "y")
  assert_eq(js_hostname(url), "y")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #50" {
  let url = Url::parse("file://y/")
  url.set_host("loc%41lhost")
  assert_eq(js_href(url), "file:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #51" {
  let url = Url::parse("file://hi/x")
  url.set_host("")
  assert_eq(js_href(url), "file:///x")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters host #52" {
  let url = Url::parse("sc://test@test/")
  url.set_host("")
  assert_eq(js_href(url), "sc://test@test/")
  assert_eq(url.username(), "test")
  assert_eq(js_host(url), "test")
  assert_eq(js_hostname(url), "test")
}

///|
test "WPT setters host #53" {
  let url = Url::parse("sc://test:12/")
  url.set_host("")
  assert_eq(js_href(url), "sc://test:12/")
  assert_eq(js_host(url), "test:12")
  assert_eq(js_hostname(url), "test")
  assert_eq(js_port(url), "12")
}

///|
test "WPT setters host #54" {
  let url = Url::parse("http://example.com/")
  url.set_host("///bad.com")
  assert_eq(js_href(url), "http://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
}

///|
test "WPT setters host #55" {
  let url = Url::parse("sc://example.com/")
  url.set_host("///bad.com")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters host #56" {
  let url = Url::parse("https://example.com/")
  url.set_host("a%C2%ADb")
  assert_eq(js_href(url), "https://ab/")
  assert_eq(js_host(url), "ab")
  assert_eq(js_hostname(url), "ab")
}

///|
test "WPT setters host #57" {
  let url = Url::parse("https://example.com/")
  url.set_host("\u{AD}")
  assert_eq(js_href(url), "https://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
}

///|
test "WPT setters host #58" {
  let url = Url::parse("https://example.com/")
  url.set_host("%C2%AD")
  assert_eq(js_href(url), "https://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
}

///|
test "WPT setters host #59" {
  let url = Url::parse("https://example.com/")
  url.set_host("xn--")
  assert_eq(js_href(url), "https://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
}

///|
test "WPT setters host #60" {
  let url = Url::parse("https://test.invalid/")
  url.set_host("*")
  assert_eq(js_href(url), "https://*/")
  assert_eq(js_host(url), "*")
  assert_eq(js_hostname(url), "*")
}

///|
test "WPT setters host #61" {
  let url = Url::parse("https://test.invalid/")
  url.set_host("x@x")
  assert_eq(js_href(url), "https://test.invalid/")
  assert_eq(js_host(url), "test.invalid")
  assert_eq(js_hostname(url), "test.invalid")
}

///|
test "WPT setters host #62" {
  let url = Url::parse("https://test.invalid/")
  url.set_host("foo\t\r\nbar")
  assert_eq(js_href(url), "https://foobar/")
  assert_eq(js_host(url), "foobar")
  assert_eq(js_hostname(url), "foobar")
}

///|
test "WPT setters host #63" {
  let url = Url::parse("https://test.invalid/")
  url.set_host("><")
  assert_eq(js_href(url), "https://test.invalid/")
  assert_eq(js_host(url), "test.invalid")
  assert_eq(js_hostname(url), "test.invalid")
}

///|
test "WPT setters host #64" {
  let url = Url::parse("https://test.invalid/")
  url.set_host("test/@aaa")
  assert_eq(js_href(url), "https://test/")
  assert_eq(js_host(url), "test")
  assert_eq(js_hostname(url), "test")
}

///|
test "WPT setters host #65" {
  let url = Url::parse("https://test.invalid/")
  url.set_host("test/:aaa")
  assert_eq(js_href(url), "https://test/")
  assert_eq(js_host(url), "test")
  assert_eq(js_hostname(url), "test")
}

///|
test "WPT setters host #66" {
  let url = Url::parse("foo://path/to")
  url.set_host(":80")
  assert_eq(js_href(url), "foo://path/to")
  assert_eq(js_host(url), "path")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #0" {
  let url = Url::parse("sc://x/")
  url.set_hostname("\u{0}")
  assert_eq(js_href(url), "sc://x/")
  assert_eq(js_host(url), "x")
  assert_eq(js_hostname(url), "x")
}

///|
test "WPT setters hostname #1" {
  let url = Url::parse("sc://x/")
  url.set_hostname("\t")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters hostname #2" {
  let url = Url::parse("sc://x/")
  url.set_hostname("\n")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters hostname #3" {
  let url = Url::parse("sc://x/")
  url.set_hostname("\r")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters hostname #4" {
  let url = Url::parse("sc://x/")
  url.set_hostname(" ")
  assert_eq(js_href(url), "sc://x/")
  assert_eq(js_host(url), "x")
  assert_eq(js_hostname(url), "x")
}

///|
test "WPT setters hostname #5" {
  let url = Url::parse("sc://x/")
  url.set_hostname("#")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters hostname #6" {
  let url = Url::parse("sc://x/")
  url.set_hostname("/")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters hostname #7" {
  let url = Url::parse("sc://x/")
  url.set_hostname("?")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters hostname #8" {
  let url = Url::parse("sc://x/")
  url.set_hostname("@")
  assert_eq(js_href(url), "sc://x/")
  assert_eq(js_host(url), "x")
  assert_eq(js_hostname(url), "x")
}

///|
test "WPT setters hostname #9" {
  let url = Url::parse("mailto:me@example.net")
  url.set_hostname("example.com")
  assert_eq(js_href(url), "mailto:me@example.net")
  assert_eq(js_host(url), "")
}

///|
test "WPT setters hostname #10" {
  let url = Url::parse("data:text/plain,Stuff")
  url.set_hostname("example.net")
  assert_eq(js_href(url), "data:text/plain,Stuff")
  assert_eq(js_host(url), "")
}

///|
test "WPT setters hostname #11" {
  let url = Url::parse("http://example.net:8080")
  url.set_hostname("example.com")
  assert_eq(js_href(url), "http://example.com:8080/")
  assert_eq(js_host(url), "example.com:8080")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters hostname #12" {
  let url = Url::parse("http://example.net")
  url.set_hostname("")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
}

///|
test "WPT setters hostname #13" {
  let url = Url::parse("view-source+http://example.net/foo")
  url.set_hostname("")
  assert_eq(js_href(url), "view-source+http:///foo")
  assert_eq(js_host(url), "")
}

///|
test "WPT setters hostname #14" {
  let url = Url::parse("a:/foo")
  url.set_hostname("example.net")
  assert_eq(js_href(url), "a://example.net/foo")
  assert_eq(js_host(url), "example.net")
}

///|
test "WPT setters hostname #15" {
  let url = Url::parse("http://example.net:8080")
  url.set_hostname("0x7F000001")
  assert_eq(js_href(url), "http://127.0.0.1:8080/")
  assert_eq(js_host(url), "127.0.0.1:8080")
  assert_eq(js_hostname(url), "127.0.0.1")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters hostname #16" {
  let url = Url::parse("http://example.net")
  url.set_hostname("[::0:01]")
  assert_eq(js_href(url), "http://[::1]/")
  assert_eq(js_host(url), "[::1]")
  assert_eq(js_hostname(url), "[::1]")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #17" {
  let url = Url::parse("http://example.net/path")
  url.set_hostname("example.com:8080")
  assert_eq(js_href(url), "http://example.net/path")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #18" {
  let url = Url::parse("http://example.net:8080/path")
  url.set_hostname("example.com:")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters hostname #19" {
  let url = Url::parse("http://example.net/path")
  url.set_hostname("example.com/stuff")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #20" {
  let url = Url::parse("http://example.net/path")
  url.set_hostname("example.com?stuff")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #21" {
  let url = Url::parse("http://example.net/path")
  url.set_hostname("example.com#stuff")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #22" {
  let url = Url::parse("http://example.net/path")
  url.set_hostname("example.com\\stuff")
  assert_eq(js_href(url), "http://example.com/path")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #23" {
  let url = Url::parse("view-source+http://example.net/path")
  url.set_hostname("example.com\\stuff")
  assert_eq(js_href(url), "view-source+http://example.net/path")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #24" {
  let url = Url::parse("http://example.net/")
  url.set_hostname("[google.com]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters hostname #25" {
  let url = Url::parse("http://example.net/")
  url.set_hostname("[::1.2.3.4x]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters hostname #26" {
  let url = Url::parse("http://example.net/")
  url.set_hostname("[::1.2.3.]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters hostname #27" {
  let url = Url::parse("http://example.net/")
  url.set_hostname("[::1.2.]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters hostname #28" {
  let url = Url::parse("http://example.net/")
  url.set_hostname("[::1.]")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
}

///|
test "WPT setters hostname #29" {
  let url = Url::parse("file://y/")
  url.set_hostname("x:123")
  assert_eq(js_href(url), "file://y/")
  assert_eq(js_host(url), "y")
  assert_eq(js_hostname(url), "y")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #30" {
  let url = Url::parse("file://y/")
  url.set_hostname("loc%41lhost")
  assert_eq(js_href(url), "file:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #31" {
  let url = Url::parse("file://hi/x")
  url.set_hostname("")
  assert_eq(js_href(url), "file:///x")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters hostname #32" {
  let url = Url::parse("sc://test@test/")
  url.set_hostname("")
  assert_eq(js_href(url), "sc://test@test/")
  assert_eq(url.username(), "test")
  assert_eq(js_host(url), "test")
  assert_eq(js_hostname(url), "test")
}

///|
test "WPT setters hostname #33" {
  let url = Url::parse("sc://test:12/")
  url.set_hostname("")
  assert_eq(js_href(url), "sc://test:12/")
  assert_eq(js_host(url), "test:12")
  assert_eq(js_hostname(url), "test")
  assert_eq(js_port(url), "12")
}

///|
test "WPT setters hostname #34" {
  let url = Url::parse("non-spec:/.//p")
  url.set_hostname("h")
  assert_eq(js_href(url), "non-spec://h//p")
  assert_eq(js_host(url), "h")
  assert_eq(js_hostname(url), "h")
  assert_eq(js_pathname(url), "//p")
}

///|
test "WPT setters hostname #35" {
  let url = Url::parse("non-spec:/.//p")
  url.set_hostname("")
  assert_eq(js_href(url), "non-spec:////p")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
  assert_eq(js_pathname(url), "//p")
}

///|
test "WPT setters hostname #36" {
  let url = Url::parse("http://example.com/")
  url.set_hostname("///bad.com")
  assert_eq(js_href(url), "http://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
}

///|
test "WPT setters hostname #37" {
  let url = Url::parse("sc://example.com/")
  url.set_hostname("///bad.com")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_host(url), "")
  assert_eq(js_hostname(url), "")
}

///|
test "WPT setters hostname #38" {
  let url = Url::parse("https://example.com/")
  url.set_hostname("a%C2%ADb")
  assert_eq(js_href(url), "https://ab/")
  assert_eq(js_host(url), "ab")
  assert_eq(js_hostname(url), "ab")
}

///|
test "WPT setters hostname #39" {
  let url = Url::parse("https://example.com/")
  url.set_hostname("\u{AD}")
  assert_eq(js_href(url), "https://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
}

///|
test "WPT setters hostname #40" {
  let url = Url::parse("https://example.com/")
  url.set_hostname("%C2%AD")
  assert_eq(js_href(url), "https://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
}

///|
test "WPT setters hostname #41" {
  let url = Url::parse("https://example.com/")
  url.set_hostname("xn--")
  assert_eq(js_href(url), "https://example.com/")
  assert_eq(js_host(url), "example.com")
  assert_eq(js_hostname(url), "example.com")
}

///|
test "WPT setters hostname #42" {
  let url = Url::parse("https://test.invalid/")
  url.set_hostname("*")
  assert_eq(js_href(url), "https://*/")
  assert_eq(js_host(url), "*")
  assert_eq(js_hostname(url), "*")
}

///|
test "WPT setters hostname #43" {
  let url = Url::parse("https://test.invalid/")
  url.set_hostname("x@x")
  assert_eq(js_href(url), "https://test.invalid/")
  assert_eq(js_host(url), "test.invalid")
  assert_eq(js_hostname(url), "test.invalid")
}

///|
test "WPT setters hostname #44" {
  let url = Url::parse("https://test.invalid/")
  url.set_hostname("foo\t\r\nbar")
  assert_eq(js_href(url), "https://foobar/")
  assert_eq(js_host(url), "foobar")
  assert_eq(js_hostname(url), "foobar")
}

///|
test "WPT setters hostname #45" {
  let url = Url::parse("https://test.invalid/")
  url.set_hostname("><")
  assert_eq(js_href(url), "https://test.invalid/")
  assert_eq(js_host(url), "test.invalid")
  assert_eq(js_hostname(url), "test.invalid")
}

///|
test "WPT setters hostname #46" {
  let url = Url::parse("https://test.invalid/")
  url.set_hostname("test/@aaa")
  assert_eq(js_href(url), "https://test/")
  assert_eq(js_host(url), "test")
  assert_eq(js_hostname(url), "test")
}

///|
test "WPT setters hostname #47" {
  let url = Url::parse("https://test.invalid/")
  url.set_hostname("test/:aaa")
  assert_eq(js_href(url), "https://test/")
  assert_eq(js_host(url), "test")
  assert_eq(js_hostname(url), "test")
}

///|
test "WPT setters port #0" {
  let url = Url::parse("http://example.net")
  url.set_port("8080")
  assert_eq(js_href(url), "http://example.net:8080/")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #1" {
  let url = Url::parse("http://example.net:8080")
  url.set_port("")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters port #2" {
  let url = Url::parse("http://example.net:8080")
  url.set_port("80")
  assert_eq(js_href(url), "http://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters port #3" {
  let url = Url::parse("https://example.net:4433")
  url.set_port("443")
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_host(url), "example.net")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters port #4" {
  let url = Url::parse("https://example.net")
  url.set_port("80")
  assert_eq(js_href(url), "https://example.net:80/")
  assert_eq(js_host(url), "example.net:80")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "80")
}

///|
test "WPT setters port #5" {
  let url = Url::parse("http://example.net/path")
  url.set_port("8080/stuff")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #6" {
  let url = Url::parse("http://example.net/path")
  url.set_port("8080?stuff")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #7" {
  let url = Url::parse("http://example.net/path")
  url.set_port("8080#stuff")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #8" {
  let url = Url::parse("http://example.net/path")
  url.set_port("8080\\stuff")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #9" {
  let url = Url::parse("view-source+http://example.net/path")
  url.set_port("8080stuff2")
  assert_eq(js_href(url), "view-source+http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #10" {
  let url = Url::parse("http://example.net/path")
  url.set_port("8080stuff2")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #11" {
  let url = Url::parse("http://example.net/path")
  url.set_port("8080+2")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #12" {
  let url = Url::parse("http://example.net/path")
  url.set_port("65535")
  assert_eq(js_href(url), "http://example.net:65535/path")
  assert_eq(js_host(url), "example.net:65535")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "65535")
}

///|
test "WPT setters port #13" {
  let url = Url::parse("http://example.net:8080/path")
  url.set_port("65536")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #14" {
  let url = Url::parse("http://example.net:8080/path")
  url.set_port("randomstring")
  assert_eq(js_href(url), "http://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #15" {
  let url = Url::parse("non-special://example.net:8080/path")
  url.set_port("65536")
  assert_eq(js_href(url), "non-special://example.net:8080/path")
  assert_eq(js_host(url), "example.net:8080")
  assert_eq(js_hostname(url), "example.net")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #16" {
  let url = Url::parse("file://test/")
  url.set_port("12")
  assert_eq(js_href(url), "file://test/")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters port #17" {
  let url = Url::parse("file://localhost/")
  url.set_port("12")
  assert_eq(js_href(url), "file:///")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters port #18" {
  let url = Url::parse("non-base:value")
  url.set_port("12")
  assert_eq(js_href(url), "non-base:value")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters port #19" {
  let url = Url::parse("sc:///")
  url.set_port("12")
  assert_eq(js_href(url), "sc:///")
  assert_eq(js_port(url), "")
}

///|
test "WPT setters port #20" {
  let url = Url::parse("sc://x/")
  url.set_port("12")
  assert_eq(js_href(url), "sc://x:12/")
  assert_eq(js_port(url), "12")
}

///|
test "WPT setters port #21" {
  let url = Url::parse("javascript://x/")
  url.set_port("12")
  assert_eq(js_href(url), "javascript://x:12/")
  assert_eq(js_port(url), "12")
}

///|
test "WPT setters port #22" {
  let url = Url::parse("https://domain.com:443")
  url.set_port("\t8080")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #23" {
  let url = Url::parse("wpt++://domain.com:443")
  url.set_port("\t8080")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #24" {
  let url = Url::parse("https://www.google.com:4343")
  url.set_port("4wpt")
  assert_eq(js_port(url), "4")
}

///|
test "WPT setters port #25" {
  let url = Url::parse("https://domain.com:3000")
  url.set_port("\n\t80\n\t80\n\t")
  assert_eq(js_port(url), "8080")
}

///|
test "WPT setters port #26" {
  let url = Url::parse("https://domain.com:3000")
  url.set_port("\n\n\t\t")
  assert_eq(js_port(url), "3000")
}

///|
test "WPT setters pathname #0" {
  let url = Url::parse("mailto:me@example.net")
  url.set_pathname("/foo")
  assert_eq(js_href(url), "mailto:me@example.net")
  assert_eq(js_pathname(url), "me@example.net")
}

///|
test "WPT setters pathname #1" {
  let url = Url::parse("data:original")
  url.set_pathname("new value")
  assert_eq(js_href(url), "data:original")
  assert_eq(js_pathname(url), "original")
}

///|
test "WPT setters pathname #2" {
  let url = Url::parse("sc:original")
  url.set_pathname("new value")
  assert_eq(js_href(url), "sc:original")
  assert_eq(js_pathname(url), "original")
}

///|
test "WPT setters pathname #3" {
  let url = Url::parse("file:///some/path")
  url.set_pathname("")
  assert_eq(js_href(url), "file:///")
  assert_eq(js_pathname(url), "/")
}

///|
test "WPT setters pathname #4" {
  let url = Url::parse("foo://somehost/some/path")
  url.set_pathname("")
  assert_eq(js_href(url), "foo://somehost")
  assert_eq(js_pathname(url), "")
}

///|
test "WPT setters pathname #5" {
  let url = Url::parse("foo:///some/path")
  url.set_pathname("")
  assert_eq(js_href(url), "foo://")
  assert_eq(js_pathname(url), "")
}

///|
test "WPT setters pathname #6" {
  let url = Url::parse("foo:/some/path")
  url.set_pathname("")
  assert_eq(js_href(url), "foo:/")
  assert_eq(js_pathname(url), "/")
}

///|
test "WPT setters pathname #7" {
  let url = Url::parse("foo:/some/path")
  url.set_pathname("test")
  assert_eq(js_href(url), "foo:/test")
  assert_eq(js_pathname(url), "/test")
}

///|
test "WPT setters pathname #8" {
  let url = Url::parse("unix:/run/foo.socket?timeout=10")
  url.set_pathname("/var/log/../run/bar.socket")
  assert_eq(js_href(url), "unix:/var/run/bar.socket?timeout=10")
  assert_eq(js_pathname(url), "/var/run/bar.socket")
}

///|
test "WPT setters pathname #9" {
  let url = Url::parse("https://example.net#nav")
  url.set_pathname("home")
  assert_eq(js_href(url), "https://example.net/home#nav")
  assert_eq(js_pathname(url), "/home")
}

///|
test "WPT setters pathname #10" {
  let url = Url::parse("https://example.net#nav")
  url.set_pathname("../home")
  assert_eq(js_href(url), "https://example.net/home#nav")
  assert_eq(js_pathname(url), "/home")
}

///|
test "WPT setters pathname #11" {
  let url = Url::parse("http://example.net/home?lang=fr#nav")
  url.set_pathname("\\a\\%2E\\b\\%2e.\\c")
  assert_eq(js_href(url), "http://example.net/a/c?lang=fr#nav")
  assert_eq(js_pathname(url), "/a/c")
}

///|
test "WPT setters pathname #12" {
  let url = Url::parse("view-source+http://example.net/home?lang=fr#nav")
  url.set_pathname("\\a\\%2E\\b\\%2e.\\c")
  assert_eq(
    js_href(url),
    "view-source+http://example.net/\\a\\%2E\\b\\%2e.\\c?lang=fr#nav",
  )
  assert_eq(js_pathname(url), "/\\a\\%2E\\b\\%2e.\\c")
}

///|
test "WPT setters pathname #13" {
  let url = Url::parse("a:/")
  url.set_pathname(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  )
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
  let url = Url::parse("http://example.net")
  url.set_pathname("%2e%2E%c3%89t\u{E9}")
  assert_eq(js_href(url), "http://example.net/%2e%2E%c3%89t%C3%A9")
  assert_eq(js_pathname(url), "/%2e%2E%c3%89t%C3%A9")
}

///|
test "WPT setters pathname #15" {
  let url = Url::parse("http://example.net")
  url.set_pathname("?")
  assert_eq(js_href(url), "http://example.net/%3F")
  assert_eq(js_pathname(url), "/%3F")
}

///|
test "WPT setters pathname #16" {
  let url = Url::parse("http://example.net")
  url.set_pathname("#")
  assert_eq(js_href(url), "http://example.net/%23")
  assert_eq(js_pathname(url), "/%23")
}

///|
test "WPT setters pathname #17" {
  let url = Url::parse("sc://example.net")
  url.set_pathname("?")
  assert_eq(js_href(url), "sc://example.net/%3F")
  assert_eq(js_pathname(url), "/%3F")
}

///|
test "WPT setters pathname #18" {
  let url = Url::parse("sc://example.net")
  url.set_pathname("#")
  assert_eq(js_href(url), "sc://example.net/%23")
  assert_eq(js_pathname(url), "/%23")
}

///|
test "WPT setters pathname #19" {
  let url = Url::parse("http://example.net")
  url.set_pathname("/?\u{E9}")
  assert_eq(js_href(url), "http://example.net/%3F%C3%A9")
  assert_eq(js_pathname(url), "/%3F%C3%A9")
}

///|
test "WPT setters pathname #20" {
  let url = Url::parse("http://example.net")
  url.set_pathname("/#\u{E9}")
  assert_eq(js_href(url), "http://example.net/%23%C3%A9")
  assert_eq(js_pathname(url), "/%23%C3%A9")
}

///|
test "WPT setters pathname #21" {
  let url = Url::parse("file://monkey/")
  url.set_pathname("\\\\")
  assert_eq(js_href(url), "file://monkey//")
  assert_eq(js_pathname(url), "//")
}

///|
test "WPT setters pathname #22" {
  let url = Url::parse("file:///unicorn")
  url.set_pathname("//\\/")
  assert_eq(js_href(url), "file://////")
  assert_eq(js_pathname(url), "////")
}

///|
test "WPT setters pathname #23" {
  let url = Url::parse("file:///unicorn")
  url.set_pathname("//monkey/..//")
  assert_eq(js_href(url), "file://///")
  assert_eq(js_pathname(url), "///")
}

///|
test "WPT setters pathname #24" {
  let url = Url::parse("non-spec:/")
  url.set_pathname("/.//p")
  assert_eq(js_href(url), "non-spec:/.//p")
  assert_eq(js_pathname(url), "//p")
}

///|
test "WPT setters pathname #25" {
  let url = Url::parse("non-spec:/")
  url.set_pathname("/..//p")
  assert_eq(js_href(url), "non-spec:/.//p")
  assert_eq(js_pathname(url), "//p")
}

///|
test "WPT setters pathname #26" {
  let url = Url::parse("non-spec:/")
  url.set_pathname("//p")
  assert_eq(js_href(url), "non-spec:/.//p")
  assert_eq(js_pathname(url), "//p")
}

///|
test "WPT setters pathname #27" {
  let url = Url::parse("non-spec:/.//")
  url.set_pathname("p")
  assert_eq(js_href(url), "non-spec:/p")
  assert_eq(js_pathname(url), "/p")
}

///|
test "WPT setters pathname #28" {
  let url = Url::parse("data:/nospace")
  url.set_pathname("space ")
  assert_eq(js_href(url), "data:/space%20")
  assert_eq(js_pathname(url), "/space%20")
}

///|
test "WPT setters pathname #29" {
  let url = Url::parse("sc:/nospace")
  url.set_pathname("space ")
  assert_eq(js_href(url), "sc:/space%20")
  assert_eq(js_pathname(url), "/space%20")
}

///|
test "WPT setters pathname #30" {
  let url = Url::parse("http://example.net")
  url.set_pathname(" ")
  assert_eq(js_href(url), "http://example.net/%20")
  assert_eq(js_pathname(url), "/%20")
}

///|
test "WPT setters pathname #31" {
  let url = Url::parse("http://example.net")
  url.set_pathname("\u{0}")
  assert_eq(js_href(url), "http://example.net/%00")
  assert_eq(js_pathname(url), "/%00")
}

///|
test "WPT setters pathname #32" {
  let url = Url::parse("foo://path/to")
  url.set_pathname("/..")
  assert_eq(js_href(url), "foo://path/")
  assert_eq(js_pathname(url), "/")
}

///|
test "WPT setters search #0" {
  let url = Url::parse("https://example.net#nav")
  url.set_search("lang=fr")
  assert_eq(js_href(url), "https://example.net/?lang=fr#nav")
  assert_eq(js_search(url), "?lang=fr")
}

///|
test "WPT setters search #1" {
  let url = Url::parse("https://example.net?lang=en-US#nav")
  url.set_search("lang=fr")
  assert_eq(js_href(url), "https://example.net/?lang=fr#nav")
  assert_eq(js_search(url), "?lang=fr")
}

///|
test "WPT setters search #2" {
  let url = Url::parse("https://example.net?lang=en-US#nav")
  url.set_search("?lang=fr")
  assert_eq(js_href(url), "https://example.net/?lang=fr#nav")
  assert_eq(js_search(url), "?lang=fr")
}

///|
test "WPT setters search #3" {
  let url = Url::parse("https://example.net?lang=en-US#nav")
  url.set_search("??lang=fr")
  assert_eq(js_href(url), "https://example.net/??lang=fr#nav")
  assert_eq(js_search(url), "??lang=fr")
}

///|
test "WPT setters search #4" {
  let url = Url::parse("https://example.net?lang=en-US#nav")
  url.set_search("?")
  assert_eq(js_href(url), "https://example.net/?#nav")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #5" {
  let url = Url::parse("https://example.net?lang=en-US#nav")
  url.set_search("")
  assert_eq(js_href(url), "https://example.net/#nav")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #6" {
  let url = Url::parse("https://example.net?lang=en-US")
  url.set_search("")
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #7" {
  let url = Url::parse("https://example.net")
  url.set_search("")
  assert_eq(js_href(url), "https://example.net/")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #8" {
  let url = Url::parse("a:/")
  url.set_search(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
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
  let url = Url::parse("http://example.net")
  url.set_search("%c3%89t\u{E9}")
  assert_eq(js_href(url), "http://example.net/?%c3%89t%C3%A9")
  assert_eq(js_search(url), "?%c3%89t%C3%A9")
}

///|
test "WPT setters search #10" {
  let url = Url::parse("data:space ?query")
  url.set_search("")
  assert_eq(js_href(url), "data:space%20")
  assert_eq(js_pathname(url), "space%20")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #11" {
  let url = Url::parse("sc:space ?query")
  url.set_search("")
  assert_eq(js_href(url), "sc:space%20")
  assert_eq(js_pathname(url), "space%20")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #12" {
  let url = Url::parse("data:space  ?query#fragment")
  url.set_search("")
  assert_eq(js_href(url), "data:space %20#fragment")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #13" {
  let url = Url::parse("sc:space  ?query#fragment")
  url.set_search("")
  assert_eq(js_href(url), "sc:space %20#fragment")
  assert_eq(js_search(url), "")
}

///|
test "WPT setters search #14" {
  let url = Url::parse("http://example.net")
  url.set_search(" ")
  assert_eq(js_href(url), "http://example.net/?%20")
  assert_eq(js_search(url), "?%20")
}

///|
test "WPT setters search #15" {
  let url = Url::parse("http://example.net")
  url.set_search("\u{0}")
  assert_eq(js_href(url), "http://example.net/?%00")
  assert_eq(js_search(url), "?%00")
}

///|
test "WPT setters hash #0" {
  let url = Url::parse("https://example.net")
  url.set_hash("main")
  assert_eq(js_href(url), "https://example.net/#main")
  assert_eq(js_hash(url), "#main")
}

///|
test "WPT setters hash #1" {
  let url = Url::parse("https://example.net#nav")
  url.set_hash("main")
  assert_eq(js_href(url), "https://example.net/#main")
  assert_eq(js_hash(url), "#main")
}

///|
test "WPT setters hash #2" {
  let url = Url::parse("https://example.net?lang=en-US")
  url.set_hash("##nav")
  assert_eq(js_href(url), "https://example.net/?lang=en-US##nav")
  assert_eq(js_hash(url), "##nav")
}

///|
test "WPT setters hash #3" {
  let url = Url::parse("https://example.net?lang=en-US#nav")
  url.set_hash("#main")
  assert_eq(js_href(url), "https://example.net/?lang=en-US#main")
  assert_eq(js_hash(url), "#main")
}

///|
test "WPT setters hash #4" {
  let url = Url::parse("https://example.net?lang=en-US#nav")
  url.set_hash("#")
  assert_eq(js_href(url), "https://example.net/?lang=en-US#")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #5" {
  let url = Url::parse("https://example.net?lang=en-US#nav")
  url.set_hash("")
  assert_eq(js_href(url), "https://example.net/?lang=en-US")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #6" {
  let url = Url::parse("http://example.net")
  url.set_hash("#foo bar")
  assert_eq(js_href(url), "http://example.net/#foo%20bar")
  assert_eq(js_hash(url), "#foo%20bar")
}

///|
test "WPT setters hash #7" {
  let url = Url::parse("http://example.net")
  url.set_hash("#foo\"bar")
  assert_eq(js_href(url), "http://example.net/#foo%22bar")
  assert_eq(js_hash(url), "#foo%22bar")
}

///|
test "WPT setters hash #8" {
  let url = Url::parse("http://example.net")
  url.set_hash("#foo<bar")
  assert_eq(js_href(url), "http://example.net/#foo%3Cbar")
  assert_eq(js_hash(url), "#foo%3Cbar")
}

///|
test "WPT setters hash #9" {
  let url = Url::parse("http://example.net")
  url.set_hash("#foo>bar")
  assert_eq(js_href(url), "http://example.net/#foo%3Ebar")
  assert_eq(js_hash(url), "#foo%3Ebar")
}

///|
test "WPT setters hash #10" {
  let url = Url::parse("http://example.net")
  url.set_hash("#foo`bar")
  assert_eq(js_href(url), "http://example.net/#foo%60bar")
  assert_eq(js_hash(url), "#foo%60bar")
}

///|
test "WPT setters hash #11" {
  let url = Url::parse("a:/")
  url.set_hash(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
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
  let url = Url::parse("http://example.net")
  url.set_hash("a\u{0}b")
  assert_eq(js_href(url), "http://example.net/#a%00b")
  assert_eq(js_hash(url), "#a%00b")
}

///|
test "WPT setters hash #13" {
  let url = Url::parse("non-spec:/")
  url.set_hash("a\u{0}b")
  assert_eq(js_href(url), "non-spec:/#a%00b")
  assert_eq(js_hash(url), "#a%00b")
}

///|
test "WPT setters hash #14" {
  let url = Url::parse("http://example.net")
  url.set_hash("%c3%89t\u{E9}")
  assert_eq(js_href(url), "http://example.net/#%c3%89t%C3%A9")
  assert_eq(js_hash(url), "#%c3%89t%C3%A9")
}

///|
test "WPT setters hash #15" {
  let url = Url::parse("javascript:alert(1)")
  url.set_hash("castle")
  assert_eq(js_href(url), "javascript:alert(1)#castle")
  assert_eq(js_hash(url), "#castle")
}

///|
test "WPT setters hash #16" {
  let url = Url::parse(
    "data:space                                                                                                                                  #fragment",
  )
  url.set_hash("")
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
  let url = Url::parse("sc:space    #fragment")
  url.set_hash("")
  assert_eq(js_href(url), "sc:space   %20")
  assert_eq(js_pathname(url), "space   %20")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #18" {
  let url = Url::parse("data:space  ?query#fragment")
  url.set_hash("")
  assert_eq(js_href(url), "data:space %20?query")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #19" {
  let url = Url::parse("sc:space  ?query#fragment")
  url.set_hash("")
  assert_eq(js_href(url), "sc:space %20?query")
  assert_eq(js_hash(url), "")
}

///|
test "WPT setters hash #20" {
  let url = Url::parse("http://example.net")
  url.set_hash(" ")
  assert_eq(js_href(url), "http://example.net/#%20")
  assert_eq(js_hash(url), "#%20")
}

///|
test "WPT setters hash #21" {
  let url = Url::parse("http://example.net")
  url.set_hash("\u{0}")
  assert_eq(js_href(url), "http://example.net/#%00")
  assert_eq(js_hash(url), "#%00")
}
