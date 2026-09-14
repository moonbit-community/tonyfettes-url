///|
/// JavaScript-style API kept for compatibility with releases before 0.4.0.
/// Every item in this file is deprecated. The getters return the serialized
/// fragments the JavaScript `URL` interface exposes; the setters mutate the
/// receiver and silently keep the old value when the new one is rejected.
/// Use the typed getters and the immutable `with_*` methods on `Url` instead.

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
/// Set the URL query from UrlSearchParams.
/// This serializes the search params and updates the URL's query.
#deprecated("Use Url::with_search_params", skip_current_package=true)
pub fn Url::set_search_params(self : Url, params : UrlSearchParams) -> Unit {
  let serialized = params.to_string()
  if serialized.is_empty() {
    self.query = None
  } else {
    self.query = Some(serialized)
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

///|
/// Run the basic URL parser with a state override on this URL.
fn Url::parse_with_state(
  self : Url,
  input : StringView,
  state_override : State,
) -> Unit {
  // The JavaScript setters ignore a rejected value and keep the URL as it was.
  ignore(Url::parse_basic(self, input, state_override~)) catch {
    _ => ()
  }
}

///|
/// Set the full URL (re-parse and replace all components).
/// See: https://url.spec.whatwg.org/#dom-url-href
/// The href setter steps are:
/// 1. Let parsedURL be the result of running the basic URL parser on the given value.
/// 2. If parsedURL is failure, then throw a TypeError.
/// 3. Set this's URL to parsedURL.
#deprecated("Use Url::parse", skip_current_package=true)
pub fn Url::set_href(self : Url, href : String) -> Unit raise ValidationError {
  let parsed = parse(href)
  self.scheme = parsed.scheme
  self.username = parsed.username
  self.password = parsed.password
  self.host = parsed.host
  self.port = parsed.port
  self.path = parsed.path
  self.query = parsed.query
  self.fragment = parsed.fragment
}

///|
/// Set the protocol (scheme).
/// See: https://url.spec.whatwg.org/#dom-url-protocol
/// The protocol setter steps are to basic URL parse the given value, followed
/// by U+003A (:), with this's URL as url and scheme start state as state override.
#deprecated("Use Url::with_scheme", skip_current_package=true)
pub fn Url::set_protocol(self : Url, protocol : String) -> Unit {
  let input = "\{protocol}:"
  self.parse_with_state(input[:], SchemeStart)
}

///|
/// Set the username.
/// See: https://url.spec.whatwg.org/#dom-url-username
/// The username setter steps are:
/// 1. If this's URL cannot have a username/password/port, then return.
/// 2. Set the username given this's URL and the given value.
#deprecated("Use Url::with_username", skip_current_package=true)
pub fn Url::set_username(self : Url, username : String) -> Unit {
  // 1. If this's URL cannot have a username/password/port, then return.
  if self.host is None || self.host is Some(Opaque("")) {
    return
  }
  if self.scheme == "file" {
    return
  }
  // 2. Set the username given this's URL and the given value.
  // See: https://url.spec.whatwg.org/#set-the-username
  // Set url's username to the result of running UTF-8 percent-encode on the
  // given value using the userinfo percent-encode set.
  self.username = utf8_percent_encode(username, userinfo_percent_encode_set)
}

///|
/// Set the password.
/// See: https://url.spec.whatwg.org/#dom-url-password
/// The password setter steps are:
/// 1. If this's URL cannot have a username/password/port, then return.
/// 2. Set the password given this's URL and the given value.
#deprecated("Use Url::with_password", skip_current_package=true)
pub fn Url::set_password(self : Url, password : String) -> Unit {
  // 1. If this's URL cannot have a username/password/port, then return.
  if self.host is None || self.host is Some(Opaque("")) {
    return
  }
  if self.scheme == "file" {
    return
  }
  // 2. Set the password given this's URL and the given value.
  // See: https://url.spec.whatwg.org/#set-the-password
  // Set url's password to the result of running UTF-8 percent-encode on the
  // given value using the userinfo percent-encode set.
  self.password = utf8_percent_encode(password, userinfo_percent_encode_set)
}

///|
/// Set the host (hostname and optional port).
/// See: https://url.spec.whatwg.org/#dom-url-host
/// The host setter steps are:
/// 1. If this's URL has an opaque path, then return.
/// 2. Basic URL parse the given value with this's URL as url and host state
///    as state override.
#deprecated("Use Url::with_host", skip_current_package=true)
pub fn Url::set_host(self : Url, host_str : String) -> Unit {
  // 1. If this's URL has an opaque path, then return.
  if self.path is Opaque(_) {
    return
  }
  // 2. Basic URL parse the given value with this's URL as url and host state
  //    as state override.
  self.parse_with_state(host_str[:], Host)
}

///|
/// Set the hostname (without port).
/// See: https://url.spec.whatwg.org/#dom-url-hostname
/// The hostname setter steps are:
/// 1. If this's URL has an opaque path, then return.
/// 2. Basic URL parse the given value with this's URL as url and hostname state
///    as state override.
#deprecated("Use Url::with_host", skip_current_package=true)
pub fn Url::set_hostname(self : Url, hostname : String) -> Unit {
  // 1. If this's URL has an opaque path, then return.
  if self.path is Opaque(_) {
    return
  }
  // 2. Basic URL parse the given value with this's URL as url and hostname state
  //    as state override.
  self.parse_with_state(hostname[:], Hostname)
}

///|
/// Set the port.
/// See: https://url.spec.whatwg.org/#dom-url-port
/// The port setter steps are:
/// 1. If this's URL cannot have a username/password/port, then return.
/// 2. If the given value is the empty string, then set this's URL's port to null.
/// 3. Otherwise, basic URL parse the given value with this's URL as url and
///    port state as state override.
#deprecated("Use Url::with_port", skip_current_package=true)
pub fn Url::set_port(self : Url, port_str : String) -> Unit {
  // 1. If this's URL cannot have a username/password/port, then return.
  if has_empty_host(self.host) || self.path is Opaque(_) {
    return
  }
  if self.scheme == "file" {
    return
  }
  // 2. If the given value is the empty string, then set this's URL's port to null.
  if port_str.is_empty() {
    self.port = None
    return
  }
  // 3. Otherwise, basic URL parse the given value with this's URL as url and
  //    port state as state override.
  self.parse_with_state(port_str[:], Port)
}

///|
/// Set the pathname.
/// See: https://url.spec.whatwg.org/#dom-url-pathname
/// The pathname setter steps are:
/// 1. If this's URL has an opaque path, then return.
/// 2. Empty this's URL's path.
/// 3. Basic URL parse the given value with this's URL as url and path start
///    state as state override.
#deprecated("Use Url::with_pathname", skip_current_package=true)
pub fn Url::set_pathname(self : Url, pathname : String) -> Unit {
  // 1. If this's URL has an opaque path, then return.
  if self.path is Opaque(_) {
    return
  }
  // 2. Empty this's URL's path.
  // 3. Basic URL parse the given value with this's URL as url and path start
  //    state as state override.
  self.reparse_pathname(pathname)
}

///|
/// Set the search (query string).
/// See: https://url.spec.whatwg.org/#dom-url-search
/// The search setter steps are:
/// 1. If the given value is the empty string, set this's URL's query to null.
/// 2. Otherwise:
///    2.1. Let input be the given value with a single leading U+003F (?) removed, if any.
///    2.2. Set this's URL's query to the empty string.
///    2.3. Basic URL parse input with this's URL as url and query state as
///         state override.
#deprecated("Use Url::with_query", skip_current_package=true)
pub fn Url::set_search(self : Url, search : String) -> Unit {
  let cleaned = remove_ascii_tab_or_newline(search[:])
  // 1. If the given value is the empty string, set this's URL's query to null.
  if cleaned.is_empty() {
    self.query = None
    return
  }
  // 2.1. Let input be the given value with a single leading U+003F (?) removed, if any.
  let query = match cleaned[:] {
    ['?', .. rest] => rest
    _ => cleaned[:]
  }
  // 2.2. Set this's URL's query to the empty string.
  self.query = Some("")
  // 2.3. Basic URL parse input with this's URL as url and query state as state override.
  self.parse_with_state(query, Query)
}

///|
/// Set the hash (fragment).
/// See: https://url.spec.whatwg.org/#dom-url-hash
/// The hash setter steps are:
/// 1. If the given value is the empty string, then set this's URL's fragment to null.
/// 2. Otherwise:
///    2.1. Let input be the given value with a single leading U+0023 (#) removed, if any.
///    2.2. Set this's URL's fragment to the empty string.
///    2.3. Basic URL parse input with this's URL as url and fragment state as
///         state override.
#deprecated("Use Url::with_fragment", skip_current_package=true)
pub fn Url::set_hash(self : Url, hash : String) -> Unit {
  let cleaned = remove_ascii_tab_or_newline(hash[:])
  // 1. If the given value is the empty string, then set this's URL's fragment to null.
  if cleaned.is_empty() {
    self.fragment = None
    return
  }
  // 2.1. Let input be the given value with a single leading U+0023 (#) removed, if any.
  let fragment = match cleaned[:] {
    ['#', .. rest] => rest
    _ => cleaned[:]
  }
  // 2.2. Set this's URL's fragment to the empty string.
  self.fragment = Some("")
  // 2.3. Basic URL parse input with this's URL as url and fragment state as
  //      state override.
  self.parse_with_state(fragment, Fragment)
}
