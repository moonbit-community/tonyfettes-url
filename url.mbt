///|
/// Represents a parsed URL per the WHATWG URL Standard. See:
/// https://url.spec.whatwg.org/#url-representation
///
/// Contains scheme, credentials (username/password), host, port, path, query,
/// and fragment.
struct Url {
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
  {
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
/// Parse a URL string per the WHATWG URL Standard.
/// See: https://url.spec.whatwg.org/#concept-basic-url-parser
///
/// `base` enables relative resolution: `parse("../d", base~)`.
///
/// Raises the `ValidationError` that made parsing fail. The spec also defines
/// non-fatal validation errors, such as a missing `//` after a special
/// scheme; parsing continues past those, and they are appended to
/// `validation_errors` when an array is given.
#as_free_fn
pub fn Url::parse(
  input : StringView,
  base? : Url,
  validation_errors? : Array[ValidationError],
) -> Url raise ValidationError {
  Url::parse_basic(Url::new(), input, base?, validation_errors?)
}

///|
/// Serialize URL to string per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#url-serializing
pub fn Url::to_string(self : Url) -> String {
  let result = StringBuilder()
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
/// The host, or `None` for URLs without one (opaque paths, `unix:/x`, ...).
pub fn Url::host(self : Url) -> Host? {
  self.host
}

///|
/// The port, or `None` when absent or equal to the scheme's default port.
pub fn Url::port(self : Url) -> UInt16? {
  self.port
}

///|
/// The path, either opaque or a list of segments.
pub fn Url::path(self : Url) -> Path {
  self.path
}

///|
/// The scheme, lowercased and without the trailing colon.
pub fn Url::scheme(self : Url) -> String {
  self.scheme
}

///|
/// The query, or `None` when absent. `Some("")` is a present but empty query
/// and serializes as a bare `?`.
pub fn Url::query(self : Url) -> String? {
  self.query
}

///|
/// The fragment, or `None` when absent. `Some("")` serializes as a bare `#`.
pub fn Url::fragment(self : Url) -> String? {
  self.fragment
}

///|
/// Get the URL search params.
/// Returns a new UrlSearchParams instance parsed from the current query string.
/// Note: Changes to the returned UrlSearchParams will NOT automatically update the URL.
/// Use set_search_params() to update the URL with modified search params.
/// See: https://url.spec.whatwg.org/#dom-url-searchparams
pub fn Url::search_params(self : Url) -> UrlSearchParams {
  match self.query {
    Some(query) => UrlSearchParams::parse(query)
    None => UrlSearchParams([])
  }
}

///|
/// Reasons a `with_*` update is rejected. Each variant corresponds to an early
/// return in the URL Standard's setter algorithms, where the JavaScript API
/// silently keeps the old value.
pub suberror UpdateError {
  /// The scheme is not `alpha *( alphanumeric / "+" / "-" / "." )`.
  InvalidScheme
  /// A special scheme (ftp, file, http, https, ws, wss) cannot be exchanged
  /// with a non-special one, or the reverse.
  SpecialSchemeMismatch
  /// A special scheme needs a host; `file` accepts an empty host, the others
  /// do not.
  HostRequired
  /// Opaque hosts belong to non-special schemes, domains and IPv4 addresses to
  /// special ones.
  HostKindMismatch
  /// The URL has an opaque path, so its host and path cannot change.
  HasOpaquePath
  /// The URL has no host, an empty host, or the `file` scheme, so it cannot
  /// carry a username, a password, or a port.
  CannotHaveCredentialsOrPort
  /// An opaque path on a URL that has a host or a special scheme, an opaque
  /// path containing `?` or `#`, or a segment containing a separator.
  InvalidPath
} derive(Debug, Eq)

///|
/// Copy a URL so that an update leaves the original untouched.
fn Url::clone(self : Url) -> Url {
  {
    scheme: self.scheme,
    username: self.username,
    password: self.password,
    host: self.host,
    port: self.port,
    path: self.path.clone(),
    query: self.query,
    fragment: self.fragment,
  }
}

///|
/// See: https://url.spec.whatwg.org/#include-credentials
fn Url::includes_credentials(self : Url) -> Bool {
  !self.username.is_empty() || !self.password.is_empty()
}

///|
/// See: https://url.spec.whatwg.org/#cannot-have-a-username-password-port
fn Url::cannot_have_credentials_or_port(self : Url) -> Bool {
  has_empty_host(self.host) || self.scheme == "file"
}

///|
/// Return a copy with a new scheme.
/// See: https://url.spec.whatwg.org/#dom-url-protocol
///
/// The scheme is lowercased, and a port equal to the new scheme's default port
/// becomes `None`. Raises `InvalidScheme` on bad syntax,
/// `SpecialSchemeMismatch` when exchanging a special scheme for a non-special
/// one or the reverse, `CannotHaveCredentialsOrPort` when switching to `file`
/// while credentials or a port are present, and `HostRequired` when switching
/// away from a `file` URL whose host is empty.
pub fn Url::with_scheme(self : Url, scheme : String) -> Url raise UpdateError {
  guard scheme[:] is [first, .. rest] && first.is_ascii_alphabetic() else {
    raise InvalidScheme
  }
  for c in rest {
    guard c is ('a'..='z' | 'A'..='Z' | '0'..='9' | '+' | '-' | '.') else {
      raise InvalidScheme
    }
  }
  let scheme = scheme.to_lower()
  if scheme == self.scheme {
    return self.clone()
  }
  if is_special_scheme(scheme) != self.is_special() {
    raise SpecialSchemeMismatch
  }
  if scheme == "file" && (self.includes_credentials() || self.port is Some(_)) {
    raise CannotHaveCredentialsOrPort
  }
  if self.scheme == "file" && has_empty_host(self.host) {
    raise HostRequired
  }
  let url = self.clone()
  url.scheme = scheme
  if url.port == default_port(scheme) {
    url.port = None
  }
  url
}

///|
/// Return a copy with a new username, percent-encoded with the userinfo set.
/// See: https://url.spec.whatwg.org/#dom-url-username
///
/// Raises `CannotHaveCredentialsOrPort` for URLs without a host, with an
/// empty host, or with the `file` scheme.
pub fn Url::with_username(
  self : Url,
  username : String,
) -> Url raise UpdateError {
  guard !self.cannot_have_credentials_or_port() else {
    raise CannotHaveCredentialsOrPort
  }
  let url = self.clone()
  url.username = utf8_percent_encode(username, userinfo_percent_encode_set)
  url
}

///|
/// Return a copy with a new password, percent-encoded with the userinfo set.
/// See: https://url.spec.whatwg.org/#dom-url-password
///
/// Raises `CannotHaveCredentialsOrPort` for URLs without a host, with an
/// empty host, or with the `file` scheme.
pub fn Url::with_password(
  self : Url,
  password : String,
) -> Url raise UpdateError {
  guard !self.cannot_have_credentials_or_port() else {
    raise CannotHaveCredentialsOrPort
  }
  let url = self.clone()
  url.password = utf8_percent_encode(password, userinfo_percent_encode_set)
  url
}

///|
/// Return a copy with a new host.
/// See: https://url.spec.whatwg.org/#dom-url-hostname
///
/// `None` removes the host, which only non-special URLs allow. A `file` URL
/// given `Domain("localhost")` gets the empty host, as the parser does.
/// Raises `HasOpaquePath` when the URL has an opaque path, `HostRequired`
/// when a special URL would end up without a usable host,
/// `HostKindMismatch` when the host kind does not fit the scheme, and
/// `CannotHaveCredentialsOrPort` when removing or emptying the host of a URL
/// that carries credentials or a port.
pub fn Url::with_host(self : Url, host : Host?) -> Url raise UpdateError {
  guard self.path is Segments(_) else { raise HasOpaquePath }
  let host = match host {
    None => {
      if self.is_special() {
        raise HostRequired
      }
      if self.includes_credentials() || self.port is Some(_) {
        raise CannotHaveCredentialsOrPort
      }
      None
    }
    Some(Opaque("")) => {
      if self.is_special() && self.scheme != "file" {
        raise HostRequired
      }
      if self.includes_credentials() || self.port is Some(_) {
        raise CannotHaveCredentialsOrPort
      }
      host
    }
    Some(Opaque(_)) => {
      if self.is_special() {
        raise HostKindMismatch
      }
      host
    }
    Some(Domain("")) => raise HostRequired
    Some(Domain("localhost")) if self.scheme == "file" => Some(Opaque(""))
    Some(Domain(_) | IPv4(_)) => {
      if !self.is_special() {
        raise HostKindMismatch
      }
      host
    }
    Some(IPv6(_)) => host
  }
  let url = self.clone()
  url.host = host
  url
}

///|
/// Return a copy with a new port. `None` removes the port, and a port equal to
/// the scheme's default port is stored as `None`.
/// See: https://url.spec.whatwg.org/#dom-url-port
///
/// Raises `CannotHaveCredentialsOrPort` for URLs without a host, with an
/// empty host, or with the `file` scheme.
pub fn Url::with_port(self : Url, port : UInt16?) -> Url raise UpdateError {
  guard !self.cannot_have_credentials_or_port() else {
    raise CannotHaveCredentialsOrPort
  }
  let url = self.clone()
  url.port = if port == default_port(self.scheme) { None } else { port }
  url
}

///|
/// Return a copy with a new path.
/// See: https://url.spec.whatwg.org/#dom-url-pathname
///
/// Segments are taken literally: each one is percent-encoded with the path
/// set, but `.` and `..` are not resolved. A `file` URL normalizes a Windows
/// drive letter in its first segment (`C|` becomes `C:`), and an empty
/// segment list becomes `[""]` where the serialization needs a `/`, as the
/// parser does. Raises `InvalidPath` for an opaque path on a URL that has a
/// host or a special scheme, an opaque path containing `?` or `#`, or a
/// segment containing `/` (or `\` on a special URL).
pub fn Url::with_path(self : Url, path : Path) -> Url raise UpdateError {
  let url = self.clone()
  url.path = match path {
    Opaque(opaque_path) => {
      if self.is_special() || self.host is Some(_) {
        raise InvalidPath
      }
      if opaque_path.contains_char('?') || opaque_path.contains_char('#') {
        raise InvalidPath
      }
      Opaque(utf8_percent_encode(opaque_path, c0_control_percent_encode_set))
    }
    Segments(segments) => {
      let encoded = []
      for segment in segments {
        if segment.contains_char('/') ||
          (self.is_special() && segment.contains_char('\\')) {
          raise InvalidPath
        }
        encoded.push(utf8_percent_encode(segment, path_percent_encode_set))
      }
      if self.scheme == "file" && encoded.length() > 0 {
        match encoded[0][:] {
          [letter, '|'] if letter.is_ascii_alphabetic() =>
            encoded[0] = "\{letter}:"
          _ => ()
        }
      }
      if encoded.is_empty() && (self.host is None || self.is_special()) {
        encoded.push("")
      }
      Segments(encoded)
    }
  }
  url
}

///|
/// Return a copy with a new query, percent-encoded with the query set (the
/// special-query set for special schemes). `None` removes the query;
/// `Some("")` keeps a bare `?`.
/// See: https://url.spec.whatwg.org/#dom-url-search
pub fn Url::with_query(self : Url, query : String?) -> Url {
  let url = self.clone()
  url.query = query.map(query => {
    utf8_percent_encode(
      query,
      if self.is_special() {
        special_query_percent_encode_set
      } else {
        query_percent_encode_set
      },
    )
  })
  url
}

///|
/// Return a copy with a new fragment, percent-encoded with the fragment set.
/// `None` removes the fragment; `Some("")` keeps a bare `#`.
/// See: https://url.spec.whatwg.org/#dom-url-hash
pub fn Url::with_fragment(self : Url, fragment : String?) -> Url {
  let url = self.clone()
  url.fragment = fragment.map(fragment => {
    utf8_percent_encode(fragment, fragment_percent_encode_set)
  })
  url
}

///|
/// Return a copy whose query is the serialization of `params`, or no query at
/// all when `params` is empty.
/// See: https://url.spec.whatwg.org/#concept-urlsearchparams-update
pub fn Url::with_search_params(self : Url, params : UrlSearchParams) -> Url {
  let serialized = params.to_string()
  let url = self.clone()
  url.query = if serialized.is_empty() { None } else { Some(serialized) }
  url
}

///|
/// Get the origin of the URL.
/// See: https://url.spec.whatwg.org/#concept-url-origin
///
/// The origin of a URL is determined by switching on its scheme:
/// - "blob": parse the URL path serialization as a URL; if that fails, return
///   a new opaque origin; if its scheme is "http", "https" or "file", return
///   its origin; otherwise return a new opaque origin. (The blob URL entry
///   branch does not apply: this library has no blob URL store.)
/// - "ftp", "http", "https", "ws", "wss": return the tuple origin
///   (url's scheme, url's host, url's port, null).
/// - "file": left as an exercise to the reader by the spec; when in doubt,
///   return a new opaque origin.
/// - Otherwise: return a new opaque origin.
pub fn Url::origin(self : Url) -> Origin {
  match self.scheme {
    "blob" =>
      try Url::parse(self.path.to_string()[:]) catch {
        _ => Opaque
      } noraise {
        path_url =>
          match path_url.scheme {
            "http" | "https" | "file" => path_url.origin()
            _ => Opaque
          }
      }
    "ftp" | "http" | "https" | "ws" | "wss" =>
      match self.host {
        Some(host) => Tuple(scheme=self.scheme, host~, port=self.port)
        // Special non-file URLs always have a host after parsing.
        None => Opaque
      }
    _ => Opaque
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
/// Implement Show trait for Url, outputting the serialized URL string
pub impl Show for Url with fn output(self : Url, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}

///|
/// Serialize URL to JSON per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#dom-url-tojson
/// The toJSON() method returns the serialization of the URL.
pub impl ToJson for Url with fn to_json(self : Url) -> Json {
  self.to_string().to_json()
}

///|
/// Remove all ASCII tab (0x09), LF (0x0A), and CR (0x0D) from the entire input
fn remove_ascii_tab_or_newline(input : StringView) -> String {
  let output = StringBuilder()
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
      let result = StringBuilder()
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
  let input = for input = input {
    match input {
      ['\u{0000}'..='\u{0020}', .. rest] => continue rest
      input => break input
    }
  }
  // Trim from end
  let input = for input = input {
    match input {
      [.. rest, '\u{0000}'..='\u{0020}'] => continue rest
      input => break input
    }
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
  { input, pointer: input.start_offset(), }
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
) -> Url raise ValidationError {
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
  let buffer : StringBuilder = StringBuilder()
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
        return url
      }
      None => raise MissingSchemeNonRelativeUrl
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
            raise InvalidScheme
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
                  return url
                }
                if !url_special && next_special {
                  return url
                }
                if (
                    !url.username.is_empty() ||
                    !url.password.is_empty() ||
                    url.port is Some(_)
                  ) &&
                  next_scheme == "file" {
                  return url
                }
                if url.scheme == "file" && has_empty_host(url.host) {
                  return url
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
                return url
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
                raise InvalidScheme
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
            None =>
              // 1. Base is null
              raise MissingSchemeNonRelativeUrl
            Some({ path: Opaque(_), .. }) if !(c is '#') =>
              // 1. Base has opaque path and c is not #
              raise MissingSchemeNonRelativeUrl
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
              raise HostMissing
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
              raise HostMissing
            }
            if state_override is Some(Hostname) {
              raise HostInvalidCodePoint
            }
            let host = Host::parse(
              buffer.to_string(),
              is_opaque=!url.is_special(),
            )
            url.host = Some(host)
            buffer.reset()
            state = Port
          } else if c is ('/' | '?' | '#') || (url.is_special() && c is '\\') {
            pointer.decrease()
            if url.is_special() && buffer.is_empty() {
              raise HostMissing
            }
            if has_state_override &&
              buffer.is_empty() &&
              (
                !url.username.is_empty() ||
                !url.password.is_empty() ||
                url.port is Some(_)
              ) {
              raise HostMissing
            }
            if buffer.is_empty() {
              url.host = Some(Opaque(""))
            } else {
              let host = Host::parse(
                buffer.to_string(),
                is_opaque=!url.is_special(),
              )
              url.host = Some(host)
            }
            buffer.reset()
            state = PathStart
            if has_state_override {
              return url
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
                  raise PortOutOfRange
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
                return url
              }
            } else if has_state_override {
              raise PortInvalid
            }
            state = PathStart
            pointer.decrease()
          } else {
            raise PortInvalid
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
            url.host = Some(Opaque(""))
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
              url.host = Some(Opaque(""))
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
                    url.host = Some(Opaque(""))
                    state = PathStart
                  } else {
                    let host = Host::parse(buffer_str)
                    if host is Domain("localhost") {
                      url.host = Some(Opaque(""))
                    } else {
                      url.host = Some(host)
                    }
                    buffer.reset()
                    state = PathStart
                  }
              }
            } else if buffer_str.is_empty() {
              url.host = Some(Opaque(""))
              state = PathStart
            } else {
              let host = Host::parse(buffer_str)
              if host is Domain("localhost") {
                url.host = Some(Opaque(""))
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
          raise InvalidScheme
        }
        raise MissingSchemeNonRelativeUrl
      }
      Scheme =>
        // EOF in Scheme state without finding ':' - try as NoScheme if base exists
        if has_state_override {
          raise InvalidScheme
        } else if base is Some(_) {
          // Reset and re-parse in NoScheme state
          buffer.reset()
          state = NoScheme
          pointer.start_over()
          // Restart the outer loop to re-parse from NoScheme
          continue
        } else {
          raise MissingSchemeNonRelativeUrl
        }
      Authority => {
        // At EOF in Authority state - buffer contains host[:port] (no @ was seen)
        // or remaining host[:port] after @
        if at_sign_seen && buffer.is_empty() {
          raise HostMissing
        }
        let buffer_str = buffer.to_string()
        if buffer_str.is_empty() {
          if url.is_special() {
            raise HostMissing
          }
          url.host = Some(Opaque(""))
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
              let host_builder = StringBuilder()
              let port_builder = StringBuilder()
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
              let host = Host::parse(host_part, is_opaque=!url.is_special())
              url.host = Some(host)
              // Parse port
              if !port_part.is_empty() {
                let mut port_value : UInt64 = 0
                for ch in port_part {
                  if !ch.is_ascii_digit() {
                    raise PortInvalid
                  }
                  port_value = port_value * 10 + (ch.to_int() - '0').to_uint64()
                  if port_value > 65535 {
                    raise PortOutOfRange
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
              let host = Host::parse(buffer_str, is_opaque=!url.is_special())
              url.host = Some(host)
            }
          } else {
            // No port, just parse as host
            let host = Host::parse(buffer_str, is_opaque=!url.is_special())
            url.host = Some(host)
          }
        }
      }
      Host | Hostname => {
        if url.is_special() && buffer.is_empty() {
          raise HostMissing
        }
        if has_state_override &&
          buffer.is_empty() &&
          (
            !url.username.is_empty() ||
            !url.password.is_empty() ||
            url.port is Some(_)
          ) {
          raise HostMissing
        }
        if !buffer.is_empty() {
          let host = Host::parse(
            buffer.to_string(),
            is_opaque=!url.is_special(),
          )
          url.host = Some(host)
        } else if !url.is_special() {
          url.host = Some(Opaque(""))
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
              raise PortOutOfRange
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
          raise PortInvalid
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
          url.host = Some(Opaque(""))
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
            url.host = Some(Opaque(""))
            let letter = buffer_str.get_char(0).unwrap()
            url.path = Segments(["\{letter}:"])
          } else {
            let host = Host::parse(buffer_str)
            if host is Domain("localhost") {
              url.host = Some(Opaque(""))
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
          url.host = Some(Opaque(""))
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
          url.host = Some(Opaque(""))
        }
      }
      PathOrAuthority =>
        // At EOF in PathOrAuthority state - we consumed the '/' after scheme
        // Set path to "/" for URLs like "foo:/"
        url.path = Segments([""])
      SpecialAuthoritySlashes | SpecialAuthorityIgnoreSlashes =>
        // At EOF waiting for authority - special URLs require host
        raise HostMissing
      _ => ()
    }
    break // Exit outer loop after successful EOF handling
  }
  url
}
