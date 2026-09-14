///|
/// JavaScript-style getters kept for compatibility with releases before
/// 0.4.0. They return the serialized fragments the JavaScript `URL` interface
/// exposes (`protocol` with its colon, `search` with its `?`, `hash` with its
/// `#`, `href` as the whole URL) and are deprecated in favour of the typed
/// getters `scheme`, `query`, `fragment` and `to_string`.

///|
/// Get the full URL as a string (alias for to_string)
#deprecated("Use Url::to_string", skip_current_package=true)
pub fn Url::href(self : Url) -> String {
  self.to_string()
}

///|
/// Get the protocol (scheme + ":")
#deprecated("Use Url::scheme", skip_current_package=true)
pub fn Url::protocol(self : Url) -> String {
  "\{self.scheme}:"
}

///|
/// Get the search (query string with leading "?" if present)
#deprecated("Use Url::query", skip_current_package=true)
pub fn Url::search(self : Url) -> String {
  match self.query {
    Some(query) => if query.is_empty() { "" } else { "?\{query}" }
    None => ""
  }
}

///|
/// Get the hash (fragment with leading "#" if present)
#deprecated("Use Url::fragment", skip_current_package=true)
pub fn Url::hash(self : Url) -> String {
  match self.fragment {
    Some(fragment) => if fragment.is_empty() { "" } else { "#\{fragment}" }
    None => ""
  }
}
