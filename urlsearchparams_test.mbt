///|
test "UrlSearchParams::new creates empty params" {
  let params = UrlSearchParams::new()
  assert_eq(params.size(), 0)
  assert_eq(params.to_string(), "")
}

///|
test "UrlSearchParams::from_string basic parsing" {
  let params = UrlSearchParams::from_string("foo=bar&baz=qux")
  assert_eq(params.size(), 2)
  assert_eq(params.get("foo"), Some("bar"))
  assert_eq(params.get("baz"), Some("qux"))
}

///|
test "UrlSearchParams::from_string strips leading ?" {
  let params = UrlSearchParams::from_string("?foo=bar")
  assert_eq(params.size(), 1)
  assert_eq(params.get("foo"), Some("bar"))
}

///|
test "UrlSearchParams::from_string percent-decoding" {
  let params = UrlSearchParams::from_string("foo=hello%20world")
  assert_eq(params.get("foo"), Some("hello world"))
}

///|
test "UrlSearchParams::from_string plus as space" {
  let params = UrlSearchParams::from_string("foo=hello+world")
  assert_eq(params.get("foo"), Some("hello world"))
}

///|
test "UrlSearchParams::from_string unicode" {
  // %E4%B8%AD%E6%96%87 is UTF-8 encoding of "中文"
  let params = UrlSearchParams::from_string("key=%E4%B8%AD%E6%96%87")
  assert_eq(params.get("key"), Some("中文"))
}

///|
test "UrlSearchParams::from_string empty values" {
  let params = UrlSearchParams::from_string("foo=&bar")
  assert_eq(params.size(), 2)
  assert_eq(params.get("foo"), Some(""))
  assert_eq(params.get("bar"), Some(""))
}

///|
test "UrlSearchParams::from_string multiple same-name params" {
  let params = UrlSearchParams::from_string("a=1&a=2&a=3")
  assert_eq(params.size(), 3)
  assert_eq(params.get("a"), Some("1"))
  assert_eq(params.get_all("a"), ["1", "2", "3"])
}

///|
test "UrlSearchParams::from_pairs" {
  let params = UrlSearchParams::from_pairs([("foo", "bar"), ("baz", "qux")])
  assert_eq(params.size(), 2)
  assert_eq(params.get("foo"), Some("bar"))
  assert_eq(params.get("baz"), Some("qux"))
}

///|
test "UrlSearchParams::to_string serialization" {
  let params = UrlSearchParams::from_pairs([("foo", "bar"), ("baz", "qux")])
  assert_eq(params.to_string(), "foo=bar&baz=qux")
}

///|
test "UrlSearchParams::to_string encoding" {
  let params = UrlSearchParams::from_pairs([("key", "hello world")])
  assert_eq(params.to_string(), "key=hello+world")
}

///|
test "UrlSearchParams::to_string unicode encoding" {
  let params = UrlSearchParams::from_pairs([("key", "中文")])
  assert_eq(params.to_string(), "key=%E4%B8%AD%E6%96%87")
}

///|
test "UrlSearchParams::append" {
  let params = UrlSearchParams::new()
  params.append("foo", "bar")
  params.append("baz", "qux")
  assert_eq(params.size(), 2)
  assert_eq(params.to_string(), "foo=bar&baz=qux")
}

///|
test "UrlSearchParams::delete without value" {
  let params = UrlSearchParams::from_string("a=1&b=2&a=3")
  params.delete("a")
  assert_eq(params.size(), 1)
  assert_eq(params.get("a"), None)
  assert_eq(params.get("b"), Some("2"))
}

///|
test "UrlSearchParams::delete with value filter" {
  let params = UrlSearchParams::from_string("a=1&a=2&a=3")
  params.delete("a", value="2")
  assert_eq(params.size(), 2)
  assert_eq(params.get_all("a"), ["1", "3"])
}

///|
test "UrlSearchParams::get returns first value" {
  let params = UrlSearchParams::from_string("a=first&a=second")
  assert_eq(params.get("a"), Some("first"))
}

///|
test "UrlSearchParams::get returns None for missing" {
  let params = UrlSearchParams::from_string("a=1")
  assert_eq(params.get("b"), None)
}

///|
test "UrlSearchParams::get_all returns all values" {
  let params = UrlSearchParams::from_string("a=1&b=2&a=3")
  assert_eq(params.get_all("a"), ["1", "3"])
  assert_eq(params.get_all("b"), ["2"])
  assert_eq(params.get_all("c"), [])
}

///|
test "UrlSearchParams::has without value" {
  let params = UrlSearchParams::from_string("a=1&b=2")
  assert_true(params.has("a"))
  assert_true(params.has("b"))
  assert_false(params.has("c"))
}

///|
test "UrlSearchParams::has with value" {
  let params = UrlSearchParams::from_string("a=1&a=2")
  assert_true(params.has("a", value="1"))
  assert_true(params.has("a", value="2"))
  assert_false(params.has("a", value="3"))
}

///|
test "UrlSearchParams::set replaces existing" {
  let params = UrlSearchParams::from_string("a=1&b=2&a=3")
  params.set("a", "new")
  assert_eq(params.size(), 2)
  assert_eq(params.get("a"), Some("new"))
  assert_eq(params.get_all("a"), ["new"])
}

///|
test "UrlSearchParams::set appends if not found" {
  let params = UrlSearchParams::from_string("a=1")
  params.set("b", "2")
  assert_eq(params.size(), 2)
  assert_eq(params.get("b"), Some("2"))
}

///|
test "UrlSearchParams::sort" {
  let params = UrlSearchParams::from_string("c=1&a=2&b=3&a=4")
  params.sort()
  assert_eq(params.to_string(), "a=2&a=4&b=3&c=1")
}

///|
test "UrlSearchParams::sort stability" {
  // Sort should be stable - equal keys maintain original order
  let params = UrlSearchParams::from_string("a=first&b=1&a=second&a=third")
  params.sort()
  assert_eq(params.get_all("a"), ["first", "second", "third"])
}

///|
test "UrlSearchParams::iter" {
  let params = UrlSearchParams::from_string("a=1&b=2")
  let pairs = params.iter().collect()
  assert_eq(pairs, [("a", "1"), ("b", "2")])
}

///|
test "UrlSearchParams::entries" {
  let params = UrlSearchParams::from_string("a=1&b=2")
  let pairs = params.entries().collect()
  assert_eq(pairs, [("a", "1"), ("b", "2")])
}

///|
test "UrlSearchParams::keys" {
  let params = UrlSearchParams::from_string("a=1&b=2&a=3")
  let keys = params.keys().collect()
  assert_eq(keys, ["a", "b", "a"])
}

///|
test "UrlSearchParams::values" {
  let params = UrlSearchParams::from_string("a=1&b=2&a=3")
  let values = params.values().collect()
  assert_eq(values, ["1", "2", "3"])
}

///|
test "UrlSearchParams Show trait" {
  let params = UrlSearchParams::from_string("foo=bar&baz=qux")
  inspect(params, content="foo=bar&baz=qux")
}

///|
test "UrlSearchParams ToJson trait" {
  let params = UrlSearchParams::from_string("foo=bar")
  inspect(params.to_json(), content="String(\"foo=bar\")")
}

///|
test "UrlSearchParams roundtrip" {
  // Parse, serialize, parse again - should be equivalent
  let original = "a=1&b=hello+world&c=%E4%B8%AD%E6%96%87"
  let params1 = UrlSearchParams::from_string(original)
  let serialized = params1.to_string()
  let params2 = UrlSearchParams::from_string(serialized)
  assert_eq(params1.get("a"), params2.get("a"))
  assert_eq(params1.get("b"), params2.get("b"))
  assert_eq(params1.get("c"), params2.get("c"))
}

///|
test "UrlSearchParams empty input" {
  let params = UrlSearchParams::from_string("")
  assert_eq(params.size(), 0)
  assert_eq(params.to_string(), "")
}

///|
test "UrlSearchParams only question mark" {
  let params = UrlSearchParams::from_string("?")
  assert_eq(params.size(), 0)
}

///|
test "UrlSearchParams special characters encoding" {
  let params = UrlSearchParams::from_pairs([("key", "a=b&c=d")])
  // = and & should be percent-encoded in values
  assert_eq(params.to_string(), "key=a%3Db%26c%3Dd")
}

///|
test "UrlSearchParams name encoding" {
  let params = UrlSearchParams::from_pairs([("a=b", "value")])
  // = should be percent-encoded in names too
  assert_eq(params.to_string(), "a%3Db=value")
}

///|
test "Url::search_params" {
  let url = Url::parse("https://example.com/path?foo=bar&baz=qux")
  let params = url.search_params()
  assert_eq(params.size(), 2)
  assert_eq(params.get("foo"), Some("bar"))
  assert_eq(params.get("baz"), Some("qux"))
}

///|
test "Url::search_params with empty query" {
  let url = Url::parse("https://example.com/path")
  let params = url.search_params()
  assert_eq(params.size(), 0)
}

///|
test "Url::set_search_params" {
  let url = Url::parse("https://example.com/path")
  let params = UrlSearchParams::new()
  params.append("foo", "bar")
  params.append("baz", "qux")
  url.set_search_params(params)
  assert_eq(url.search(), "?foo=bar&baz=qux")
}

///|
test "Url::set_search_params empty clears query" {
  let url = Url::parse("https://example.com/path?foo=bar")
  url.set_search_params(UrlSearchParams::new())
  assert_eq(url.search(), "")
}

///|
test "Url search_params roundtrip" {
  let url = Url::parse("https://example.com/path?a=1&b=hello%20world")
  let params = url.search_params()
  // Modify the params
  params.set("a", "modified")
  params.append("c", "new")
  url.set_search_params(params)
  // Verify the URL was updated
  let new_params = url.search_params()
  assert_eq(new_params.get("a"), Some("modified"))
  assert_eq(new_params.get("b"), Some("hello world"))
  assert_eq(new_params.get("c"), Some("new"))
}
