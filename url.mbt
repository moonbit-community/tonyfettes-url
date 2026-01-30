///|
/// Represents a parsed URL per the WHATWG URL Standard.
/// See: https://url.spec.whatwg.org/#url-representation
/// Contains scheme, credentials (username/password), host, port, path, query, and fragment.
pub struct Url {
  mut scheme : String
  mut username : String
  mut password : String
  mut host : Host?
  mut port : UInt16?
  mut path : Path
  mut query : String?
  mut fragment : String?
}

///|
/// Create a new empty URL
fn Url::new() -> Url {
  Url::{
    scheme: "",
    username: "",
    password: "",
    host: None,
    port: None,
    path: Segments([]),
    query: None,
    fragment: None,
  }
}

///|
/// Parse a URL string, optionally with a base URL for relative resolution
#as_free_fn
pub fn Url::try_parse(
  input : StringView,
  base? : Url,
  validation_errors? : Array[ValidationError],
) -> Url? {
  let url = Url::new()
  Url::parse_basic(url, input, base?, validation_errors?)
}

///|
pub suberror ValidationErrors {
  ValidationErrors(Array[ValidationError])
}

///|
#as_free_fn
pub fn Url::parse(
  input : StringView,
  base? : Url,
) -> Url raise ValidationErrors {
  let validation_errors = []
  match Url::try_parse(input, base?, validation_errors~) {
    Some(url) => url
    None => raise ValidationErrors(validation_errors)
  }
}

///|
/// Serialize URL to string per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#url-serializing
pub fn Url::to_string(self : Url) -> String {
  let result = StringBuilder::new()
  // 1. Let output be url's scheme and U+003A (:) concatenated.
  result.write_string(self.scheme)
  result.write_char(':')
  // 2. If url's host is non-null:
  match self.host {
    Some(host) => {
      // 2.1. Append "//" to output.
      result.write_string("//")
      // 2.2. If url includes credentials, then:
      if !self.username.is_empty() || !self.password.is_empty() {
        // 2.2.1. Append url's username to output.
        result.write_string(self.username)
        // 2.2.2. If url's password is not the empty string, then append U+003A (:),
        //        followed by url's password, to output.
        if !self.password.is_empty() {
          result.write_char(':')
          result.write_string(self.password)
        }
        // 2.2.3. Append U+0040 (@) to output.
        result.write_char('@')
      }
      // 2.3. Append url's host, serialized, to output.
      result.write_string(host.to_string())
      // 2.4. If url's port is non-null, append U+003A (:) followed by url's port,
      //      serialized, to output.
      match self.port {
        Some(port) => {
          result.write_char(':')
          result.write_string(port.to_string())
        }
        None => ()
      }
    }
    None =>
      // 3. If url's host is null, url does not have an opaque path, url's path's
      //    size is greater than 1, and url's path[0] is the empty string, then
      //    append U+002F (/) and U+002E (.) to output.
      //    (handled below in path serialization)
      // For file scheme without host, still include //
      if self.scheme == "file" {
        result.write_string("//")
      }
  }
  // 4. If url has an opaque path, then append url's path to output.
  // 5. Otherwise, then for each string in url's path, append U+002F (/) followed
  //    by the string to output.
  match self.path {
    Opaque(path) => result.write_string(path)
    Segments(segments) =>
      if segments.is_empty() && self.host is Some(_) && self.is_special() {
        result.write_char('/')
      } else {
        // 3. (continued) If url's host is null, url does not have an opaque path,
        //    url's path's size is greater than 1, and url's path[0] is the empty
        //    string, then append U+002F (/) and U+002E (.) to output.
        if self.host is None && segments.length() > 1 {
          match segments[0] {
            "" => result.write_string("/.")
            _ => ()
          }
        }
        for segment in segments {
          result.write_char('/')
          result.write_string(segment)
        }
      }
  }
  // 6. If url's query is non-null, append U+003F (?), followed by url's query,
  //    to output.
  match self.query {
    Some(query) => {
      result.write_char('?')
      result.write_string(query)
    }
    None => ()
  }
  // 7. If exclude fragment is false and url's fragment is non-null, then append
  //    U+0023 (#), followed by url's fragment, to output.
  match self.fragment {
    Some(fragment) => {
      result.write_char('#')
      result.write_string(fragment)
    }
    None => ()
  }
  // 8. Return output.
  result.to_string()
}

///|
/// Get the full URL as a string (alias for to_string)
pub fn Url::href(self : Url) -> String {
  self.to_string()
}

///|
/// Get the protocol (scheme + ":")
pub fn Url::protocol(self : Url) -> String {
  "\{self.scheme}:"
}

///|
/// Get the username
pub fn Url::username(self : Url) -> String {
  self.username
}

///|
/// Get the password
pub fn Url::password(self : Url) -> String {
  self.password
}

///|
/// Get the host (hostname + ":" + port if port is present)
pub fn Url::host(self : Url) -> String {
  match self.host {
    Some(host) => {
      let hostname = host.to_string()
      match self.port {
        Some(port) => "\{hostname}:\{port}"
        None => hostname
      }
    }
    None => ""
  }
}

///|
/// Get the hostname (serialized host without port)
pub fn Url::hostname(self : Url) -> String {
  match self.host {
    Some(host) => host.to_string()
    None => ""
  }
}

///|
/// Get the port as a string (empty string if no port or default port)
pub fn Url::port(self : Url) -> String {
  match self.port {
    Some(port) => port.to_string()
    None => ""
  }
}

///|
/// Get the pathname (serialized path)
pub fn Url::pathname(self : Url) -> String {
  self.path.to_string()
}

///|
/// Get the search (query string with leading "?" if present)
pub fn Url::search(self : Url) -> String {
  match self.query {
    Some(query) => if query.is_empty() { "" } else { "?\{query}" }
    None => ""
  }
}

///|
/// Get the hash (fragment with leading "#" if present)
pub fn Url::hash(self : Url) -> String {
  match self.fragment {
    Some(fragment) => if fragment.is_empty() { "" } else { "#\{fragment}" }
    None => ""
  }
}

///|
/// Get the origin (scheme + "://" + host + ":" + port for special schemes)
pub fn Url::origin(self : Url) -> String {
  if !is_special_scheme(self.scheme) {
    return "null"
  }
  if self.scheme == "file" {
    return "null"
  }
  match self.host {
    Some(host) => {
      let hostname = host.to_string()
      match self.port {
        Some(port) => "\{self.scheme}://\{hostname}:\{port}"
        None => "\{self.scheme}://\{hostname}"
      }
    }
    None => "null"
  }
}

///|
/// Get the default port for a scheme
fn default_port(scheme : StringView) -> UInt16? {
  match scheme {
    "ftp" => Some(21)
    "http" | "ws" => Some(80)
    "https" | "wss" => Some(443)
    _ => None
  }
}

///|
/// Run the basic URL parser with a state override on this URL.
fn Url::parse_with_state(
  self : Url,
  input : StringView,
  state_override : State,
) -> Unit {
  ignore(Url::parse_basic(self, input, state_override~))
}

///|
/// Set the full URL (re-parse and replace all components).
/// See: https://url.spec.whatwg.org/#dom-url-href
/// The href setter steps are:
/// 1. Let parsedURL be the result of running the basic URL parser on the given value.
/// 2. If parsedURL is failure, then throw a TypeError.
/// 3. Set this's URL to parsedURL.
pub fn Url::set_href(self : Url, href : String) -> Unit raise ValidationErrors {
  let parsed = Url::parse(href)
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
pub fn Url::set_pathname(self : Url, pathname : String) -> Unit {
  // 1. If this's URL has an opaque path, then return.
  if self.path is Opaque(_) {
    return
  }
  let cleaned = remove_ascii_tab_or_newline(pathname[:])
  if cleaned.is_empty() {
    if self.is_special() || self.host is None {
      self.path = Segments([""])
    } else {
      self.path = Segments([])
    }
    return
  }
  // 2. Empty this's URL's path.
  self.path = Segments([])
  // 3. Basic URL parse the given value with this's URL as url and path start
  //    state as state override.
  self.parse_with_state(cleaned[:], PathStart)
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

///|
/// Implement Show trait for Url, outputting the serialized URL string
pub impl Show for Url with output(self : Url, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}

///|
/// Remove all ASCII tab (0x09), LF (0x0A), and CR (0x0D) from the entire input
fn remove_ascii_tab_or_newline(input : StringView) -> String {
  let output = StringBuilder::new()
  for c in input {
    if !(c is ('\t' | '\n' | '\r')) {
      output.write_char(c)
    }
  }
  output.to_string()
}

///|
fn has_empty_host(host : Host?) -> Bool {
  match host {
    None => true
    Some(Opaque("")) => true
    _ => false
  }
}

///|
/// Encode only the LAST trailing space as %20 for opaque paths before query/fragment
fn encode_last_trailing_space(s : String) -> String {
  // Check if the string ends with a space
  let len = s.length()
  if len == 0 {
    return s
  }
  match s.get_char(len - 1) {
    Some(' ') => {
      // Replace only the last space with %20
      let result = StringBuilder::new()
      for i, c in s {
        if i == len - 1 {
          result.write_string("%20")
        } else {
          result.write_char(c)
        }
      }
      result.to_string()
    }
    _ => s // No trailing space
  }
}

///|
/// Trim leading and trailing C0 control (U+0000-U+001F) or space (U+0020) from input
fn trim_c0_control_or_space(input : StringView) -> StringView {
  // Trim from start
  let input = loop input {
    ['\u{0000}'..='\u{0020}', .. rest] => continue rest
    input => break input
  }
  // Trim from end
  let input = loop input {
    [.. rest, '\u{0000}'..='\u{0020}'] => continue rest
    input => break input
  }
  input
}

///|
fn Url::is_special(url : Url) -> Bool {
  is_special_scheme(url.scheme)
}

///|
fn is_special_scheme(scheme : StringView) -> Bool {
  match scheme {
    "ftp" | "file" | "http" | "https" | "ws" | "wss" => true
    _ => false
  }
}

///|
/// Check if a path segment is a single-dot URL path segment per WHATWG spec
/// A single-dot URL path segment is "." or an ASCII case-insensitive match for "%2e"
fn is_single_dot_path_segment(segment : String) -> Bool {
  segment == "." || segment.to_lower() == "%2e"
}

///|
/// Check if a path segment is a double-dot URL path segment per WHATWG spec
/// A double-dot URL path segment is ".." or an ASCII case-insensitive match for ".%2e", "%2e.", or "%2e%2e"
fn is_double_dot_path_segment(segment : String) -> Bool {
  segment == ".." || segment.to_lower() is (".%2e" | "%2e." | "%2e%2e")
}

///|
/// Parser states per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#concept-basic-url-parser
priv enum State {
  /// https://url.spec.whatwg.org/#scheme-start-state
  SchemeStart
  /// https://url.spec.whatwg.org/#scheme-state
  Scheme
  /// https://url.spec.whatwg.org/#no-scheme-state
  NoScheme
  /// https://url.spec.whatwg.org/#file-state
  File
  /// https://url.spec.whatwg.org/#file-slash-state
  FileSlash
  /// https://url.spec.whatwg.org/#file-host-state
  FileHost
  /// https://url.spec.whatwg.org/#relative-state
  Relative
  /// https://url.spec.whatwg.org/#relative-slash-state
  RelativeSlash
  /// https://url.spec.whatwg.org/#special-relative-or-authority-state
  SpecialRelativeOrAuthority
  /// https://url.spec.whatwg.org/#special-authority-ignore-slashes-state
  SpecialAuthorityIgnoreSlashes
  /// https://url.spec.whatwg.org/#special-authority-slashes-state
  SpecialAuthoritySlashes
  /// https://url.spec.whatwg.org/#path-or-authority-state
  PathOrAuthority
  /// https://url.spec.whatwg.org/#authority-state
  Authority
  /// https://url.spec.whatwg.org/#host-state
  Host
  /// https://url.spec.whatwg.org/#hostname-state
  Hostname
  /// https://url.spec.whatwg.org/#port-state
  Port
  /// https://url.spec.whatwg.org/#path-start-state
  PathStart
  /// https://url.spec.whatwg.org/#path-state
  Path
  /// https://url.spec.whatwg.org/#opaque-path-state
  OpaquePath
  /// https://url.spec.whatwg.org/#query-state
  Query
  /// https://url.spec.whatwg.org/#fragment-state
  Fragment
}

///|
priv struct StringPointer {
  input : StringView
  mut pointer : Int
}

///|
fn StringPointer::new(input : StringView) -> StringPointer {
  StringPointer::{ input, pointer: input.start_offset() }
}

///|
fn StringPointer::view(self : StringPointer) -> StringView {
  self.input.data().view(start_offset=self.pointer)
}

///|
fn StringPointer::next(self : StringPointer) -> StringView {
  match self.view() {
    [] as view => view
    [_, .. rest] => {
      self.pointer = rest.start_offset()
      rest
    }
  }
}

///|
fn StringPointer::increase(self : StringPointer) -> Unit {
  match self.view() {
    [] => ()
    [_, .. rest] => self.pointer = rest.start_offset()
  }
}

///|
fn StringPointer::decrease(self : StringPointer) -> Unit {
  // Get the StringView from start of input up to (but not including) current pointer
  let before = self.input.data().view(end_offset=self.pointer)
  match before {
    [] => () // Already at the start, do nothing
    [_] => self.pointer = before.start_offset() // One char, move to its start
    _ => {
      // Multiple chars, iterate to find the start of the last char
      let mut current_offset = before.start_offset()
      for view = before {
        match view {
          [_] => {
            self.pointer = current_offset
            break
          }
          [_, .. rest] => {
            current_offset = rest.start_offset()
            continue rest
          }
          [] => break // Shouldn't reach here
        }
      }
    }
  }
}

///|
fn StringPointer::start_over(self : StringPointer) -> Unit {
  self.pointer = self.input.start_offset()
}

///|
/// Basic URL parser per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#concept-basic-url-parser
fn Url::parse_basic(
  url : Url,
  base? : Url,
  input : StringView,
  state_override? : State,
  validation_errors? : Array[ValidationError] = [],
) -> Url? {
  let has_state_override = state_override is Some(_)
  // 2. If state override is not given, set state to scheme start state.
  let mut state : State = match state_override {
    Some(override_state) => override_state
    None => SchemeStart
  }
  // Special case: file URLs with host/hostname state override use FileHost
  if has_state_override &&
    url.scheme == "file" &&
    (state is Host || state is Hostname) {
    state = FileHost
  }
  // 3. Let buffer be the empty string.
  let buffer : StringBuilder = StringBuilder::new()
  // 4. Let atSignSeen, insideBrackets, and passwordTokenSeen be false.
  let mut at_sign_seen : Bool = false
  let mut inside_brackets : Bool = false
  let mut password_token_seen : Bool = false
  // 1. If input contains any ASCII tab or newline, validation error.
  //    (Note: We also remove leading/trailing C0 control or space per step 1)
  // Per WHATWG: 1. Remove leading/trailing C0 control or space
  //             2. Remove all ASCII tab or newline from entire input
  let input = if has_state_override {
    input
  } else {
    trim_c0_control_or_space(input)
  }
  let input = remove_ascii_tab_or_newline(input)
  // Handle empty input per WHATWG spec (only for full parse)
  if input.is_empty() && !has_state_override {
    match base {
      Some(base) => {
        url.scheme = base.scheme
        url.username = base.username
        url.password = base.password
        url.host = base.host
        url.port = base.port
        url.path = base.path.clone()
        url.query = base.query
        // fragment is NOT copied per WHATWG spec
        return Some(url)
      }
      None => {
        validation_errors.push(MissingSchemeNonRelativeUrl)
        return None
      }
    }
  }
  let pointer = StringPointer::new(input[:])
  // Outer loop for restart mechanism (WHATWG "start over")
  while true {
    for view = pointer.view(); ; view = pointer.next() {
      guard view is [c, .. remaining] else { break }
      match state {
        // Scheme start state (https://url.spec.whatwg.org/#scheme-start-state)
        // 1. If c is an ASCII alpha, append c, lowercased, to buffer, and set
        //    state to scheme state.
        // 2. Otherwise, if state override is not given, set state to no scheme
        //    state and decrease pointer by 1.
        // 3. Otherwise, return failure.
        SchemeStart =>
          if c.is_ascii_alphabetic() {
            buffer.write_char(c.to_ascii_lowercase())
            state = Scheme
          } else if !has_state_override {
            state = NoScheme
            continue view // Re-process same character in NoScheme
          } else {
            return None
          }
        // Scheme state (https://url.spec.whatwg.org/#scheme-state)
        // 1. If c is an ASCII alphanumeric, U+002B (+), U+002D (-), or U+002E (.),
        //    append c, lowercased, to buffer.
        // 2. Otherwise, if c is U+003A (:), then: [complex logic follows]
        // 3. Otherwise, if state override is not given, set buffer to empty,
        //    state to no scheme state, and start over.
        // 4. Otherwise, return failure.
        Scheme =>
          match c {
            'a'..='z' | 'A'..='Z' | '0'..='9' | '+' | '-' | '.' =>
              buffer.write_char(c.to_ascii_lowercase())
            ':' => {
              let next_scheme = buffer.to_string()
              if has_state_override {
                let url_special = url.is_special()
                let next_special = is_special_scheme(next_scheme)
                if url_special && !next_special {
                  return Some(url)
                }
                if !url_special && next_special {
                  return Some(url)
                }
                if (
                    !url.username.is_empty() ||
                    !url.password.is_empty() ||
                    url.port is Some(_)
                  ) &&
                  next_scheme == "file" {
                  return Some(url)
                }
                if url.scheme == "file" && has_empty_host(url.host) {
                  return Some(url)
                }
              }
              url.scheme = next_scheme
              buffer.reset()
              if has_state_override {
                match url.port {
                  Some(port) =>
                    if default_port(url.scheme) is Some(default) &&
                      port == default {
                      url.port = None
                    }
                  None => ()
                }
                return Some(url)
              }
              if url.scheme is "file" {
                if remaining.has_prefix("//") {
                  validation_errors.push(SpecialSchemeMissingFollowingSolidus)
                }
                state = File
              } else if is_special_scheme(url.scheme) &&
                base is Some(base) &&
                base.scheme == url.scheme {
                guard is_special_scheme(base.scheme) else {
                  abort("is_special_scheme(base.scheme) must be true")
                }
                state = SpecialRelativeOrAuthority
              } else if is_special_scheme(url.scheme) {
                state = SpecialAuthoritySlashes
              } else if remaining is ['/', ..] {
                state = PathOrAuthority
                pointer.increase()
              } else {
                url.path = Opaque("")
                state = OpaquePath
              }
            }
            _ =>
              if has_state_override {
                return None
              } else {
                buffer.reset()
                state = NoScheme
                pointer.start_over()
                continue pointer.view()
              }
          }
        // No scheme state (https://url.spec.whatwg.org/#no-scheme-state)
        // 1. If base is null, or base has an opaque path and c is not U+0023 (#),
        //    missing-scheme-non-relative-URL validation error, return failure.
        // 2. Otherwise, if base has an opaque path and c is U+0023 (#), set url's
        //    scheme/path/query from base, set url's fragment to empty, set state
        //    to fragment state.
        // 3. Otherwise, if base's scheme is not "file", set state to relative state
        //    and decrease pointer by 1.
        // 4. Otherwise, set state to file state and decrease pointer by 1.
        NoScheme =>
          match base {
            None => {
              // 1. Base is null
              validation_errors.push(MissingSchemeNonRelativeUrl)
              return None
            }
            Some({ path: Opaque(_), .. }) if !(c is '#') => {
              // 1. Base has opaque path and c is not #
              validation_errors.push(MissingSchemeNonRelativeUrl)
              return None
            }
            Some({ path: Opaque(_), .. } as base) if c is '#' => {
              // 2. Base has opaque path and c is #
              url.scheme = base.scheme
              url.path = base.path.clone()
              url.query = base.query
              url.fragment = Some("")
              state = Fragment
            }
            Some({ scheme, .. }) if scheme != "file" => {
              // 3. Base's scheme is not "file"
              state = Relative
              continue view // Re-process same character in Relative
            }
            _ => {
              // 4. Base's scheme is "file"
              state = File
              continue view // Re-process same character in File
            }
          }
        // Special relative or authority state
        // (https://url.spec.whatwg.org/#special-relative-or-authority-state)
        // 1. If c is U+002F (/) and remaining starts with U+002F (/), then set
        //    state to special authority ignore slashes state and increase pointer by 1.
        // 2. Otherwise, special-scheme-missing-following-solidus validation error,
        //    set state to relative state and decrease pointer by 1.
        SpecialRelativeOrAuthority =>
          if c is '/' && remaining.has_prefix("/") {
            state = SpecialAuthorityIgnoreSlashes
            pointer.increase()
          } else {
            validation_errors.push(SpecialSchemeMissingFollowingSolidus)
            state = Relative
            continue view // Re-process same character in Relative
          }
        // Path or authority state (https://url.spec.whatwg.org/#path-or-authority-state)
        // 1. If c is U+002F (/), then set state to authority state.
        // 2. Otherwise, set state to path state, and decrease pointer by 1.
        PathOrAuthority =>
          if c is '/' {
            state = Authority
          } else {
            state = Path
            continue view // Re-process same character in Path
          }
        // Relative state (https://url.spec.whatwg.org/#relative-state)
        Relative => {
          guard base is Some(base) else {
            abort("base must be Some(base) in Relative state")
          }
          guard base.scheme != "file" else {
            abort("base.scheme must not be \"file\" in Relative state")
          }
          url.scheme = base.scheme
          if c is '/' {
            state = RelativeSlash
          } else if url.is_special() && c is '\\' {
            validation_errors.push(InvalidReverseSolidus)
            state = RelativeSlash
          } else {
            url.username = base.username
            url.password = base.password
            url.host = base.host
            url.port = base.port
            url.path = base.path.clone()
            url.query = base.query
            if c is '?' {
              url.query = Some("")
              state = Query
            } else if c is '#' {
              url.fragment = Some("")
              state = Fragment
            } else {
              url.query = None
              url.path.shorten(scheme=url.scheme)
              state = Path
              continue view // Re-process same character in Path
            }
          }
        }
        // Relative slash state (https://url.spec.whatwg.org/#relative-slash-state)
        RelativeSlash => {
          guard base is Some(base) else {
            abort("base must be Some(base) in RelativeSlash state")
          }
          // 1. If url is special and c is U+002F (/) or U+005C (\), then:
          if url.is_special() && c is ('/' | '\\') {
            // 1.1. If c is U+005C (\), invalid-reverse-solidus validation error.
            if c is '/' {
              validation_errors.push(InvalidReverseSolidus)
            }
            // 1.2. Set state to special authority ignore slashes state.
            state = SpecialAuthorityIgnoreSlashes
          } else if c is '/' {
            // 2. Otherwise, if c is U+002F (/), then set state to authority state.
            state = Authority
          } else {
            // 3. Otherwise, set url's username/password/host/port from base,
            //    state to path state, and decrease pointer by 1.
            url.username = base.username
            url.password = base.password
            url.host = base.host
            url.port = base.port
            state = Path
            continue view // Re-process same character in Path
          }
        }
        // Special authority slashes state
        // (https://url.spec.whatwg.org/#special-authority-slashes-state)
        // 1. If c is U+002F (/) and remaining starts with U+002F (/), then set
        //    state to special authority ignore slashes state and increase pointer by 1.
        // 2. Otherwise, special-scheme-missing-following-solidus validation error,
        //    set state to special authority ignore slashes state and decrease pointer by 1.
        SpecialAuthoritySlashes =>
          if c is '/' && remaining.has_prefix("/") {
            state = SpecialAuthorityIgnoreSlashes
            pointer.increase()
          } else {
            validation_errors.push(SpecialSchemeMissingFollowingSolidus)
            state = SpecialAuthorityIgnoreSlashes
            continue view // Re-process same character
          }
        // Special authority ignore slashes state
        // (https://url.spec.whatwg.org/#special-authority-ignore-slashes-state)
        // 1. If c is neither U+002F (/) nor U+005C (\), then set state to authority
        //    state and decrease pointer by 1.
        // 2. Otherwise, special-scheme-missing-following-solidus validation error.
        SpecialAuthorityIgnoreSlashes =>
          if !(c is ('/' | '\\')) {
            state = Authority
            continue view // Re-process same character in Authority
          } else {
            validation_errors.push(SpecialSchemeMissingFollowingSolidus)
          }
        // Authority state (https://url.spec.whatwg.org/#authority-state)
        Authority =>
          if c is '@' {
            validation_errors.push(InvalidCredentials)
            if at_sign_seen {
              let prepend = "%40\{buffer.to_string()}"
              buffer.reset()
              buffer.write_string(prepend)
            }
            at_sign_seen = true
            for code_point in buffer.to_string() {
              if code_point is ':' && !password_token_seen {
                password_token_seen = true
                continue
              }
              let encoded_code_points = utf8_percent_encode(
                [code_point],
                userinfo_percent_encode_set,
              )
              if password_token_seen {
                url.password = "\{url.password}\{encoded_code_points}"
              } else {
                url.username = "\{url.username}\{encoded_code_points}"
              }
            }
            buffer.reset()
          } else if c is ('/' | '?' | '#') || (url.is_special() && c is '\\') {
            if at_sign_seen && buffer.is_empty() {
              validation_errors.push(HostMissing)
              return None
            }
            for _ in buffer.to_string() {
              pointer.decrease()
            }
            pointer.decrease()
            buffer.reset()
            state = Host
          } else {
            buffer.write_char(c)
          }
        // Host state (https://url.spec.whatwg.org/#host-state)
        // Hostname state (https://url.spec.whatwg.org/#hostname-state)
        // These states are nearly identical, with hostname state not transitioning to port.
        Host | Hostname => {
          if has_state_override && url.scheme == "file" {
            state = FileHost
            continue view
          }
          // 1. If state override is given and url's scheme is "file", then decrease
          //    pointer by 1 and set state to file host state.
          // 2. Otherwise, if c is U+003A (:) and insideBrackets is false, then:
          // 3. Otherwise, if c is the EOF code point, U+002F (/), U+003F (?), or
          //    U+0023 (#), or url is special and c is U+005C (\), then decrease
          //    pointer by 1 and: [process host]
          // 4. Otherwise, append c to buffer.
          if c is '[' {
            inside_brackets = true
            buffer.write_char(c)
          } else if c is ']' {
            inside_brackets = false
            buffer.write_char(c)
          } else if c is ':' && !inside_brackets {
            if buffer.is_empty() {
              validation_errors.push(HostMissing)
              return None
            }
            if state_override is Some(Hostname) {
              return None
            }
            let host = Host::parse(
              buffer.to_string(),
              is_opaque=!url.is_special(),
            ) catch {
              err => {
                validation_errors.push(err)
                return None
              }
            }
            url.host = Some(host)
            buffer.reset()
            state = Port
          } else if c is ('/' | '?' | '#') || (url.is_special() && c is '\\') {
            pointer.decrease()
            if url.is_special() && buffer.is_empty() {
              validation_errors.push(HostMissing)
              return None
            }
            if has_state_override &&
              buffer.is_empty() &&
              (
                !url.username.is_empty() ||
                !url.password.is_empty() ||
                url.port is Some(_)
              ) {
              return None
            }
            if buffer.is_empty() {
              url.host = Some(Host::Opaque(""))
            } else {
              let host = Host::parse(
                buffer.to_string(),
                is_opaque=!url.is_special(),
              ) catch {
                err => {
                  validation_errors.push(err)
                  return None
                }
              }
              url.host = Some(host)
            }
            buffer.reset()
            state = PathStart
            if has_state_override {
              return Some(url)
            }
          } else {
            buffer.write_char(c)
          }
        }
        // Port state (https://url.spec.whatwg.org/#port-state)
        // 1. If c is an ASCII digit, append c to buffer.
        // 2. Otherwise, if c is the EOF code point, U+002F (/), U+003F (?), or
        //    U+0023 (#), or url is special and c is U+005C (\), or state override
        //    is given, then: [process port]
        // 3. Otherwise, return failure.
        Port =>
          if c.is_ascii_digit() {
            buffer.write_char(c)
          } else if c is ('/' | '?' | '#') ||
            (url.is_special() && c is '\\') ||
            has_state_override {
            if !buffer.is_empty() {
              let port_str = buffer.to_string()
              let mut port_value : UInt64 = 0
              for ch in port_str {
                port_value = port_value * 10 + (ch.to_int() - '0').to_uint64()
                // Check overflow during accumulation to prevent UInt64 wraparound
                if port_value > 65535 {
                  return None
                }
              }
              // Check if port is default for the scheme
              let port_u16 = port_value.to_uint16()
              let is_default = match url.scheme {
                "ftp" => port_u16 == 21
                "http" | "ws" => port_u16 == 80
                "https" | "wss" => port_u16 == 443
                _ => false
              }
              url.port = if is_default { None } else { Some(port_u16) }
              buffer.reset()
              if has_state_override {
                return Some(url)
              }
            } else if has_state_override {
              return None
            }
            state = PathStart
            pointer.decrease()
          } else {
            // Invalid port character
            return None
          }
        // Path start state (https://url.spec.whatwg.org/#path-start-state)
        // 1. If url is special, then:
        //    1.1. If c is U+005C (\), invalid-reverse-solidus validation error.
        //    1.2. Set state to path state.
        //    1.3. If c is neither U+002F (/) nor U+005C (\), then decrease pointer by 1.
        // 2. Otherwise, if state override is not given and c is U+003F (?), set
        //    url's query to the empty string and state to query state.
        // 3. Otherwise, if state override is not given and c is U+0023 (#), set
        //    url's fragment to the empty string and state to fragment state.
        // 4. Otherwise, if c is not the EOF code point:
        //    4.1. Set state to path state.
        //    4.2. If c is not U+002F (/), then decrease pointer by 1.
        PathStart =>
          if url.is_special() {
            if c is '\\' {
              validation_errors.push(InvalidReverseSolidus)
            }
            state = Path
            if !(c is ('/' | '\\')) {
              continue view
            }
          } else if !has_state_override && c is '?' {
            url.query = Some("")
            state = Query
          } else if !has_state_override && c is '#' {
            url.fragment = Some("")
            state = Fragment
          } else {
            state = Path
            if !(c is '/') {
              continue view
            }
          }
        // Path state (https://url.spec.whatwg.org/#path-state)
        Path =>
          if c is '/' ||
            (url.is_special() && c is '\\') ||
            (!has_state_override && c is ('?' | '#')) {
            if url.is_special() && c is '\\' {
              validation_errors.push(InvalidReverseSolidus)
            }
            let buffer_str = buffer.to_string()
            // Handle . and .. path segments
            if is_double_dot_path_segment(buffer_str) {
              url.path.shorten(scheme=url.scheme)
              if !(c is ('/' | '\\')) {
                match url.path {
                  Segments(segments) => segments.push("")
                  _ => ()
                }
              }
            } else if is_single_dot_path_segment(buffer_str) {
              if !(c is ('/' | '\\')) {
                match url.path {
                  Segments(segments) => segments.push("")
                  _ => ()
                }
              }
            } else {
              if url.scheme == "file" &&
                url.path is Segments(segments) &&
                segments.is_empty() {
                // Windows drive letter check
                if buffer_str.length() == 2 {
                  match buffer_str {
                    [letter, ':' | '|'] if letter.is_ascii_alphabetic() => {
                      // Normalize Windows drive letter (preserve case, replace | with :)
                      let normalized = "\{letter}:"
                      match url.path {
                        Segments(segments) => segments.push(normalized)
                        _ => ()
                      }
                      buffer.reset()
                      if c is '?' {
                        url.query = Some("")
                        state = Query
                        continue pointer.next()
                      } else if c is '#' {
                        url.fragment = Some("")
                        state = Fragment
                        continue pointer.next()
                      }
                      continue pointer.next()
                    }
                    _ => ()
                  }
                }
              }
              match url.path {
                Segments(segments) =>
                  segments.push(
                    utf8_percent_encode(buffer_str, path_percent_encode_set),
                  )
                Opaque(s) =>
                  url.path = Opaque(
                    s +
                    "/" +
                    utf8_percent_encode(buffer_str, path_percent_encode_set),
                  )
              }
            }
            buffer.reset()
            if c is '?' {
              url.query = Some("")
              state = Query
            } else if c is '#' {
              url.fragment = Some("")
              state = Fragment
            }
            // Percent-encode if needed
          } else if c is '%' {
            // Per WHATWG: % followed by non-hex is a validation error but pass through literally
            // (% is not in the path percent-encode set so it shouldn't be encoded)
            buffer.write_char(c)
          } else if path_percent_encode_set(c) {
            // This character should be percent-encoded
            let bytes = @encoding/utf8.encode([c])
            for byte in bytes {
              buffer.write_char('%')
              let b = byte.to_int()
              buffer.write_char(hex_digits[(b >> 4) & 0x0f])
              buffer.write_char(hex_digits[b & 0x0f])
            }
          } else {
            buffer.write_char(c)
          }
        // Opaque path state (https://url.spec.whatwg.org/#opaque-path-state)
        // 1. If c is U+003F (?), then set url's query to the empty string and
        //    state to query state.
        // 2. Otherwise, if c is U+0023 (#), then set url's fragment to the empty
        //    string and state to fragment state.
        // 3. Otherwise: [if not EOF, UTF-8 percent-encode c using C0 control
        //    percent-encode set and append result to url's path]
        OpaquePath =>
          if c is '?' {
            // Encode trailing spaces in opaque path before transitioning to Query
            match url.path {
              Opaque(s) => url.path = Opaque(encode_last_trailing_space(s))
              _ => ()
            }
            url.query = Some("")
            state = Query
          } else if c is '#' {
            // Encode trailing spaces in opaque path before transitioning to Fragment
            match url.path {
              Opaque(s) => url.path = Opaque(encode_last_trailing_space(s))
              _ => ()
            }
            url.fragment = Some("")
            state = Fragment
          } else {
            match url.path {
              Opaque(s) =>
                if c0_control_percent_encode_set(c) {
                  let bytes = @encoding/utf8.encode([c])
                  let mut encoded = s
                  for byte in bytes {
                    let b = byte.to_int()
                    encoded = "\{encoded}%\{hex_digits[(b >> 4) & 0x0f]}\{hex_digits[b & 0x0f]}"
                  }
                  url.path = Opaque(encoded)
                } else {
                  url.path = Opaque("\{s}\{c}")
                }
              _ => ()
            }
          }
        // Query state (https://url.spec.whatwg.org/#query-state)
        // 1. If state override is not given and c is U+0023 (#), then set url's
        //    fragment to the empty string and state to fragment state.
        // 2. Otherwise, if c is not the EOF code point:
        //    2.1. If url is special and url's scheme is not "ws" or "wss", then
        //         use the special-query percent-encode set.
        //    2.2. UTF-8 percent-encode c using the appropriate encode set, and
        //         append the result to url's query.
        Query =>
          if !has_state_override && c is '#' {
            url.fragment = Some("")
            state = Fragment
          } else {
            // Percent-encode query characters
            // Use special query encode set for special URLs (encodes ')
            let encode_set = if url.is_special() {
              special_query_percent_encode_set
            } else {
              query_percent_encode_set
            }
            match url.query {
              Some(q) =>
                if c is '%' {
                  // Per WHATWG: % followed by non-hex is a validation error but pass through literally
                  // (% is not in the query percent-encode set so it shouldn't be encoded)
                  url.query = Some("\{q}\{c}")
                } else if encode_set(c) {
                  let bytes = @encoding/utf8.encode([c])
                  let mut encoded = q
                  for byte in bytes {
                    let b = byte.to_int()
                    encoded = "\{encoded}%\{hex_digits[(b >> 4) & 0x0f]}\{hex_digits[b & 0x0f]}"
                  }
                  url.query = Some(encoded)
                } else {
                  url.query = Some("\{q}\{c}")
                }
              None => ()
            }
          }
        // Fragment state (https://url.spec.whatwg.org/#fragment-state)
        // If c is not the EOF code point, then:
        //   UTF-8 percent-encode c using the fragment percent-encode set and
        //   append the result to url's fragment.
        Fragment =>
          match url.fragment {
            Some(f) =>
              if c is '%' {
                // Per WHATWG: % followed by non-hex is a validation error but pass through literally
                // (% is not in the fragment percent-encode set so it shouldn't be encoded)
                url.fragment = Some("\{f}\{c}")
              } else if fragment_percent_encode_set(c) {
                let bytes = @encoding/utf8.encode([c])
                let mut encoded = f
                for byte in bytes {
                  let b = byte.to_int()
                  encoded = "\{encoded}%\{hex_digits[(b >> 4) & 0x0f]}\{hex_digits[b & 0x0f]}"
                }
                url.fragment = Some(encoded)
              } else {
                url.fragment = Some("\{f}\{c}")
              }
            None => ()
          }
        // File state (https://url.spec.whatwg.org/#file-state)
        // 1. Set url's scheme to "file".
        // 2. Set url's host to the empty string.
        // 3. If c is U+002F (/) or U+005C (\), then: [set state to file slash state]
        // 4. Otherwise, if base is non-null and base's scheme is "file": [copy from base]
        // 5. Otherwise: [set state to path state]
        File => {
          url.scheme = "file"
          if c is ('/' | '\\') {
            if c is '\\' {
              validation_errors.push(InvalidReverseSolidus)
            }
            state = FileSlash
          } else if base is Some(base) && base.scheme == "file" {
            url.host = base.host
            url.path = base.path.clone()
            url.query = base.query
            if c is '?' {
              url.query = Some("")
              state = Query
            } else if c is '#' {
              url.fragment = Some("")
              state = Fragment
            } else {
              url.query = None
              // Check for Windows drive letter - c is the potential letter
              let starts_with_drive = if c.is_ascii_alphabetic() {
                match remaining {
                  [':' | '|', .. rest] =>
                    rest is ([] | ['/' | '\\' | '?' | '#', ..])
                  _ => false
                }
              } else {
                false
              }
              if starts_with_drive {
                // Reset path for drive letter, don't shorten base path
                url.path = Segments([])
              } else {
                url.path.shorten(scheme="file")
              }
              state = Path
              continue view // Re-process same character in Path
            }
          } else {
            // No base or base is not file scheme - set empty host for proper file:/// serialization
            url.host = Some(Host::Opaque(""))
            state = Path
            continue view // Re-process same character in Path
          }
        }
        // File slash state (https://url.spec.whatwg.org/#file-slash-state)
        // 1. If c is U+002F (/) or U+005C (\), then:
        //    1.1. If c is U+005C (\), invalid-reverse-solidus validation error.
        //    1.2. Set state to file host state.
        // 2. Otherwise: [check for Windows drive letter, set host/path from base if available]
        FileSlash => {
          url.scheme = "file"
          if c is ('/' | '\\') {
            if c is '\\' {
              validation_errors.push(InvalidReverseSolidus)
            }
            state = FileHost
          } else {
            // Check if current input starts with a Windows drive letter
            // e.g., for "/c:/foo", c='c', remaining=":/foo"
            let input_has_drive = c.is_ascii_alphabetic() &&
              remaining is [':' | '|', ..]
            if base is Some(base) && base.scheme == "file" {
              url.host = base.host
              // Only copy base drive letter if input doesn't have its own
              if !input_has_drive {
                match base.path {
                  Segments([drive, ..]) if drive.length() == 2 =>
                    match drive {
                      [letter, ':'] if letter.is_ascii_alphabetic() =>
                        url.path = Segments([drive])
                      _ => ()
                    }
                  _ => ()
                }
              }
            } else {
              // No base - set empty host for proper file:/// serialization
              url.host = Some(Host::Opaque(""))
            }
            state = Path
            continue view // Re-process same character in Path
          }
        }
        // File host state (https://url.spec.whatwg.org/#file-host-state)
        // 1. If c is the EOF code point, U+002F (/), U+005C (\), U+003F (?), or
        //    U+0023 (#), then decrease pointer by 1 and then:
        //    1.1. If state override is not given and buffer is a Windows drive letter,
        //         set state to path state. (Note: This is a file: URL quirk.)
        //    1.2. Otherwise, if buffer is the empty string, then set url's host
        //         to the empty string and set state to path start state.
        //    1.3. Otherwise, run these steps: [parse host, handle "localhost"]
        // 2. Otherwise, append c to buffer.
        FileHost => {
          url.scheme = "file"
          if c is ('/' | '\\' | '?' | '#') {
            pointer.decrease()
            // Check for Windows drive letter
            let buffer_str = buffer.to_string()
            if buffer_str.length() == 2 {
              match buffer_str {
                [letter, ':' | '|'] if letter.is_ascii_alphabetic() =>
                  // It's a Windows drive letter, not a host
                  state = Path
                _ =>
                  if buffer_str.is_empty() {
                    url.host = Some(Host::Opaque(""))
                    state = PathStart
                  } else {
                    let host = Host::parse(buffer_str) catch {
                      err => {
                        validation_errors.push(err)
                        return None
                      }
                    }
                    if host is Domain("localhost") {
                      url.host = Some(Host::Opaque(""))
                    } else {
                      url.host = Some(host)
                    }
                    buffer.reset()
                    state = PathStart
                  }
              }
            } else if buffer_str.is_empty() {
              url.host = Some(Host::Opaque(""))
              state = PathStart
            } else {
              let host = Host::parse(buffer_str) catch {
                err => {
                  validation_errors.push(err)
                  return None
                }
              }
              if host is Domain("localhost") {
                url.host = Some(Host::Opaque(""))
              } else {
                url.host = Some(host)
              }
              buffer.reset()
              state = PathStart
            }
          } else {
            buffer.write_char(c)
          }
        }
      }
    }
    // Handle EOF based on current state
    match state {
      SchemeStart | NoScheme => {
        if has_state_override {
          return None
        }
        validation_errors.push(MissingSchemeNonRelativeUrl)
        return None
      }
      Scheme =>
        // EOF in Scheme state without finding ':' - try as NoScheme if base exists
        if has_state_override {
          return None
        } else if base is Some(_) {
          // Reset and re-parse in NoScheme state
          buffer.reset()
          state = NoScheme
          pointer.start_over()
          // Restart the outer loop to re-parse from NoScheme
          continue
        } else {
          validation_errors.push(MissingSchemeNonRelativeUrl)
          return None
        }
      Authority => {
        // At EOF in Authority state - buffer contains host[:port] (no @ was seen)
        // or remaining host[:port] after @
        if at_sign_seen && buffer.is_empty() {
          validation_errors.push(HostMissing)
          return None
        }
        let buffer_str = buffer.to_string()
        if buffer_str.is_empty() {
          if url.is_special() {
            validation_errors.push(HostMissing)
            return None
          }
          url.host = Some(Host::Opaque(""))
        } else {
          // Check for host:port pattern
          // For IPv6 addresses like [2001::1]:80, the port separator is after the closing ]
          let mut port_separator = -1
          if buffer_str.has_prefix("[") {
            // IPv6 address - look for : after ]
            let mut found_bracket = false
            for i, c in buffer_str {
              if c == ']' {
                found_bracket = true
              } else if found_bracket && c == ':' {
                port_separator = i
                break
              }
            }
          } else {
            // Regular host - last colon is port separator
            for i, c in buffer_str {
              if c == ':' {
                port_separator = i
              }
            }
          }
          let has_port = port_separator > 0
          if has_port {
            // Split at port separator
            let last_colon = port_separator
            if last_colon > 0 {
              // Extract host and port using character iteration
              let host_builder = StringBuilder::new()
              let port_builder = StringBuilder::new()
              let mut past_colon = false
              let mut char_idx = 0
              for c in buffer_str {
                if char_idx == last_colon {
                  past_colon = true
                } else if past_colon {
                  port_builder.write_char(c)
                } else {
                  host_builder.write_char(c)
                }
                char_idx = char_idx + 1
              }
              let host_part = host_builder.to_string()
              let port_part = port_builder.to_string()
              // Parse host
              let host = Host::parse(host_part, is_opaque=!url.is_special()) catch {
                err => {
                  validation_errors.push(err)
                  return None
                }
              }
              url.host = Some(host)
              // Parse port
              if !port_part.is_empty() {
                let mut port_value : UInt64 = 0
                for ch in port_part {
                  if !ch.is_ascii_digit() {
                    return None // Invalid port character
                  }
                  port_value = port_value * 10 + (ch.to_int() - '0').to_uint64()
                  if port_value > 65535 {
                    return None
                  }
                }
                let port_u16 = port_value.to_uint16()
                let is_default = match url.scheme {
                  "ftp" => port_u16 == 21
                  "http" | "ws" => port_u16 == 80
                  "https" | "wss" => port_u16 == 443
                  _ => false
                }
                url.port = if is_default { None } else { Some(port_u16) }
              }
            } else {
              // Colon at start means empty host - parse whole buffer as host
              let host = Host::parse(buffer_str, is_opaque=!url.is_special()) catch {
                err => {
                  validation_errors.push(err)
                  return None
                }
              }
              url.host = Some(host)
            }
          } else {
            // No port, just parse as host
            let host = Host::parse(buffer_str, is_opaque=!url.is_special()) catch {
              err => {
                validation_errors.push(err)
                return None
              }
            }
            url.host = Some(host)
          }
        }
      }
      Host | Hostname => {
        if url.is_special() && buffer.is_empty() {
          validation_errors.push(HostMissing)
          return None
        }
        if has_state_override &&
          buffer.is_empty() &&
          (
            !url.username.is_empty() ||
            !url.password.is_empty() ||
            url.port is Some(_)
          ) {
          return None
        }
        if !buffer.is_empty() {
          let host = Host::parse(
            buffer.to_string(),
            is_opaque=!url.is_special(),
          ) catch {
            err => {
              validation_errors.push(err)
              return None
            }
          }
          url.host = Some(host)
        } else if !url.is_special() {
          url.host = Some(Host::Opaque(""))
        }
      }
      Port =>
        if !buffer.is_empty() {
          let port_str = buffer.to_string()
          let mut port_value : UInt64 = 0
          for ch in port_str {
            port_value = port_value * 10 + (ch.to_int() - '0').to_uint64()
            // Check overflow during accumulation to prevent UInt64 wraparound
            if port_value > 65535 {
              return None
            }
          }
          let port_u16 = port_value.to_uint16()
          let is_default = match url.scheme {
            "ftp" => port_u16 == 21
            "http" | "ws" => port_u16 == 80
            "https" | "wss" => port_u16 == 443
            _ => false
          }
          url.port = if is_default { None } else { Some(port_u16) }
        } else if has_state_override {
          return None
        }
      PathStart =>
        if has_state_override && url.host is None {
          match url.path {
            Segments(segments) => segments.push("")
            _ => ()
          }
        }
      Path => {
        let buffer_str = buffer.to_string()
        if is_double_dot_path_segment(buffer_str) {
          url.path.shorten(scheme=url.scheme)
          // Push empty segment for trailing slash
          match url.path {
            Segments(segments) => segments.push("")
            _ => ()
          }
        } else if is_single_dot_path_segment(buffer_str) {
          // Single dot at EOF - push empty segment for trailing slash
          match url.path {
            Segments(segments) => segments.push("")
            _ => ()
          }
          // Check for Windows drive letter normalization at EOF (e.g., "C|" -> "C:")
        } else if url.scheme == "file" &&
          url.path is Segments(segments) &&
          segments.is_empty() &&
          buffer_str.length() == 2 {
          match buffer_str {
            [letter, ':' | '|'] if letter.is_ascii_alphabetic() =>
              match url.path {
                Segments(segments) => segments.push("\{letter}:")
                _ => ()
              }
            _ =>
              match url.path {
                Segments(segments) =>
                  segments.push(
                    utf8_percent_encode(buffer_str, path_percent_encode_set),
                  )
                Opaque(s) =>
                  url.path = Opaque(
                    s +
                    "/" +
                    utf8_percent_encode(buffer_str, path_percent_encode_set),
                  )
              }
          }
        } else {
          // Push segment (may be empty for trailing slash in non-special URLs)
          match url.path {
            Segments(segments) =>
              segments.push(
                utf8_percent_encode(buffer_str, path_percent_encode_set),
              )
            Opaque(s) =>
              url.path = Opaque(
                s +
                "/" +
                utf8_percent_encode(buffer_str, path_percent_encode_set),
              )
          }
        }
      }
      FileHost => {
        url.scheme = "file"
        let buffer_str = buffer.to_string()
        if buffer_str.is_empty() {
          url.host = Some(Host::Opaque(""))
        } else {
          // Check for Windows drive letter using explicit char access
          let is_drive_letter = buffer_str.length() == 2 &&
            (match buffer_str.get_char(0) {
              Some(c) => c.is_ascii_alphabetic()
              None => false
            }) &&
            (match buffer_str.get_char(1) {
              Some(':') | Some('|') => true
              _ => false
            })
          if is_drive_letter {
            // Windows drive letter in host position (normalize | to :)
            url.host = Some(Host::Opaque(""))
            let letter = buffer_str.get_char(0).unwrap()
            url.path = Segments(["\{letter}:"])
          } else {
            let host = Host::parse(buffer_str) catch {
              err => {
                validation_errors.push(err)
                return None
              }
            }
            if host is Domain("localhost") {
              url.host = Some(Host::Opaque(""))
            } else {
              url.host = Some(host)
            }
          }
        }
      }
      SpecialRelativeOrAuthority | Relative => {
        // At EOF in these states, copy from base URL
        guard base is Some(base) else {
          abort("base must be Some(base) in Relative-like state at EOF")
        }
        url.username = base.username
        url.password = base.password
        url.host = base.host
        url.port = base.port
        url.path = base.path.clone()
        url.query = base.query
      }
      RelativeSlash => {
        // At EOF in RelativeSlash (saw "/" but nothing after), set root path
        guard base is Some(base) else {
          abort("base must be Some(base) in RelativeSlash state at EOF")
        }
        url.username = base.username
        url.password = base.password
        url.host = base.host
        url.port = base.port
        // Don't copy path - "/" means root path, so use empty segments (serializes as "/")
        // Don't copy query either
      }
      File =>
        // At EOF in File state (e.g., "file:" alone)
        // Copy from base if available per WHATWG spec
        if base is Some(base) && base.scheme == "file" {
          url.host = base.host
          url.path = base.path.clone()
          url.query = base.query
          // fragment is NOT copied per spec
        } else {
          url.host = Some(Host::Opaque(""))
          // path defaults to Segments([]) which serializes as "/" for file URLs
        }
      FileSlash => {
        // At EOF in FileSlash state (e.g., "/" with file base)
        url.scheme = "file"
        // Preserve host and Windows drive letter from base if present
        if base is Some(base) && base.scheme == "file" {
          url.host = base.host
          match base.path {
            Segments([drive, ..]) if drive.length() == 2 =>
              match drive {
                [letter, ':'] if letter.is_ascii_alphabetic() =>
                  // Include empty segment for trailing slash: C: + / = C:/
                  url.path = Segments([drive, ""])
                _ => ()
              }
            _ => ()
          }
        } else {
          url.host = Some(Host::Opaque(""))
        }
      }
      PathOrAuthority =>
        // At EOF in PathOrAuthority state - we consumed the '/' after scheme
        // Set path to "/" for URLs like "foo:/"
        url.path = Segments([""])
      SpecialAuthoritySlashes | SpecialAuthorityIgnoreSlashes => {
        // At EOF waiting for authority - special URLs require host
        validation_errors.push(HostMissing)
        return None
      }
      _ => ()
    }
    break // Exit outer loop after successful EOF handling
  }
  Some(url)
}
