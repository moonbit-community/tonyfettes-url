///|
test "typed path snapshots do not retain mutable parser arrays" {
  let source = Url::parse("https://example.com/a/b")
  let snapshot = source.get_path()
  let derived = source.with_query(None)
  source.path.shorten(scheme="https")
  inspect(snapshot.to_string(), content="/a/b")
  inspect(derived.pathname(), content="/a/b")
  derived.path.shorten(scheme="https")
  inspect(source.pathname(), content="/a")
  let installed = source.with_path(snapshot)
  snapshot.shorten(scheme="https")
  inspect(installed.pathname(), content="/a/b")
  let iterator = installed.get_path().segments()
  installed.path.shorten(scheme="https")
  debug_inspect(iterator.map(i => i.to_array()), content="Some([\"a\", \"b\"])")
}

///|
test "host variants are validated and normalized before installation" {
  let source = Url::parse("https://example.com/a")
  inspect(
    source.with_host(Some(Domain("EXAMPLE.ORG"))).hostname(),
    content="example.org",
  )
  inspect(
    source.with_host(Some(Domain("127.1"))).hostname(),
    content="127.0.0.1",
  )
  try source.with_host(Some(Domain("a/b"))) catch {
    InvalidHost => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected invalid domain")
  }
  let other = Url::parse("foo://old/a")
  try other.with_host(Some(Opaque("a:b"))) catch {
    InvalidHost => ()
    _ => fail("unexpected error")
  } noraise {
    _ => fail("expected invalid opaque host")
  }
  inspect(source.hostname(), content="example.com")
  inspect(other.hostname(), content="old")
}

///|
test "new query fragment and params updates strip raw opaque trailing spaces" {
  let source = Url::parse("data:text?q#f")
  source.path = Opaque("text  ")
  inspect(
    source.with_query(None).with_fragment(None).to_string(),
    content="data:text",
  )
  let no_fragment = source.with_fragment(None)
  inspect(
    no_fragment.with_search_params(UrlSearchParams::new()).to_string(),
    content="data:text",
  )
  inspect(source.path.to_string(), content="text  ")
}
