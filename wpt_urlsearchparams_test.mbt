// Auto-generated from WPT URLSearchParams test files
// https://github.com/nicety/test/wpt/tree/master/url
// Do not edit manually
//
// To regenerate: python3 scripts/generate_wpt_urlsearchparams_tests.py > wpt_urlsearchparams_test.mbt

///|
test "WPT URLSearchParams constructor #0 - Basic URLSearchParams construction" {
  let params = @url.UrlSearchParams::from_string("")
  assert_eq(params.to_string(), "")
}

///|
test "WPT URLSearchParams constructor #1 - Basic URLSearchParams construction" {
  let params = @url.UrlSearchParams::from_string("a=b")
  assert_eq(params.to_string(), "a=b")
}

///|
test "WPT URLSearchParams constructor #2 - URLSearchParams constructor, remove lead" {
  let params = @url.UrlSearchParams::from_string("?a=b")
  assert_eq(params.to_string(), "a=b")
}

///|
test "WPT URLSearchParams constructor #3 - URLSearchParams constructor, string." {
  let params = @url.UrlSearchParams::from_string("id=0&value=%")
  assert_eq(params.get("id"), Some("0"))
}

///|
test "WPT URLSearchParams constructor #4 - URLSearchParams constructor, string." {
  let params = @url.UrlSearchParams::from_string("id=0&value=%")
  assert_eq(params.get("value"), Some("%"))
}

///|
test "WPT URLSearchParams constructor #5 - URLSearchParams constructor, string." {
  let params = @url.UrlSearchParams::from_string("b=%2sf%2a")
  assert_eq(params.get("b"), Some("%2sf*"))
}

///|
test "WPT URLSearchParams constructor #6 - URLSearchParams constructor, string." {
  let params = @url.UrlSearchParams::from_string("b=%2%2af%2a")
  assert_eq(params.get("b"), Some("%2*f*"))
}

///|
test "WPT URLSearchParams constructor #7 - URLSearchParams constructor, string." {
  let params = @url.UrlSearchParams::from_string("b=%%2a")
  assert_eq(params.get("b"), Some("%*"))
}

///|
test "WPT URLSearchParams constructor #8 - URLSearchParams constructor, object." {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_eq(params.get("a"), Some("b"))
}

///|
test "WPT URLSearchParams constructor #9 - URLSearchParams constructor, object." {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_eq(params.get("c"), Some("d"))
}

///|
test "WPT URLSearchParams constructor #10 - Parse +" {
  let params = @url.UrlSearchParams::from_string("a=b+c")
  assert_eq(params.get("a"), Some("b c"))
}

///|
test "WPT URLSearchParams constructor #11 - Parse +" {
  let params = @url.UrlSearchParams::from_string("a+b=c")
  assert_eq(params.get("a b"), Some("c"))
}

///|
test "WPT URLSearchParams constructor #12 - Parse space" {
  let params = @url.UrlSearchParams::from_string("a=b c")
  assert_eq(params.get("a"), Some("b c"))
}

///|
test "WPT URLSearchParams constructor #13 - Parse space" {
  let params = @url.UrlSearchParams::from_string("a b=c")
  assert_eq(params.get("a b"), Some("c"))
}

///|
test "WPT URLSearchParams constructor #14 - Parse %20" {
  let params = @url.UrlSearchParams::from_string("a=b%20c")
  assert_eq(params.get("a"), Some("b c"))
}

///|
test "WPT URLSearchParams constructor #15 - Parse %20" {
  let params = @url.UrlSearchParams::from_string("a%20b=c")
  assert_eq(params.get("a b"), Some("c"))
}

///|
test "WPT URLSearchParams constructor #16 - Parse \\\\0" {
  let params = @url.UrlSearchParams::from_string("a=b\u{0000}c")
  assert_eq(params.get("a"), Some("b\u{0000}c"))
}

///|
test "WPT URLSearchParams constructor #17 - Parse \\\\0" {
  let params = @url.UrlSearchParams::from_string("a\u{0000}b=c")
  assert_eq(params.get("a\u{0000}b"), Some("c"))
}

///|
test "WPT URLSearchParams constructor #18 - Parse %00" {
  let params = @url.UrlSearchParams::from_string("a=b%00c")
  assert_eq(params.get("a"), Some("b\u{0000}c"))
}

///|
test "WPT URLSearchParams constructor #19 - Parse %00" {
  let params = @url.UrlSearchParams::from_string("a%00b=c")
  assert_eq(params.get("a\u{0000}b"), Some("c"))
}

///|
test "WPT URLSearchParams constructor #20 - Parse \\u2384" {
  let params = @url.UrlSearchParams::from_string("a=b\u{2384}")
  assert_eq(params.get("a"), Some("b\u{2384}"))
}

///|
test "WPT URLSearchParams constructor #21 - Parse \\u2384" {
  let params = @url.UrlSearchParams::from_string("a\u{2384}b=c")
  assert_eq(params.get("a\u{2384}b"), Some("c"))
}

///|
test "WPT URLSearchParams constructor #22 - Parse %e2%8e%84" {
  let params = @url.UrlSearchParams::from_string("a=b%e2%8e%84")
  assert_eq(params.get("a"), Some("b\u{2384}"))
}

///|
test "WPT URLSearchParams constructor #23 - Parse %e2%8e%84" {
  let params = @url.UrlSearchParams::from_string("a%e2%8e%84b=c")
  assert_eq(params.get("a\u{2384}b"), Some("c"))
}

///|
test "WPT URLSearchParams constructor #24 - Parse \\uD83D\\uDCA9" {
  let params = @url.UrlSearchParams::from_string("a=b\u{1F4A9}c")
  assert_eq(params.get("a"), Some("b\u{1F4A9}c"))
}

///|
test "WPT URLSearchParams constructor #25 - Parse \\uD83D\\uDCA9" {
  let params = @url.UrlSearchParams::from_string("a\u{1F4A9}b=c")
  assert_eq(params.get("a\u{1F4A9}b"), Some("c"))
}

///|
test "WPT URLSearchParams constructor #26 - Parse %f0%9f%92%a9" {
  let params = @url.UrlSearchParams::from_string("a=b%f0%9f%92%a9c")
  assert_eq(params.get("a"), Some("b\u{1F4A9}c"))
}

///|
test "WPT URLSearchParams constructor #27 - Parse %f0%9f%92%a9" {
  let params = @url.UrlSearchParams::from_string("a%f0%9f%92%a9b=c")
  assert_eq(params.get("a\u{1F4A9}b"), Some("c"))
}

///|
test "WPT URLSearchParams append #0 - Append same name" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b")
  assert_eq(params.to_string(), "a=b")
}

///|
test "WPT URLSearchParams append #1 - Append same name" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b")
  params.append("a", "b")
  assert_eq(params.to_string(), "a=b&a=b")
}

///|
test "WPT URLSearchParams append #2 - Append same name" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b")
  params.append("a", "b")
  params.append("a", "c")
  assert_eq(params.to_string(), "a=b&a=b&a=c")
}

///|
test "WPT URLSearchParams append #3 - Append empty strings" {
  let params = @url.UrlSearchParams::new()
  params.append("", "")
  assert_eq(params.to_string(), "=")
}

///|
test "WPT URLSearchParams append #4 - Append empty strings" {
  let params = @url.UrlSearchParams::new()
  params.append("", "")
  params.append("", "")
  assert_eq(params.to_string(), "=&=")
}

///|
test "WPT URLSearchParams delete #0 - Delete basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  params.delete("a")
  assert_eq(params.to_string(), "c=d")
}

///|
test "WPT URLSearchParams delete #1 - Delete basics" {
  let params = @url.UrlSearchParams::from_string("a=a&b=b&a=a&c=c")
  params.delete("a")
  assert_eq(params.to_string(), "b=b&c=c")
}

///|
test "WPT URLSearchParams delete #2 - Delete basics" {
  let params = @url.UrlSearchParams::from_string("a=a&=&b=b&c=c")
  params.delete("")
  assert_eq(params.to_string(), "a=a&b=b&c=c")
}

///|
test "WPT URLSearchParams delete #3 - Delete basics" {
  let params = @url.UrlSearchParams::from_string("a=a&null=null&b=b")
  params.delete("null")
  assert_eq(params.to_string(), "a=a&b=b")
}

///|
test "WPT URLSearchParams delete #4 - Delete basics" {
  let params = @url.UrlSearchParams::from_string("a=a&undefined=undefined&b=b")
  params.delete("undefined")
  assert_eq(params.to_string(), "a=a&b=b")
}

///|
test "WPT URLSearchParams get #0 - Get basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_eq(params.get("a"), Some("b"))
}

///|
test "WPT URLSearchParams get #1 - Get basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_eq(params.get("c"), Some("d"))
}

///|
test "WPT URLSearchParams get #2 - Get basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_eq(params.get("e"), None)
}

///|
test "WPT URLSearchParams get #3 - Get basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d&a=e")
  assert_eq(params.get("a"), Some("b"))
}

///|
test "WPT URLSearchParams get #4 - Get basics" {
  let params = @url.UrlSearchParams::from_string("=b&c=d")
  assert_eq(params.get(""), Some("b"))
}

///|
test "WPT URLSearchParams get #5 - Get basics" {
  let params = @url.UrlSearchParams::from_string("a=&c=d&a=e")
  assert_eq(params.get("a"), Some(""))
}

///|
test "WPT URLSearchParams get #6 - More get() basics" {
  let params = @url.UrlSearchParams::from_string("first=second&third&&")
  assert_eq(params.get("first"), Some("second"))
}

///|
test "WPT URLSearchParams get #7 - More get() basics" {
  let params = @url.UrlSearchParams::from_string("first=second&third&&")
  assert_eq(params.get("third"), Some(""))
}

///|
test "WPT URLSearchParams get #8 - More get() basics" {
  let params = @url.UrlSearchParams::from_string("first=second&third&&")
  assert_eq(params.get("fourth"), None)
}

///|
test "WPT URLSearchParams getAll #0 - getAll() basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_eq(params.get_all("a"), ["b"])
}

///|
test "WPT URLSearchParams getAll #1 - getAll() basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_eq(params.get_all("c"), ["d"])
}

///|
test "WPT URLSearchParams getAll #2 - getAll() basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_eq(params.get_all("e"), [])
}

///|
test "WPT URLSearchParams getAll #3 - getAll() basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d&a=e")
  assert_eq(params.get_all("a"), ["b", "e"])
}

///|
test "WPT URLSearchParams getAll #4 - getAll() basics" {
  let params = @url.UrlSearchParams::from_string("=b&c=d")
  assert_eq(params.get_all(""), ["b"])
}

///|
test "WPT URLSearchParams getAll #5 - getAll() basics" {
  let params = @url.UrlSearchParams::from_string("a=&c=d&a=e")
  assert_eq(params.get_all("a"), ["", "e"])
}

///|
test "WPT URLSearchParams has #0 - Has basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_true(params.has("a"))
}

///|
test "WPT URLSearchParams has #1 - Has basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_true(params.has("c"))
}

///|
test "WPT URLSearchParams has #2 - Has basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  assert_false(params.has("e"))
}

///|
test "WPT URLSearchParams has #3 - Has basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d&a=e")
  assert_true(params.has("a"))
}

///|
test "WPT URLSearchParams has #4 - Has basics" {
  let params = @url.UrlSearchParams::from_string("=b&c=d")
  assert_true(params.has(""))
}

///|
test "WPT URLSearchParams has #5 - Has basics" {
  let params = @url.UrlSearchParams::from_string("null=a")
  assert_true(params.has("null"))
}

///|
test "WPT URLSearchParams has #6 - Two-argument has()" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  assert_true(params.has("a", value="b"))
}

///|
test "WPT URLSearchParams has #7 - Two-argument has()" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  assert_false(params.has("a", value="c"))
}

///|
test "WPT URLSearchParams has #8 - Two-argument has()" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  assert_true(params.has("a", value="d"))
}

///|
test "WPT URLSearchParams has #9 - Two-argument has()" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  assert_true(params.has("e", value=""))
}

///|
test "WPT URLSearchParams has #10 - Two-argument has()" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  params.append("first", "null")
  assert_false(params.has("first", value=""))
}

///|
test "WPT URLSearchParams has #11 - Two-argument has()" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  params.append("first", "null")
  assert_true(params.has("first", value="null"))
}

///|
test "WPT URLSearchParams has #12 - Two-argument has()" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  params.append("first", "null")
  params.delete("a", value="b")
  assert_true(params.has("a", value="d"))
}

///|
test "WPT URLSearchParams has #13 - Two-argument has() respects undefined as" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  assert_true(params.has("a", value="b"))
}

///|
test "WPT URLSearchParams has #14 - Two-argument has() respects undefined as" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  assert_false(params.has("a", value="c"))
}

///|
test "WPT URLSearchParams has #15 - Two-argument has() respects undefined as" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  assert_true(params.has("a", value="d"))
}

///|
test "WPT URLSearchParams has #16 - Two-argument has() respects undefined as" {
  let params = @url.UrlSearchParams::from_string("a=b&a=d&c&e&")
  assert_true(params.has("a"))
}

///|
test "WPT URLSearchParams set #0 - Set basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d")
  params.set("a", "B")
  assert_eq(params.to_string(), "a=B&c=d")
}

///|
test "WPT URLSearchParams set #1 - Set basics" {
  let params = @url.UrlSearchParams::from_string("a=b&c=d&a=e")
  params.set("a", "B")
  assert_eq(params.to_string(), "a=B&c=d")
}

///|
test "WPT URLSearchParams size #0 - URLSearchParams" {
  let params = @url.UrlSearchParams::from_string("a=1&b=2&a=3")
  assert_eq(params.size(), 3)
}

///|
test "WPT URLSearchParams size #1 - URLSearchParams" {
  let params = @url.UrlSearchParams::from_string("a=1&b=2&a=3")
  assert_eq(params.size(), 3)
}

///|
test "WPT URLSearchParams sort #0" {
  let params = @url.UrlSearchParams::from_string("z=b&a=b&z=a&a=a")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [("a", "b"), ("a", "a"), ("z", "b"), ("z", "a")])
}

///|
test "WPT URLSearchParams sort #1" {
  let params = @url.UrlSearchParams::from_string("\u{FFFD}=x&\u{FFFC}&\u{FFFD}=a")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [("\u{FFFC}", ""), ("\u{FFFD}", "x"), ("\u{FFFD}", "a")])
}

///|
test "WPT URLSearchParams sort #2" {
  let params = @url.UrlSearchParams::from_string("\u{FB03}&\u{1F308}")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [("\u{1F308}", ""), ("\u{FB03}", "")])
}

///|
test "WPT URLSearchParams sort #3" {
  let params = @url.UrlSearchParams::from_string("\u{00E9}&e\u{FFFD}&e\u{0301}")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [("e\u{0301}", ""), ("e\u{FFFD}", ""), ("\u{00E9}", "")])
}

///|
test "WPT URLSearchParams sort #4" {
  let params = @url.UrlSearchParams::from_string("z=z&a=a&z=y&a=b&z=x&a=c&z=w&a=d&z=v&a=e&z=u&a=f&z=t&a=g")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [("a", "a"), ("a", "b"), ("a", "c"), ("a", "d"), ("a", "e"), ("a", "f"), ("a", "g"), ("z", "z"), ("z", "y"), ("z", "x"), ("z", "w"), ("z", "v"), ("z", "u"), ("z", "t")])
}

///|
test "WPT URLSearchParams sort #5" {
  let params = @url.UrlSearchParams::from_string("bbb&bb&aaa&aa=x&aa=y")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [("aa", "x"), ("aa", "y"), ("aaa", ""), ("bb", ""), ("bbb", "")])
}

///|
test "WPT URLSearchParams sort #6" {
  let params = @url.UrlSearchParams::from_string("z=z&=f&=t&=x")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [("", "f"), ("", "t"), ("", "x"), ("z", "z")])
}

///|
test "WPT URLSearchParams sort #7" {
  let params = @url.UrlSearchParams::from_string("a\u{1F308}&a\u{1F4A9}")
  params.sort()
  let pairs = params.iter().collect()
  assert_eq(pairs, [("a\u{1F308}", ""), ("a\u{1F4A9}", "")])
}

///|
test "WPT URLSearchParams stringifier #0 - Serialize space" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b c")
  assert_eq(params.to_string(), "a=b+c")
}

///|
test "WPT URLSearchParams stringifier #1 - Serialize space" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b c")
  params.delete("a")
  params.append("a b", "c")
  assert_eq(params.to_string(), "a+b=c")
}

///|
test "WPT URLSearchParams stringifier #2 - Serialize empty value" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "")
  assert_eq(params.to_string(), "a=")
}

///|
test "WPT URLSearchParams stringifier #3 - Serialize empty value" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "")
  params.append("a", "")
  assert_eq(params.to_string(), "a=&a=")
}

///|
test "WPT URLSearchParams stringifier #4 - Serialize empty value" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "")
  params.append("a", "")
  params.append("", "b")
  assert_eq(params.to_string(), "a=&a=&=b")
}

///|
test "WPT URLSearchParams stringifier #5 - Serialize empty value" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "")
  params.append("a", "")
  params.append("", "b")
  params.append("", "")
  assert_eq(params.to_string(), "a=&a=&=b&=")
}

///|
test "WPT URLSearchParams stringifier #6 - Serialize empty value" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "")
  params.append("a", "")
  params.append("", "b")
  params.append("", "")
  params.append("", "")
  assert_eq(params.to_string(), "a=&a=&=b&=&=")
}

///|
test "WPT URLSearchParams stringifier #7 - Serialize empty name" {
  let params = @url.UrlSearchParams::new()
  params.append("", "b")
  assert_eq(params.to_string(), "=b")
}

///|
test "WPT URLSearchParams stringifier #8 - Serialize empty name" {
  let params = @url.UrlSearchParams::new()
  params.append("", "b")
  params.append("", "b")
  assert_eq(params.to_string(), "=b&=b")
}

///|
test "WPT URLSearchParams stringifier #9 - Serialize empty name and value" {
  let params = @url.UrlSearchParams::new()
  params.append("", "")
  assert_eq(params.to_string(), "=")
}

///|
test "WPT URLSearchParams stringifier #10 - Serialize empty name and value" {
  let params = @url.UrlSearchParams::new()
  params.append("", "")
  params.append("", "")
  assert_eq(params.to_string(), "=&=")
}

///|
test "WPT URLSearchParams stringifier #11 - Serialize +" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b+c")
  assert_eq(params.to_string(), "a=b%2Bc")
}

///|
test "WPT URLSearchParams stringifier #12 - Serialize +" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b+c")
  params.delete("a")
  params.append("a+b", "c")
  assert_eq(params.to_string(), "a%2Bb=c")
}

///|
test "WPT URLSearchParams stringifier #13 - Serialize =" {
  let params = @url.UrlSearchParams::new()
  params.append("=", "a")
  assert_eq(params.to_string(), "%3D=a")
}

///|
test "WPT URLSearchParams stringifier #14 - Serialize =" {
  let params = @url.UrlSearchParams::new()
  params.append("=", "a")
  params.append("b", "=")
  assert_eq(params.to_string(), "%3D=a&b=%3D")
}

///|
test "WPT URLSearchParams stringifier #15 - Serialize &" {
  let params = @url.UrlSearchParams::new()
  params.append("&", "a")
  assert_eq(params.to_string(), "%26=a")
}

///|
test "WPT URLSearchParams stringifier #16 - Serialize &" {
  let params = @url.UrlSearchParams::new()
  params.append("&", "a")
  params.append("b", "&")
  assert_eq(params.to_string(), "%26=a&b=%26")
}

///|
test "WPT URLSearchParams stringifier #17 - Serialize *-._" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "*-._")
  assert_eq(params.to_string(), "a=*-._")
}

///|
test "WPT URLSearchParams stringifier #18 - Serialize *-._" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "*-._")
  params.delete("a")
  params.append("*-._", "c")
  assert_eq(params.to_string(), "*-._=c")
}

///|
test "WPT URLSearchParams stringifier #19 - Serialize %" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b%c")
  assert_eq(params.to_string(), "a=b%25c")
}

///|
test "WPT URLSearchParams stringifier #20 - Serialize %" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b%c")
  params.delete("a")
  params.append("a%b", "c")
  assert_eq(params.to_string(), "a%25b=c")
}

///|
test "WPT URLSearchParams stringifier #21 - Serialize \\\\0" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b\u{0000}c")
  assert_eq(params.to_string(), "a=b%00c")
}

///|
test "WPT URLSearchParams stringifier #22 - Serialize \\\\0" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b\u{0000}c")
  params.delete("a")
  params.append("a\u{0000}b", "c")
  assert_eq(params.to_string(), "a%00b=c")
}

///|
test "WPT URLSearchParams stringifier #23 - Serialize \\uD83D\\uDCA9" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b\u{1F4A9}c")
  assert_eq(params.to_string(), "a=b%F0%9F%92%A9c")
}

///|
test "WPT URLSearchParams stringifier #24 - Serialize \\uD83D\\uDCA9" {
  let params = @url.UrlSearchParams::new()
  params.append("a", "b\u{1F4A9}c")
  params.delete("a")
  params.append("a\u{1F4A9}b", "c")
  assert_eq(params.to_string(), "a%F0%9F%92%A9b=c")
}

