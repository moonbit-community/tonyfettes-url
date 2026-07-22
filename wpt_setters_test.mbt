// Auto-generated from WPT setters_tests.json
// https://github.com/web-platform-tests/wpt/blob/master/url/resources/setters_tests.json
// Do not edit manually
//
// To regenerate: python3 scripts/generate_wpt_setters_tests.py > wpt_setters_test.mbt

///|
test "WPT setters href #0" {
  let url = @url.Url::parse("http://0300.168.0xF0")
  assert_eq(url.href(), "http://192.168.0.240/")
  assert_eq(url.protocol(), "http:")
}

///|
test "WPT setters protocol #0" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("") catch { _ => url }
  assert_eq(url.href(), "a://example.net")
  assert_eq(url.protocol(), "a:")
}

///|
test "WPT setters protocol #1" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("b") catch { _ => url }
  assert_eq(url.href(), "b://example.net")
  assert_eq(url.protocol(), "b:")
}

///|
test "WPT setters protocol #2" {
  let url = @url.Url::parse("javascript:alert(1)")
  let url = url.with_protocol("defuse") catch { _ => url }
  assert_eq(url.href(), "defuse:alert(1)")
  assert_eq(url.protocol(), "defuse:")
}

///|
test "WPT setters protocol #3" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("B") catch { _ => url }
  assert_eq(url.href(), "b://example.net")
  assert_eq(url.protocol(), "b:")
}

///|
test "WPT setters protocol #4" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("\u{E9}") catch { _ => url }
  assert_eq(url.href(), "a://example.net")
  assert_eq(url.protocol(), "a:")
}

///|
test "WPT setters protocol #5" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("0b") catch { _ => url }
  assert_eq(url.href(), "a://example.net")
  assert_eq(url.protocol(), "a:")
}

///|
test "WPT setters protocol #6" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("+b") catch { _ => url }
  assert_eq(url.href(), "a://example.net")
  assert_eq(url.protocol(), "a:")
}

///|
test "WPT setters protocol #7" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("bC0+-.") catch { _ => url }
  assert_eq(url.href(), "bc0+-.://example.net")
  assert_eq(url.protocol(), "bc0+-.:")
}

///|
test "WPT setters protocol #8" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("b,c") catch { _ => url }
  assert_eq(url.href(), "a://example.net")
  assert_eq(url.protocol(), "a:")
}

///|
test "WPT setters protocol #9" {
  let url = @url.Url::parse("a://example.net")
  let url = url.with_protocol("b\u{E9}") catch { _ => url }
  assert_eq(url.href(), "a://example.net")
  assert_eq(url.protocol(), "a:")
}

///|
test "WPT setters protocol #10" {
  let url = @url.Url::parse("http://test@example.net")
  let url = url.with_protocol("file") catch { _ => url }
  assert_eq(url.href(), "http://test@example.net/")
  assert_eq(url.protocol(), "http:")
}

///|
test "WPT setters protocol #11" {
  let url = @url.Url::parse("https://example.net:1234")
  let url = url.with_protocol("file") catch { _ => url }
  assert_eq(url.href(), "https://example.net:1234/")
  assert_eq(url.protocol(), "https:")
}

///|
test "WPT setters protocol #12" {
  let url = @url.Url::parse("wss://x:x@example.net:1234")
  let url = url.with_protocol("file") catch { _ => url }
  assert_eq(url.href(), "wss://x:x@example.net:1234/")
  assert_eq(url.protocol(), "wss:")
}

///|
test "WPT setters protocol #13" {
  let url = @url.Url::parse("file://localhost/")
  let url = url.with_protocol("http") catch { _ => url }
  assert_eq(url.href(), "file:///")
  assert_eq(url.protocol(), "file:")
}

///|
test "WPT setters protocol #14" {
  let url = @url.Url::parse("file:///test")
  let url = url.with_protocol("https") catch { _ => url }
  assert_eq(url.href(), "file:///test")
  assert_eq(url.protocol(), "file:")
}

///|
test "WPT setters protocol #15" {
  let url = @url.Url::parse("file:")
  let url = url.with_protocol("wss") catch { _ => url }
  assert_eq(url.href(), "file:///")
  assert_eq(url.protocol(), "file:")
}

///|
test "WPT setters protocol #16" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_protocol("b") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.protocol(), "http:")
}

///|
test "WPT setters protocol #17" {
  let url = @url.Url::parse("file://hi/path")
  let url = url.with_protocol("s") catch { _ => url }
  assert_eq(url.href(), "file://hi/path")
  assert_eq(url.protocol(), "file:")
}

///|
test "WPT setters protocol #18" {
  let url = @url.Url::parse("https://example.net")
  let url = url.with_protocol("s") catch { _ => url }
  assert_eq(url.href(), "https://example.net/")
  assert_eq(url.protocol(), "https:")
}

///|
test "WPT setters protocol #19" {
  let url = @url.Url::parse("ftp://example.net")
  let url = url.with_protocol("test") catch { _ => url }
  assert_eq(url.href(), "ftp://example.net/")
  assert_eq(url.protocol(), "ftp:")
}

///|
test "WPT setters protocol #20" {
  let url = @url.Url::parse("mailto:me@example.net")
  let url = url.with_protocol("http") catch { _ => url }
  assert_eq(url.href(), "mailto:me@example.net")
  assert_eq(url.protocol(), "mailto:")
}

///|
test "WPT setters protocol #21" {
  let url = @url.Url::parse("ssh://me@example.net")
  let url = url.with_protocol("http") catch { _ => url }
  assert_eq(url.href(), "ssh://me@example.net")
  assert_eq(url.protocol(), "ssh:")
}

///|
test "WPT setters protocol #22" {
  let url = @url.Url::parse("ssh://me@example.net")
  let url = url.with_protocol("https") catch { _ => url }
  assert_eq(url.href(), "ssh://me@example.net")
  assert_eq(url.protocol(), "ssh:")
}

///|
test "WPT setters protocol #23" {
  let url = @url.Url::parse("ssh://me@example.net")
  let url = url.with_protocol("file") catch { _ => url }
  assert_eq(url.href(), "ssh://me@example.net")
  assert_eq(url.protocol(), "ssh:")
}

///|
test "WPT setters protocol #24" {
  let url = @url.Url::parse("ssh://example.net")
  let url = url.with_protocol("file") catch { _ => url }
  assert_eq(url.href(), "ssh://example.net")
  assert_eq(url.protocol(), "ssh:")
}

///|
test "WPT setters protocol #25" {
  let url = @url.Url::parse("nonsense:///test")
  let url = url.with_protocol("https") catch { _ => url }
  assert_eq(url.href(), "nonsense:///test")
  assert_eq(url.protocol(), "nonsense:")
}

///|
test "WPT setters protocol #26" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_protocol("https:foo : bar") catch { _ => url }
  assert_eq(url.href(), "https://example.net/")
  assert_eq(url.protocol(), "https:")
}

///|
test "WPT setters protocol #27" {
  let url = @url.Url::parse("data:text/html,<p>Test")
  let url = url.with_protocol("view-source+data:foo : bar") catch { _ => url }
  assert_eq(url.href(), "view-source+data:text/html,<p>Test")
  assert_eq(url.protocol(), "view-source+data:")
}

///|
test "WPT setters protocol #28" {
  let url = @url.Url::parse("http://foo.com:443/")
  let url = url.with_protocol("https") catch { _ => url }
  assert_eq(url.href(), "https://foo.com/")
  assert_eq(url.protocol(), "https:")
  assert_eq(url.port(), "")
}

///|
test "WPT setters protocol #29" {
  let url = @url.Url::parse("http://test/")
  let url = url.with_protocol("h\r\ntt\tps") catch { _ => url }
  assert_eq(url.href(), "https://test/")
  assert_eq(url.protocol(), "https:")
  assert_eq(url.port(), "")
}

///|
test "WPT setters protocol #30" {
  let url = @url.Url::parse("http://test/")
  let url = url.with_protocol("https\r") catch { _ => url }
  assert_eq(url.href(), "https://test/")
  assert_eq(url.protocol(), "https:")
}

///|
test "WPT setters protocol #31" {
  let url = @url.Url::parse("http://test/")
  let url = url.with_protocol("https\u{0}") catch { _ => url }
  assert_eq(url.href(), "http://test/")
  assert_eq(url.protocol(), "http:")
}

///|
test "WPT setters protocol #32" {
  let url = @url.Url::parse("http://test/")
  let url = url.with_protocol("https\u{C}") catch { _ => url }
  assert_eq(url.href(), "http://test/")
  assert_eq(url.protocol(), "http:")
}

///|
test "WPT setters protocol #33" {
  let url = @url.Url::parse("http://test/")
  let url = url.with_protocol("https\u{E}") catch { _ => url }
  assert_eq(url.href(), "http://test/")
  assert_eq(url.protocol(), "http:")
}

///|
test "WPT setters protocol #34" {
  let url = @url.Url::parse("http://test/")
  let url = url.with_protocol("https ") catch { _ => url }
  assert_eq(url.href(), "http://test/")
  assert_eq(url.protocol(), "http:")
}

///|
test "WPT setters username #0" {
  let url = @url.Url::parse("file:///home/you/index.html")
  let url = url.with_username("me") catch { _ => url }
  assert_eq(url.href(), "file:///home/you/index.html")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #1" {
  let url = @url.Url::parse("unix:/run/foo.socket")
  let url = url.with_username("me") catch { _ => url }
  assert_eq(url.href(), "unix:/run/foo.socket")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #2" {
  let url = @url.Url::parse("mailto:you@example.net")
  let url = url.with_username("me") catch { _ => url }
  assert_eq(url.href(), "mailto:you@example.net")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #3" {
  let url = @url.Url::parse("javascript:alert(1)")
  let url = url.with_username("wario") catch { _ => url }
  assert_eq(url.href(), "javascript:alert(1)")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #4" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_username("me") catch { _ => url }
  assert_eq(url.href(), "http://me@example.net/")
  assert_eq(url.username(), "me")
}

///|
test "WPT setters username #5" {
  let url = @url.Url::parse("http://:secret@example.net")
  let url = url.with_username("me") catch { _ => url }
  assert_eq(url.href(), "http://me:secret@example.net/")
  assert_eq(url.username(), "me")
}

///|
test "WPT setters username #6" {
  let url = @url.Url::parse("http://me@example.net")
  let url = url.with_username("") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #7" {
  let url = @url.Url::parse("http://me:secret@example.net")
  let url = url.with_username("") catch { _ => url }
  assert_eq(url.href(), "http://:secret@example.net/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #8" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_username(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  ) catch {
    _ => url
  }
  assert_eq(
    url.href(),
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
  let url = url.with_username("%c3%89t\u{E9}") catch { _ => url }
  assert_eq(url.href(), "http://%c3%89t%C3%A9@example.net/")
  assert_eq(url.username(), "%c3%89t%C3%A9")
}

///|
test "WPT setters username #10" {
  let url = @url.Url::parse("sc:///")
  let url = url.with_username("x") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.username(), "")
}

///|
test "WPT setters username #11" {
  let url = @url.Url::parse("javascript://x/")
  let url = url.with_username("wario") catch { _ => url }
  assert_eq(url.href(), "javascript://wario@x/")
  assert_eq(url.username(), "wario")
}

///|
test "WPT setters username #12" {
  let url = @url.Url::parse("file://test/")
  let url = url.with_username("test") catch { _ => url }
  assert_eq(url.href(), "file://test/")
  assert_eq(url.username(), "")
}

///|
test "WPT setters password #0" {
  let url = @url.Url::parse("file:///home/me/index.html")
  let url = url.with_password("secret") catch { _ => url }
  assert_eq(url.href(), "file:///home/me/index.html")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #1" {
  let url = @url.Url::parse("unix:/run/foo.socket")
  let url = url.with_password("secret") catch { _ => url }
  assert_eq(url.href(), "unix:/run/foo.socket")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #2" {
  let url = @url.Url::parse("mailto:me@example.net")
  let url = url.with_password("secret") catch { _ => url }
  assert_eq(url.href(), "mailto:me@example.net")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #3" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_password("secret") catch { _ => url }
  assert_eq(url.href(), "http://:secret@example.net/")
  assert_eq(url.password(), "secret")
}

///|
test "WPT setters password #4" {
  let url = @url.Url::parse("http://me@example.net")
  let url = url.with_password("secret") catch { _ => url }
  assert_eq(url.href(), "http://me:secret@example.net/")
  assert_eq(url.password(), "secret")
}

///|
test "WPT setters password #5" {
  let url = @url.Url::parse("http://:secret@example.net")
  let url = url.with_password("") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #6" {
  let url = @url.Url::parse("http://me:secret@example.net")
  let url = url.with_password("") catch { _ => url }
  assert_eq(url.href(), "http://me@example.net/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #7" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_password(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  ) catch {
    _ => url
  }
  assert_eq(
    url.href(),
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
  let url = url.with_password("%c3%89t\u{E9}") catch { _ => url }
  assert_eq(url.href(), "http://:%c3%89t%C3%A9@example.net/")
  assert_eq(url.password(), "%c3%89t%C3%A9")
}

///|
test "WPT setters password #9" {
  let url = @url.Url::parse("sc:///")
  let url = url.with_password("x") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.password(), "")
}

///|
test "WPT setters password #10" {
  let url = @url.Url::parse("javascript://x/")
  let url = url.with_password("bowser") catch { _ => url }
  assert_eq(url.href(), "javascript://:bowser@x/")
  assert_eq(url.password(), "bowser")
}

///|
test "WPT setters password #11" {
  let url = @url.Url::parse("file://test/")
  let url = url.with_password("test") catch { _ => url }
  assert_eq(url.href(), "file://test/")
  assert_eq(url.password(), "")
}

///|
test "WPT setters host #0" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("\u{0}") catch { _ => url }
  assert_eq(url.href(), "sc://x/")
  assert_eq(url.host(), "x")
  assert_eq(url.hostname(), "x")
}

///|
test "WPT setters host #1" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("\t") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters host #2" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("\n") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters host #3" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("\r") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters host #4" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host(" ") catch { _ => url }
  assert_eq(url.href(), "sc://x/")
  assert_eq(url.host(), "x")
  assert_eq(url.hostname(), "x")
}

///|
test "WPT setters host #5" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("#") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters host #6" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("/") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters host #7" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("?") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters host #8" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("@") catch { _ => url }
  assert_eq(url.href(), "sc://x/")
  assert_eq(url.host(), "x")
  assert_eq(url.hostname(), "x")
}

///|
test "WPT setters host #9" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_host("\u{DF}") catch { _ => url }
  assert_eq(url.href(), "sc://%C3%9F/")
  assert_eq(url.host(), "%C3%9F")
  assert_eq(url.hostname(), "%C3%9F")
}

///|
test "WPT setters host #10" {
  let url = @url.Url::parse("https://x/")
  let url = url.with_host("\u{DF}") catch { _ => url }
  assert_eq(url.href(), "https://xn--zca/")
  assert_eq(url.host(), "xn--zca")
  assert_eq(url.hostname(), "xn--zca")
}

///|
test "WPT setters host #11" {
  let url = @url.Url::parse("mailto:me@example.net")
  let url = url.with_host("example.com") catch { _ => url }
  assert_eq(url.href(), "mailto:me@example.net")
  assert_eq(url.host(), "")
}

///|
test "WPT setters host #12" {
  let url = @url.Url::parse("data:text/plain,Stuff")
  let url = url.with_host("example.net") catch { _ => url }
  assert_eq(url.href(), "data:text/plain,Stuff")
  assert_eq(url.host(), "")
}

///|
test "WPT setters host #13" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_host("example.com:8080") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #14" {
  let url = @url.Url::parse("http://example.net:8080")
  let url = url.with_host("example.com") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #15" {
  let url = @url.Url::parse("http://example.net:8080")
  let url = url.with_host("example.com:") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #16" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_host("") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
}

///|
test "WPT setters host #17" {
  let url = @url.Url::parse("view-source+http://example.net/foo")
  let url = url.with_host("") catch { _ => url }
  assert_eq(url.href(), "view-source+http:///foo")
  assert_eq(url.host(), "")
}

///|
test "WPT setters host #18" {
  let url = @url.Url::parse("a:/foo")
  let url = url.with_host("example.net") catch { _ => url }
  assert_eq(url.href(), "a://example.net/foo")
  assert_eq(url.host(), "example.net")
}

///|
test "WPT setters host #19" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_host("0x7F000001:8080") catch { _ => url }
  assert_eq(url.href(), "http://127.0.0.1:8080/")
  assert_eq(url.host(), "127.0.0.1:8080")
  assert_eq(url.hostname(), "127.0.0.1")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #20" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_host("[::0:01]:2") catch { _ => url }
  assert_eq(url.href(), "http://[::1]:2/")
  assert_eq(url.host(), "[::1]:2")
  assert_eq(url.hostname(), "[::1]")
  assert_eq(url.port(), "2")
}

///|
test "WPT setters host #21" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_host("[2001:db8::2]:4002") catch { _ => url }
  assert_eq(url.href(), "http://[2001:db8::2]:4002/")
  assert_eq(url.host(), "[2001:db8::2]:4002")
  assert_eq(url.hostname(), "[2001:db8::2]")
  assert_eq(url.port(), "4002")
}

///|
test "WPT setters host #22" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_host("example.com:80") catch { _ => url }
  assert_eq(url.href(), "http://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #23" {
  let url = @url.Url::parse("https://example.net")
  let url = url.with_host("example.com:443") catch { _ => url }
  assert_eq(url.href(), "https://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #24" {
  let url = @url.Url::parse("https://example.net")
  let url = url.with_host("example.com:80") catch { _ => url }
  assert_eq(url.href(), "https://example.com:80/")
  assert_eq(url.host(), "example.com:80")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "80")
}

///|
test "WPT setters host #25" {
  let url = @url.Url::parse("http://example.net:8080")
  let url = url.with_host("example.com:80") catch { _ => url }
  assert_eq(url.href(), "http://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #26" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com/stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #27" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com:8080/stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/path")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #28" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com?stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #29" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com?stuff:8080") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #30" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com:8080?stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/path")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #31" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com#stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #32" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com:8080#stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/path")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #33" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com\\stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #34" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com:8080\\stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/path")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #35" {
  let url = @url.Url::parse("view-source+http://example.net/path")
  let url = url.with_host("example.com\\stuff") catch { _ => url }
  assert_eq(url.href(), "view-source+http://example.net/path")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #36" {
  let url = @url.Url::parse("view-source+http://example.net/path")
  let url = url.with_host("example.com:8080stuff2") catch { _ => url }
  assert_eq(url.href(), "view-source+http://example.com:8080/path")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #37" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com:8080stuff2") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/path")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #38" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com:8080+2") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/path")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #39" {
  let url = @url.Url::parse("http://example.net:8080")
  let url = url.with_host("example.com:invalid") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #40" {
  let url = @url.Url::parse("http://example.net:8080/test")
  let url = url.with_host("[::1]:invalid") catch { _ => url }
  assert_eq(url.href(), "http://[::1]:8080/test")
  assert_eq(url.host(), "[::1]:8080")
  assert_eq(url.hostname(), "[::1]")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #41" {
  let url = @url.Url::parse("http://example.net:8080/test")
  let url = url.with_host("[::1]") catch { _ => url }
  assert_eq(url.href(), "http://[::1]:8080/test")
  assert_eq(url.host(), "[::1]:8080")
  assert_eq(url.hostname(), "[::1]")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters host #42" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com:65535") catch { _ => url }
  assert_eq(url.href(), "http://example.com:65535/path")
  assert_eq(url.host(), "example.com:65535")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "65535")
}

///|
test "WPT setters host #43" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_host("example.com:65536") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #44" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_host("[google.com]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters host #45" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_host("[::1.2.3.4x]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters host #46" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_host("[::1.2.3.]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters host #47" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_host("[::1.2.]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters host #48" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_host("[::1.]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters host #49" {
  let url = @url.Url::parse("file://y/")
  let url = url.with_host("x:123") catch { _ => url }
  assert_eq(url.href(), "file://y/")
  assert_eq(url.host(), "y")
  assert_eq(url.hostname(), "y")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #50" {
  let url = @url.Url::parse("file://y/")
  let url = url.with_host("loc%41lhost") catch { _ => url }
  assert_eq(url.href(), "file:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #51" {
  let url = @url.Url::parse("file://hi/x")
  let url = url.with_host("") catch { _ => url }
  assert_eq(url.href(), "file:///x")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
  assert_eq(url.port(), "")
}

///|
test "WPT setters host #52" {
  let url = @url.Url::parse("sc://test@test/")
  let url = url.with_host("") catch { _ => url }
  assert_eq(url.href(), "sc://test@test/")
  assert_eq(url.username(), "test")
  assert_eq(url.host(), "test")
  assert_eq(url.hostname(), "test")
}

///|
test "WPT setters host #53" {
  let url = @url.Url::parse("sc://test:12/")
  let url = url.with_host("") catch { _ => url }
  assert_eq(url.href(), "sc://test:12/")
  assert_eq(url.host(), "test:12")
  assert_eq(url.hostname(), "test")
  assert_eq(url.port(), "12")
}

///|
test "WPT setters host #54" {
  let url = @url.Url::parse("http://example.com/")
  let url = url.with_host("///bad.com") catch { _ => url }
  assert_eq(url.href(), "http://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
}

///|
test "WPT setters host #55" {
  let url = @url.Url::parse("sc://example.com/")
  let url = url.with_host("///bad.com") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters host #56" {
  let url = @url.Url::parse("https://example.com/")
  let url = url.with_host("a%C2%ADb") catch { _ => url }
  assert_eq(url.href(), "https://ab/")
  assert_eq(url.host(), "ab")
  assert_eq(url.hostname(), "ab")
}

///|
test "WPT setters host #57" {
  let url = @url.Url::parse("https://example.com/")
  let url = url.with_host("\u{AD}") catch { _ => url }
  assert_eq(url.href(), "https://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
}

///|
test "WPT setters host #58" {
  let url = @url.Url::parse("https://example.com/")
  let url = url.with_host("%C2%AD") catch { _ => url }
  assert_eq(url.href(), "https://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
}

///|
test "WPT setters host #59" {
  let url = @url.Url::parse("https://example.com/")
  let url = url.with_host("xn--") catch { _ => url }
  assert_eq(url.href(), "https://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
}

///|
test "WPT setters host #60" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_host("*") catch { _ => url }
  assert_eq(url.href(), "https://*/")
  assert_eq(url.host(), "*")
  assert_eq(url.hostname(), "*")
}

///|
test "WPT setters host #61" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_host("x@x") catch { _ => url }
  assert_eq(url.href(), "https://test.invalid/")
  assert_eq(url.host(), "test.invalid")
  assert_eq(url.hostname(), "test.invalid")
}

///|
test "WPT setters host #62" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_host("foo\t\r\nbar") catch { _ => url }
  assert_eq(url.href(), "https://foobar/")
  assert_eq(url.host(), "foobar")
  assert_eq(url.hostname(), "foobar")
}

///|
test "WPT setters host #63" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_host("><") catch { _ => url }
  assert_eq(url.href(), "https://test.invalid/")
  assert_eq(url.host(), "test.invalid")
  assert_eq(url.hostname(), "test.invalid")
}

///|
test "WPT setters host #64" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_host("test/@aaa") catch { _ => url }
  assert_eq(url.href(), "https://test/")
  assert_eq(url.host(), "test")
  assert_eq(url.hostname(), "test")
}

///|
test "WPT setters host #65" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_host("test/:aaa") catch { _ => url }
  assert_eq(url.href(), "https://test/")
  assert_eq(url.host(), "test")
  assert_eq(url.hostname(), "test")
}

///|
test "WPT setters host #66" {
  let url = @url.Url::parse("foo://path/to")
  let url = url.with_host(":80") catch { _ => url }
  assert_eq(url.href(), "foo://path/to")
  assert_eq(url.host(), "path")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #0" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname("\u{0}") catch { _ => url }
  assert_eq(url.href(), "sc://x/")
  assert_eq(url.host(), "x")
  assert_eq(url.hostname(), "x")
}

///|
test "WPT setters hostname #1" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname("\t") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters hostname #2" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname("\n") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters hostname #3" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname("\r") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters hostname #4" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname(" ") catch { _ => url }
  assert_eq(url.href(), "sc://x/")
  assert_eq(url.host(), "x")
  assert_eq(url.hostname(), "x")
}

///|
test "WPT setters hostname #5" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname("#") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters hostname #6" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname("/") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters hostname #7" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname("?") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters hostname #8" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_hostname("@") catch { _ => url }
  assert_eq(url.href(), "sc://x/")
  assert_eq(url.host(), "x")
  assert_eq(url.hostname(), "x")
}

///|
test "WPT setters hostname #9" {
  let url = @url.Url::parse("mailto:me@example.net")
  let url = url.with_hostname("example.com") catch { _ => url }
  assert_eq(url.href(), "mailto:me@example.net")
  assert_eq(url.host(), "")
}

///|
test "WPT setters hostname #10" {
  let url = @url.Url::parse("data:text/plain,Stuff")
  let url = url.with_hostname("example.net") catch { _ => url }
  assert_eq(url.href(), "data:text/plain,Stuff")
  assert_eq(url.host(), "")
}

///|
test "WPT setters hostname #11" {
  let url = @url.Url::parse("http://example.net:8080")
  let url = url.with_hostname("example.com") catch { _ => url }
  assert_eq(url.href(), "http://example.com:8080/")
  assert_eq(url.host(), "example.com:8080")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters hostname #12" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hostname("") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
}

///|
test "WPT setters hostname #13" {
  let url = @url.Url::parse("view-source+http://example.net/foo")
  let url = url.with_hostname("") catch { _ => url }
  assert_eq(url.href(), "view-source+http:///foo")
  assert_eq(url.host(), "")
}

///|
test "WPT setters hostname #14" {
  let url = @url.Url::parse("a:/foo")
  let url = url.with_hostname("example.net") catch { _ => url }
  assert_eq(url.href(), "a://example.net/foo")
  assert_eq(url.host(), "example.net")
}

///|
test "WPT setters hostname #15" {
  let url = @url.Url::parse("http://example.net:8080")
  let url = url.with_hostname("0x7F000001") catch { _ => url }
  assert_eq(url.href(), "http://127.0.0.1:8080/")
  assert_eq(url.host(), "127.0.0.1:8080")
  assert_eq(url.hostname(), "127.0.0.1")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters hostname #16" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hostname("[::0:01]") catch { _ => url }
  assert_eq(url.href(), "http://[::1]/")
  assert_eq(url.host(), "[::1]")
  assert_eq(url.hostname(), "[::1]")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #17" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_hostname("example.com:8080") catch { _ => url }
  assert_eq(url.href(), "http://example.net/path")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #18" {
  let url = @url.Url::parse("http://example.net:8080/path")
  let url = url.with_hostname("example.com:") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters hostname #19" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_hostname("example.com/stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #20" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_hostname("example.com?stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #21" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_hostname("example.com#stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #22" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_hostname("example.com\\stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.com/path")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #23" {
  let url = @url.Url::parse("view-source+http://example.net/path")
  let url = url.with_hostname("example.com\\stuff") catch { _ => url }
  assert_eq(url.href(), "view-source+http://example.net/path")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #24" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_hostname("[google.com]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters hostname #25" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_hostname("[::1.2.3.4x]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters hostname #26" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_hostname("[::1.2.3.]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters hostname #27" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_hostname("[::1.2.]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters hostname #28" {
  let url = @url.Url::parse("http://example.net/")
  let url = url.with_hostname("[::1.]") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
}

///|
test "WPT setters hostname #29" {
  let url = @url.Url::parse("file://y/")
  let url = url.with_hostname("x:123") catch { _ => url }
  assert_eq(url.href(), "file://y/")
  assert_eq(url.host(), "y")
  assert_eq(url.hostname(), "y")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #30" {
  let url = @url.Url::parse("file://y/")
  let url = url.with_hostname("loc%41lhost") catch { _ => url }
  assert_eq(url.href(), "file:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #31" {
  let url = @url.Url::parse("file://hi/x")
  let url = url.with_hostname("") catch { _ => url }
  assert_eq(url.href(), "file:///x")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
  assert_eq(url.port(), "")
}

///|
test "WPT setters hostname #32" {
  let url = @url.Url::parse("sc://test@test/")
  let url = url.with_hostname("") catch { _ => url }
  assert_eq(url.href(), "sc://test@test/")
  assert_eq(url.username(), "test")
  assert_eq(url.host(), "test")
  assert_eq(url.hostname(), "test")
}

///|
test "WPT setters hostname #33" {
  let url = @url.Url::parse("sc://test:12/")
  let url = url.with_hostname("") catch { _ => url }
  assert_eq(url.href(), "sc://test:12/")
  assert_eq(url.host(), "test:12")
  assert_eq(url.hostname(), "test")
  assert_eq(url.port(), "12")
}

///|
test "WPT setters hostname #34" {
  let url = @url.Url::parse("non-spec:/.//p")
  let url = url.with_hostname("h") catch { _ => url }
  assert_eq(url.href(), "non-spec://h//p")
  assert_eq(url.host(), "h")
  assert_eq(url.hostname(), "h")
  assert_eq(url.pathname(), "//p")
}

///|
test "WPT setters hostname #35" {
  let url = @url.Url::parse("non-spec:/.//p")
  let url = url.with_hostname("") catch { _ => url }
  assert_eq(url.href(), "non-spec:////p")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
  assert_eq(url.pathname(), "//p")
}

///|
test "WPT setters hostname #36" {
  let url = @url.Url::parse("http://example.com/")
  let url = url.with_hostname("///bad.com") catch { _ => url }
  assert_eq(url.href(), "http://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
}

///|
test "WPT setters hostname #37" {
  let url = @url.Url::parse("sc://example.com/")
  let url = url.with_hostname("///bad.com") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.host(), "")
  assert_eq(url.hostname(), "")
}

///|
test "WPT setters hostname #38" {
  let url = @url.Url::parse("https://example.com/")
  let url = url.with_hostname("a%C2%ADb") catch { _ => url }
  assert_eq(url.href(), "https://ab/")
  assert_eq(url.host(), "ab")
  assert_eq(url.hostname(), "ab")
}

///|
test "WPT setters hostname #39" {
  let url = @url.Url::parse("https://example.com/")
  let url = url.with_hostname("\u{AD}") catch { _ => url }
  assert_eq(url.href(), "https://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
}

///|
test "WPT setters hostname #40" {
  let url = @url.Url::parse("https://example.com/")
  let url = url.with_hostname("%C2%AD") catch { _ => url }
  assert_eq(url.href(), "https://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
}

///|
test "WPT setters hostname #41" {
  let url = @url.Url::parse("https://example.com/")
  let url = url.with_hostname("xn--") catch { _ => url }
  assert_eq(url.href(), "https://example.com/")
  assert_eq(url.host(), "example.com")
  assert_eq(url.hostname(), "example.com")
}

///|
test "WPT setters hostname #42" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_hostname("*") catch { _ => url }
  assert_eq(url.href(), "https://*/")
  assert_eq(url.host(), "*")
  assert_eq(url.hostname(), "*")
}

///|
test "WPT setters hostname #43" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_hostname("x@x") catch { _ => url }
  assert_eq(url.href(), "https://test.invalid/")
  assert_eq(url.host(), "test.invalid")
  assert_eq(url.hostname(), "test.invalid")
}

///|
test "WPT setters hostname #44" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_hostname("foo\t\r\nbar") catch { _ => url }
  assert_eq(url.href(), "https://foobar/")
  assert_eq(url.host(), "foobar")
  assert_eq(url.hostname(), "foobar")
}

///|
test "WPT setters hostname #45" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_hostname("><") catch { _ => url }
  assert_eq(url.href(), "https://test.invalid/")
  assert_eq(url.host(), "test.invalid")
  assert_eq(url.hostname(), "test.invalid")
}

///|
test "WPT setters hostname #46" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_hostname("test/@aaa") catch { _ => url }
  assert_eq(url.href(), "https://test/")
  assert_eq(url.host(), "test")
  assert_eq(url.hostname(), "test")
}

///|
test "WPT setters hostname #47" {
  let url = @url.Url::parse("https://test.invalid/")
  let url = url.with_hostname("test/:aaa") catch { _ => url }
  assert_eq(url.href(), "https://test/")
  assert_eq(url.host(), "test")
  assert_eq(url.hostname(), "test")
}

///|
test "WPT setters port #0" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_port("8080") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #1" {
  let url = @url.Url::parse("http://example.net:8080")
  let url = url.with_port("") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "")
}

///|
test "WPT setters port #2" {
  let url = @url.Url::parse("http://example.net:8080")
  let url = url.with_port("80") catch { _ => url }
  assert_eq(url.href(), "http://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "")
}

///|
test "WPT setters port #3" {
  let url = @url.Url::parse("https://example.net:4433")
  let url = url.with_port("443") catch { _ => url }
  assert_eq(url.href(), "https://example.net/")
  assert_eq(url.host(), "example.net")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "")
}

///|
test "WPT setters port #4" {
  let url = @url.Url::parse("https://example.net")
  let url = url.with_port("80") catch { _ => url }
  assert_eq(url.href(), "https://example.net:80/")
  assert_eq(url.host(), "example.net:80")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "80")
}

///|
test "WPT setters port #5" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_port("8080/stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #6" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_port("8080?stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #7" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_port("8080#stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #8" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_port("8080\\stuff") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #9" {
  let url = @url.Url::parse("view-source+http://example.net/path")
  let url = url.with_port("8080stuff2") catch { _ => url }
  assert_eq(url.href(), "view-source+http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #10" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_port("8080stuff2") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #11" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_port("8080+2") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #12" {
  let url = @url.Url::parse("http://example.net/path")
  let url = url.with_port("65535") catch { _ => url }
  assert_eq(url.href(), "http://example.net:65535/path")
  assert_eq(url.host(), "example.net:65535")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "65535")
}

///|
test "WPT setters port #13" {
  let url = @url.Url::parse("http://example.net:8080/path")
  let url = url.with_port("65536") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #14" {
  let url = @url.Url::parse("http://example.net:8080/path")
  let url = url.with_port("randomstring") catch { _ => url }
  assert_eq(url.href(), "http://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #15" {
  let url = @url.Url::parse("non-special://example.net:8080/path")
  let url = url.with_port("65536") catch { _ => url }
  assert_eq(url.href(), "non-special://example.net:8080/path")
  assert_eq(url.host(), "example.net:8080")
  assert_eq(url.hostname(), "example.net")
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #16" {
  let url = @url.Url::parse("file://test/")
  let url = url.with_port("12") catch { _ => url }
  assert_eq(url.href(), "file://test/")
  assert_eq(url.port(), "")
}

///|
test "WPT setters port #17" {
  let url = @url.Url::parse("file://localhost/")
  let url = url.with_port("12") catch { _ => url }
  assert_eq(url.href(), "file:///")
  assert_eq(url.port(), "")
}

///|
test "WPT setters port #18" {
  let url = @url.Url::parse("non-base:value")
  let url = url.with_port("12") catch { _ => url }
  assert_eq(url.href(), "non-base:value")
  assert_eq(url.port(), "")
}

///|
test "WPT setters port #19" {
  let url = @url.Url::parse("sc:///")
  let url = url.with_port("12") catch { _ => url }
  assert_eq(url.href(), "sc:///")
  assert_eq(url.port(), "")
}

///|
test "WPT setters port #20" {
  let url = @url.Url::parse("sc://x/")
  let url = url.with_port("12") catch { _ => url }
  assert_eq(url.href(), "sc://x:12/")
  assert_eq(url.port(), "12")
}

///|
test "WPT setters port #21" {
  let url = @url.Url::parse("javascript://x/")
  let url = url.with_port("12") catch { _ => url }
  assert_eq(url.href(), "javascript://x:12/")
  assert_eq(url.port(), "12")
}

///|
test "WPT setters port #22" {
  let url = @url.Url::parse("https://domain.com:443")
  let url = url.with_port("\t8080") catch { _ => url }
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #23" {
  let url = @url.Url::parse("wpt++://domain.com:443")
  let url = url.with_port("\t8080") catch { _ => url }
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #24" {
  let url = @url.Url::parse("https://www.google.com:4343")
  let url = url.with_port("4wpt") catch { _ => url }
  assert_eq(url.port(), "4")
}

///|
test "WPT setters port #25" {
  let url = @url.Url::parse("https://domain.com:3000")
  let url = url.with_port("\n\t80\n\t80\n\t") catch { _ => url }
  assert_eq(url.port(), "8080")
}

///|
test "WPT setters port #26" {
  let url = @url.Url::parse("https://domain.com:3000")
  let url = url.with_port("\n\n\t\t") catch { _ => url }
  assert_eq(url.port(), "3000")
}

///|
test "WPT setters pathname #0" {
  let url = @url.Url::parse("mailto:me@example.net")
  let url = url.with_pathname("/foo") catch { _ => url }
  assert_eq(url.href(), "mailto:me@example.net")
  assert_eq(url.pathname(), "me@example.net")
}

///|
test "WPT setters pathname #1" {
  let url = @url.Url::parse("data:original")
  let url = url.with_pathname("new value") catch { _ => url }
  assert_eq(url.href(), "data:original")
  assert_eq(url.pathname(), "original")
}

///|
test "WPT setters pathname #2" {
  let url = @url.Url::parse("sc:original")
  let url = url.with_pathname("new value") catch { _ => url }
  assert_eq(url.href(), "sc:original")
  assert_eq(url.pathname(), "original")
}

///|
test "WPT setters pathname #3" {
  let url = @url.Url::parse("file:///some/path")
  let url = url.with_pathname("") catch { _ => url }
  assert_eq(url.href(), "file:///")
  assert_eq(url.pathname(), "/")
}

///|
test "WPT setters pathname #4" {
  let url = @url.Url::parse("foo://somehost/some/path")
  let url = url.with_pathname("") catch { _ => url }
  assert_eq(url.href(), "foo://somehost")
  assert_eq(url.pathname(), "")
}

///|
test "WPT setters pathname #5" {
  let url = @url.Url::parse("foo:///some/path")
  let url = url.with_pathname("") catch { _ => url }
  assert_eq(url.href(), "foo://")
  assert_eq(url.pathname(), "")
}

///|
test "WPT setters pathname #6" {
  let url = @url.Url::parse("foo:/some/path")
  let url = url.with_pathname("") catch { _ => url }
  assert_eq(url.href(), "foo:/")
  assert_eq(url.pathname(), "/")
}

///|
test "WPT setters pathname #7" {
  let url = @url.Url::parse("foo:/some/path")
  let url = url.with_pathname("test") catch { _ => url }
  assert_eq(url.href(), "foo:/test")
  assert_eq(url.pathname(), "/test")
}

///|
test "WPT setters pathname #8" {
  let url = @url.Url::parse("unix:/run/foo.socket?timeout=10")
  let url = url.with_pathname("/var/log/../run/bar.socket") catch { _ => url }
  assert_eq(url.href(), "unix:/var/run/bar.socket?timeout=10")
  assert_eq(url.pathname(), "/var/run/bar.socket")
}

///|
test "WPT setters pathname #9" {
  let url = @url.Url::parse("https://example.net#nav")
  let url = url.with_pathname("home") catch { _ => url }
  assert_eq(url.href(), "https://example.net/home#nav")
  assert_eq(url.pathname(), "/home")
}

///|
test "WPT setters pathname #10" {
  let url = @url.Url::parse("https://example.net#nav")
  let url = url.with_pathname("../home") catch { _ => url }
  assert_eq(url.href(), "https://example.net/home#nav")
  assert_eq(url.pathname(), "/home")
}

///|
test "WPT setters pathname #11" {
  let url = @url.Url::parse("http://example.net/home?lang=fr#nav")
  let url = url.with_pathname("\\a\\%2E\\b\\%2e.\\c") catch { _ => url }
  assert_eq(url.href(), "http://example.net/a/c?lang=fr#nav")
  assert_eq(url.pathname(), "/a/c")
}

///|
test "WPT setters pathname #12" {
  let url = @url.Url::parse("view-source+http://example.net/home?lang=fr#nav")
  let url = url.with_pathname("\\a\\%2E\\b\\%2e.\\c") catch { _ => url }
  assert_eq(
    url.href(),
    "view-source+http://example.net/\\a\\%2E\\b\\%2e.\\c?lang=fr#nav",
  )
  assert_eq(url.pathname(), "/\\a\\%2E\\b\\%2e.\\c")
}

///|
test "WPT setters pathname #13" {
  let url = @url.Url::parse("a:/")
  let url = url.with_pathname(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  ) catch {
    _ => url
  }
  assert_eq(
    url.href(),
    "a:/%00%01%1F%20!%22%23$%&'()*+,-./09:;%3C=%3E%3F@AZ[\\]%5E_%60az%7B|%7D~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
  assert_eq(
    url.pathname(),
    "/%00%01%1F%20!%22%23$%&'()*+,-./09:;%3C=%3E%3F@AZ[\\]%5E_%60az%7B|%7D~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters pathname #14" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_pathname("%2e%2E%c3%89t\u{E9}") catch { _ => url }
  assert_eq(url.href(), "http://example.net/%2e%2E%c3%89t%C3%A9")
  assert_eq(url.pathname(), "/%2e%2E%c3%89t%C3%A9")
}

///|
test "WPT setters pathname #15" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_pathname("?") catch { _ => url }
  assert_eq(url.href(), "http://example.net/%3F")
  assert_eq(url.pathname(), "/%3F")
}

///|
test "WPT setters pathname #16" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_pathname("#") catch { _ => url }
  assert_eq(url.href(), "http://example.net/%23")
  assert_eq(url.pathname(), "/%23")
}

///|
test "WPT setters pathname #17" {
  let url = @url.Url::parse("sc://example.net")
  let url = url.with_pathname("?") catch { _ => url }
  assert_eq(url.href(), "sc://example.net/%3F")
  assert_eq(url.pathname(), "/%3F")
}

///|
test "WPT setters pathname #18" {
  let url = @url.Url::parse("sc://example.net")
  let url = url.with_pathname("#") catch { _ => url }
  assert_eq(url.href(), "sc://example.net/%23")
  assert_eq(url.pathname(), "/%23")
}

///|
test "WPT setters pathname #19" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_pathname("/?\u{E9}") catch { _ => url }
  assert_eq(url.href(), "http://example.net/%3F%C3%A9")
  assert_eq(url.pathname(), "/%3F%C3%A9")
}

///|
test "WPT setters pathname #20" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_pathname("/#\u{E9}") catch { _ => url }
  assert_eq(url.href(), "http://example.net/%23%C3%A9")
  assert_eq(url.pathname(), "/%23%C3%A9")
}

///|
test "WPT setters pathname #21" {
  let url = @url.Url::parse("file://monkey/")
  let url = url.with_pathname("\\\\") catch { _ => url }
  assert_eq(url.href(), "file://monkey//")
  assert_eq(url.pathname(), "//")
}

///|
test "WPT setters pathname #22" {
  let url = @url.Url::parse("file:///unicorn")
  let url = url.with_pathname("//\\/") catch { _ => url }
  assert_eq(url.href(), "file://////")
  assert_eq(url.pathname(), "////")
}

///|
test "WPT setters pathname #23" {
  let url = @url.Url::parse("file:///unicorn")
  let url = url.with_pathname("//monkey/..//") catch { _ => url }
  assert_eq(url.href(), "file://///")
  assert_eq(url.pathname(), "///")
}

///|
test "WPT setters pathname #24" {
  let url = @url.Url::parse("non-spec:/")
  let url = url.with_pathname("/.//p") catch { _ => url }
  assert_eq(url.href(), "non-spec:/.//p")
  assert_eq(url.pathname(), "//p")
}

///|
test "WPT setters pathname #25" {
  let url = @url.Url::parse("non-spec:/")
  let url = url.with_pathname("/..//p") catch { _ => url }
  assert_eq(url.href(), "non-spec:/.//p")
  assert_eq(url.pathname(), "//p")
}

///|
test "WPT setters pathname #26" {
  let url = @url.Url::parse("non-spec:/")
  let url = url.with_pathname("//p") catch { _ => url }
  assert_eq(url.href(), "non-spec:/.//p")
  assert_eq(url.pathname(), "//p")
}

///|
test "WPT setters pathname #27" {
  let url = @url.Url::parse("non-spec:/.//")
  let url = url.with_pathname("p") catch { _ => url }
  assert_eq(url.href(), "non-spec:/p")
  assert_eq(url.pathname(), "/p")
}

///|
test "WPT setters pathname #28" {
  let url = @url.Url::parse("data:/nospace")
  let url = url.with_pathname("space ") catch { _ => url }
  assert_eq(url.href(), "data:/space%20")
  assert_eq(url.pathname(), "/space%20")
}

///|
test "WPT setters pathname #29" {
  let url = @url.Url::parse("sc:/nospace")
  let url = url.with_pathname("space ") catch { _ => url }
  assert_eq(url.href(), "sc:/space%20")
  assert_eq(url.pathname(), "/space%20")
}

///|
test "WPT setters pathname #30" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_pathname(" ") catch { _ => url }
  assert_eq(url.href(), "http://example.net/%20")
  assert_eq(url.pathname(), "/%20")
}

///|
test "WPT setters pathname #31" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_pathname("\u{0}") catch { _ => url }
  assert_eq(url.href(), "http://example.net/%00")
  assert_eq(url.pathname(), "/%00")
}

///|
test "WPT setters pathname #32" {
  let url = @url.Url::parse("foo://path/to")
  let url = url.with_pathname("/..") catch { _ => url }
  assert_eq(url.href(), "foo://path/")
  assert_eq(url.pathname(), "/")
}

///|
test "WPT setters search #0" {
  let url = @url.Url::parse("https://example.net#nav")
  let url = url.with_search("lang=fr")
  assert_eq(url.href(), "https://example.net/?lang=fr#nav")
  assert_eq(url.search(), "?lang=fr")
}

///|
test "WPT setters search #1" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  let url = url.with_search("lang=fr")
  assert_eq(url.href(), "https://example.net/?lang=fr#nav")
  assert_eq(url.search(), "?lang=fr")
}

///|
test "WPT setters search #2" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  let url = url.with_search("?lang=fr")
  assert_eq(url.href(), "https://example.net/?lang=fr#nav")
  assert_eq(url.search(), "?lang=fr")
}

///|
test "WPT setters search #3" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  let url = url.with_search("??lang=fr")
  assert_eq(url.href(), "https://example.net/??lang=fr#nav")
  assert_eq(url.search(), "??lang=fr")
}

///|
test "WPT setters search #4" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  let url = url.with_search("?")
  assert_eq(url.href(), "https://example.net/?#nav")
  assert_eq(url.search(), "")
}

///|
test "WPT setters search #5" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  let url = url.with_search("")
  assert_eq(url.href(), "https://example.net/#nav")
  assert_eq(url.search(), "")
}

///|
test "WPT setters search #6" {
  let url = @url.Url::parse("https://example.net?lang=en-US")
  let url = url.with_search("")
  assert_eq(url.href(), "https://example.net/")
  assert_eq(url.search(), "")
}

///|
test "WPT setters search #7" {
  let url = @url.Url::parse("https://example.net")
  let url = url.with_search("")
  assert_eq(url.href(), "https://example.net/")
  assert_eq(url.search(), "")
}

///|
test "WPT setters search #8" {
  let url = @url.Url::parse("a:/")
  let url = url.with_search(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  )
  assert_eq(
    url.href(),
    "a:/?%00%01%1F%20!%22%23$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_`az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
  assert_eq(
    url.search(),
    "?%00%01%1F%20!%22%23$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_`az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters search #9" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_search("%c3%89t\u{E9}")
  assert_eq(url.href(), "http://example.net/?%c3%89t%C3%A9")
  assert_eq(url.search(), "?%c3%89t%C3%A9")
}

///|
test "WPT setters search #10" {
  let url = @url.Url::parse("data:space ?query")
  let url = url.with_search("")
  assert_eq(url.href(), "data:space%20")
  assert_eq(url.pathname(), "space%20")
  assert_eq(url.search(), "")
}

///|
test "WPT setters search #11" {
  let url = @url.Url::parse("sc:space ?query")
  let url = url.with_search("")
  assert_eq(url.href(), "sc:space%20")
  assert_eq(url.pathname(), "space%20")
  assert_eq(url.search(), "")
}

///|
test "WPT setters search #12" {
  let url = @url.Url::parse("data:space  ?query#fragment")
  let url = url.with_search("")
  assert_eq(url.href(), "data:space %20#fragment")
  assert_eq(url.search(), "")
}

///|
test "WPT setters search #13" {
  let url = @url.Url::parse("sc:space  ?query#fragment")
  let url = url.with_search("")
  assert_eq(url.href(), "sc:space %20#fragment")
  assert_eq(url.search(), "")
}

///|
test "WPT setters search #14" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_search(" ")
  assert_eq(url.href(), "http://example.net/?%20")
  assert_eq(url.search(), "?%20")
}

///|
test "WPT setters search #15" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_search("\u{0}")
  assert_eq(url.href(), "http://example.net/?%00")
  assert_eq(url.search(), "?%00")
}

///|
test "WPT setters hash #0" {
  let url = @url.Url::parse("https://example.net")
  let url = url.with_hash("main")
  assert_eq(url.href(), "https://example.net/#main")
  assert_eq(url.hash(), "#main")
}

///|
test "WPT setters hash #1" {
  let url = @url.Url::parse("https://example.net#nav")
  let url = url.with_hash("main")
  assert_eq(url.href(), "https://example.net/#main")
  assert_eq(url.hash(), "#main")
}

///|
test "WPT setters hash #2" {
  let url = @url.Url::parse("https://example.net?lang=en-US")
  let url = url.with_hash("##nav")
  assert_eq(url.href(), "https://example.net/?lang=en-US##nav")
  assert_eq(url.hash(), "##nav")
}

///|
test "WPT setters hash #3" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  let url = url.with_hash("#main")
  assert_eq(url.href(), "https://example.net/?lang=en-US#main")
  assert_eq(url.hash(), "#main")
}

///|
test "WPT setters hash #4" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  let url = url.with_hash("#")
  assert_eq(url.href(), "https://example.net/?lang=en-US#")
  assert_eq(url.hash(), "")
}

///|
test "WPT setters hash #5" {
  let url = @url.Url::parse("https://example.net?lang=en-US#nav")
  let url = url.with_hash("")
  assert_eq(url.href(), "https://example.net/?lang=en-US")
  assert_eq(url.hash(), "")
}

///|
test "WPT setters hash #6" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash("#foo bar")
  assert_eq(url.href(), "http://example.net/#foo%20bar")
  assert_eq(url.hash(), "#foo%20bar")
}

///|
test "WPT setters hash #7" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash("#foo\"bar")
  assert_eq(url.href(), "http://example.net/#foo%22bar")
  assert_eq(url.hash(), "#foo%22bar")
}

///|
test "WPT setters hash #8" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash("#foo<bar")
  assert_eq(url.href(), "http://example.net/#foo%3Cbar")
  assert_eq(url.hash(), "#foo%3Cbar")
}

///|
test "WPT setters hash #9" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash("#foo>bar")
  assert_eq(url.href(), "http://example.net/#foo%3Ebar")
  assert_eq(url.hash(), "#foo%3Ebar")
}

///|
test "WPT setters hash #10" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash("#foo`bar")
  assert_eq(url.href(), "http://example.net/#foo%60bar")
  assert_eq(url.hash(), "#foo%60bar")
}

///|
test "WPT setters hash #11" {
  let url = @url.Url::parse("a:/")
  let url = url.with_hash(
    "\u{0}\u{1}\t\n\r\u{1F} !\"#$%&'()*+,-./09:;<=>?@AZ[\\]^_`az{|}~\u{7F}\u{80}\u{81}\u{C9}\u{E9}",
  )
  assert_eq(
    url.href(),
    "a:/#%00%01%1F%20!%22#$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_%60az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
  assert_eq(
    url.hash(),
    "#%00%01%1F%20!%22#$%&'()*+,-./09:;%3C=%3E?@AZ[\\]^_%60az{|}~%7F%C2%80%C2%81%C3%89%C3%A9",
  )
}

///|
test "WPT setters hash #12" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash("a\u{0}b")
  assert_eq(url.href(), "http://example.net/#a%00b")
  assert_eq(url.hash(), "#a%00b")
}

///|
test "WPT setters hash #13" {
  let url = @url.Url::parse("non-spec:/")
  let url = url.with_hash("a\u{0}b")
  assert_eq(url.href(), "non-spec:/#a%00b")
  assert_eq(url.hash(), "#a%00b")
}

///|
test "WPT setters hash #14" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash("%c3%89t\u{E9}")
  assert_eq(url.href(), "http://example.net/#%c3%89t%C3%A9")
  assert_eq(url.hash(), "#%c3%89t%C3%A9")
}

///|
test "WPT setters hash #15" {
  let url = @url.Url::parse("javascript:alert(1)")
  let url = url.with_hash("castle")
  assert_eq(url.href(), "javascript:alert(1)#castle")
  assert_eq(url.hash(), "#castle")
}

///|
test "WPT setters hash #16" {
  let url = @url.Url::parse(
    "data:space                                                                                                                                  #fragment",
  )
  let url = url.with_hash("")
  assert_eq(
    url.href(),
    "data:space                                                                                                                                 %20",
  )
  assert_eq(
    url.pathname(),
    "space                                                                                                                                 %20",
  )
  assert_eq(url.hash(), "")
}

///|
test "WPT setters hash #17" {
  let url = @url.Url::parse("sc:space    #fragment")
  let url = url.with_hash("")
  assert_eq(url.href(), "sc:space   %20")
  assert_eq(url.pathname(), "space   %20")
  assert_eq(url.hash(), "")
}

///|
test "WPT setters hash #18" {
  let url = @url.Url::parse("data:space  ?query#fragment")
  let url = url.with_hash("")
  assert_eq(url.href(), "data:space %20?query")
  assert_eq(url.hash(), "")
}

///|
test "WPT setters hash #19" {
  let url = @url.Url::parse("sc:space  ?query#fragment")
  let url = url.with_hash("")
  assert_eq(url.href(), "sc:space %20?query")
  assert_eq(url.hash(), "")
}

///|
test "WPT setters hash #20" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash(" ")
  assert_eq(url.href(), "http://example.net/#%20")
  assert_eq(url.hash(), "#%20")
}

///|
test "WPT setters hash #21" {
  let url = @url.Url::parse("http://example.net")
  let url = url.with_hash("\u{0}")
  assert_eq(url.href(), "http://example.net/#%00")
  assert_eq(url.hash(), "#%00")
}
