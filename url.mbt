///|
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
pub fn Url::parse(
  input : String,
  base? : Url,
) -> Url? {
  let url = Url::new()
  let validation_errors : Array[ValidationError] = []
  Url::parse_basic(url, base?, input, validation_errors~)
}

///|
/// Serialize URL to string per WHATWG URL spec
pub fn Url::to_string(self : Url) -> String {
  let result = StringBuilder::new()
  // Scheme
  result.write_string(self.scheme)
  result.write_char(':')
  // Authority (if host is present)
  match self.host {
    Some(host) => {
      result.write_string("//")
      // Userinfo
      if !self.username.is_empty() || !self.password.is_empty() {
        result.write_string(self.username)
        if !self.password.is_empty() {
          result.write_char(':')
          result.write_string(self.password)
        }
        result.write_char('@')
      }
      // Host
      result.write_string(host.to_string())
      // Port
      match self.port {
        Some(port) => {
          result.write_char(':')
          result.write_string(port.to_string())
        }
        None => ()
      }
    }
    None => {
      // For file scheme without host, still include //
      if self.scheme == "file" {
        result.write_string("//")
      }
    }
  }
  // Path
  match self.path {
    Opaque(path) => result.write_string(path)
    Segments(segments) => {
      // Per WHATWG: If host is non-null, path is empty, and URL is special, append "/"
      if segments.is_empty() && self.host is Some(_) && self.is_special() {
        result.write_char('/')
      } else {
        for segment in segments {
          result.write_char('/')
          result.write_string(segment)
        }
      }
    }
  }
  // Query
  match self.query {
    Some(query) => {
      result.write_char('?')
      result.write_string(query)
    }
    None => ()
  }
  // Fragment
  match self.fragment {
    Some(fragment) => {
      result.write_char('#')
      result.write_string(fragment)
    }
    None => ()
  }
  result.to_string()
}

///|
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
pub fn Url::get_username(self : Url) -> String {
  self.username
}

///|
/// Get the password
pub fn Url::get_password(self : Url) -> String {
  self.password
}

///|
/// Get the host (hostname + ":" + port if port is present)
pub fn Url::get_host(self : Url) -> String {
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
pub fn Url::get_port(self : Url) -> String {
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
/// Set the protocol (scheme)
pub fn Url::set_protocol(self : Url, protocol : String) -> Unit {
  // Parse the scheme from protocol string (strip trailing ":" if present)
  let scheme = match protocol[:] {
    [.. scheme, ':'] => scheme.to_string()
    _ => protocol
  }
  // Validate scheme: must start with ASCII letter, followed by ASCII alphanumeric, +, -, or .
  match scheme[:] {
    [c, .. rest] if c.is_ascii_alphabetic() => {
      for ch in rest {
        if !(is_ascii_alphanumeric(ch) || ch is ('+' | '-' | '.')) {
          return // Invalid scheme, don't update
        }
      }
      self.scheme = scheme.to_lower()
    }
    _ => () // Invalid scheme, don't update
  }
}

///|
/// Set the username
pub fn Url::set_username(self : Url, username : String) -> Unit {
  if self.host is None || self.host is Some(Opaque("")) {
    return // Cannot set username without a host
  }
  if self.scheme == "file" {
    return // file: URLs don't have username
  }
  self.username = utf8_percent_encode(username, userinfo_percent_encode_set)
}

///|
/// Set the password
pub fn Url::set_password(self : Url, password : String) -> Unit {
  if self.host is None || self.host is Some(Opaque("")) {
    return // Cannot set password without a host
  }
  if self.scheme == "file" {
    return // file: URLs don't have password
  }
  self.password = utf8_percent_encode(password, userinfo_percent_encode_set)
}

///|
/// Set the host (hostname and optional port)
pub fn Url::set_host(self : Url, host_str : String) -> Unit {
  if self.path is Opaque(_) {
    return // Cannot set host for opaque path URLs
  }
  // Parse host:port
  let host = try Host::parse(host_str, is_opaque=!self.is_special()) catch {
    _ => return // Invalid host
  }
  self.host = Some(host)
}

///|
/// Set the hostname (without port)
pub fn Url::set_hostname(self : Url, hostname : String) -> Unit {
  if self.path is Opaque(_) {
    return // Cannot set hostname for opaque path URLs
  }
  let host = try Host::parse(hostname, is_opaque=!self.is_special()) catch {
    _ => return // Invalid hostname
  }
  self.host = Some(host)
}

///|
/// Set the port
pub fn Url::set_port(self : Url, port_str : String) -> Unit {
  if self.host is None || self.path is Opaque(_) {
    return
  }
  if self.scheme == "file" {
    return // file: URLs don't have port
  }
  if port_str.is_empty() {
    self.port = None
    return
  }
  // Parse port number
  let mut port_value : UInt64 = 0
  for ch in port_str {
    if !ch.is_ascii_digit() {
      return // Invalid port
    }
    port_value = port_value * 10 + (ch.to_int() - '0').to_uint64()
    if port_value > 65535 {
      return // Port out of range
    }
  }
  let port_u16 = port_value.to_uint16()
  // Set to None if it's the default port
  self.port = if default_port(self.scheme) is Some(default) && port_u16 == default {
    None
  } else {
    Some(port_u16)
  }
}

///|
/// Set the pathname
pub fn Url::set_pathname(self : Url, pathname : String) -> Unit {
  if self.path is Opaque(_) {
    return // Cannot set pathname for opaque path URLs
  }
  // Clear and re-parse path
  self.path = Segments([])
  // Simple path parsing: split by "/" and add segments
  let segments = pathname.split("/").collect()
  for segment in segments {
    if segment.is_empty() {
      continue
    }
    match self.path {
      Segments(segs) => segs.push(utf8_percent_encode(segment, path_percent_encode_set))
      _ => ()
    }
  }
}

///|
/// Set the search (query string)
pub fn Url::set_search(self : Url, search : String) -> Unit {
  if search.is_empty() {
    self.query = None
    return
  }
  // Strip leading "?" if present
  let query = match search[:] {
    ['?', .. rest] => rest
    _ => search[:]
  }
  self.query = Some(utf8_percent_encode(query.to_string(), query_percent_encode_set))
}

///|
/// Set the hash (fragment)
pub fn Url::set_hash(self : Url, hash : String) -> Unit {
  if hash.is_empty() {
    self.fragment = None
    return
  }
  // Strip leading "#" if present
  let fragment = match hash[:] {
    ['#', .. rest] => rest
    _ => hash[:]
  }
  self.fragment = Some(utf8_percent_encode(fragment.to_string(), fragment_percent_encode_set))
}

///|
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
fn is_ascii_hex_digit(c : Char) -> Bool {
  c is ('0'..='9' | 'a'..='f' | 'A'..='F')
}

///|
fn is_ascii_alphanumeric(c : Char) -> Bool {
  c is ('0'..='9' | 'a'..='z' | 'A'..='Z')
}

///|
fn is_special_scheme(scheme : StringView) -> Bool {
  match scheme {
    "ftp" | "file" | "http" | "https" | "ws" | "wss" => true
    _ => false
  }
}

///|
priv enum State {
  SchemeStart
  Scheme
  NoScheme
  File
  FileSlash
  FileHost
  Relative
  RelativeSlash
  SpecialRelativeOrAuthority
  SpecialAuthorityIgnoreSlashes
  SpecialAuthoritySlashes
  PathOrAuthority
  Authority
  Host
  Port
  PathStart
  Path
  OpaquePath
  Query
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
      for view = before; ; {
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
fn Url::parse_basic(
  url : Url,
  base? : Url,
  input : StringView,
  validation_errors? : Array[ValidationError] = [],
) -> Url? {
  let mut state : State = SchemeStart
  let buffer : StringBuilder = StringBuilder::new()
  let mut at_sign_seen : Bool = false
  let mut inside_brackets : Bool = false
  let mut password_token_seen : Bool = false
  // Per WHATWG: 1. Remove leading/trailing C0 control or space
  //             2. Remove all ASCII tab or newline from entire input
  let input = trim_c0_control_or_space(input)
  let input = remove_ascii_tab_or_newline(input)
  let pointer = StringPointer::new(input[:])
  // Outer loop for restart mechanism (WHATWG "start over")
  while true {
    for view = pointer.view(); view is [c, .. remaining]; view = pointer.next() {
    match state {
      SchemeStart =>
        if c.is_ascii_alphabetic() {
          buffer.write_char(c.to_ascii_lowercase())
          state = Scheme
        } else {
          state = NoScheme
          continue view // Re-process same character in NoScheme
        }
      Scheme =>
        match c {
          'a'..='z' | 'A'..='Z' | '0'..='9' | '+' | '-' | '.' =>
            buffer.write_char(c.to_ascii_lowercase())
          ':' => {
            url.scheme = buffer.to_string()
            buffer.reset()
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
          _ => {
            buffer.reset()
            state = NoScheme
            pointer.start_over()
            continue pointer.view()
          }
        }
      NoScheme =>
        match base {
          None | Some({ path: Opaque(_), .. }) if !(c is '#') => {
            validation_errors.push(MissingSchemeNonRelativeUrl)
            return None
          }
          Some({ path: Opaque(_), .. } as base) if c is '#' => {
            url.scheme = base.scheme
            url.path = base.path.clone()
            url.query = base.query
            url.fragment = Some("")
            state = Fragment
          }
          Some({ scheme, .. }) if scheme != "file" => {
            state = Relative
            continue view // Re-process same character in Relative
          }
          _ => {
            state = File
            continue view // Re-process same character in File
          }
        }
      SpecialRelativeOrAuthority =>
        if c is '/' && remaining.has_prefix("/") {
          state = SpecialAuthorityIgnoreSlashes
          pointer.increase()
        } else {
          validation_errors.push(SpecialSchemeMissingFollowingSolidus)
          state = Relative
          continue view // Re-process same character in Relative
        }
      PathOrAuthority =>
        if c is '/' {
          state = Authority
        } else {
          state = Path
          continue view // Re-process same character in Path
        }
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
            url.path.shorten()
            state = Path
            continue view // Re-process same character in Path
          }
        }
      }
      RelativeSlash => {
        guard base is Some(base) else {
          abort("base must be Some(base) in RelativeSlash state")
        }
        if url.is_special() && c is ('/' | '\\') {
          if c is '/' {
            validation_errors.push(InvalidReverseSolidus)
          }
          state = SpecialAuthorityIgnoreSlashes
        } else if c is '/' {
          state = Authority
        } else {
          url.username = base.username
          url.password = base.password
          url.host = base.host
          url.port = base.port
          state = Path
          continue view // Re-process same character in Path
        }
      }
      SpecialAuthoritySlashes =>
        if c is '/' && remaining.has_prefix("/") {
          state = SpecialAuthorityIgnoreSlashes
          pointer.increase()
        } else {
          validation_errors.push(SpecialSchemeMissingFollowingSolidus)
          state = SpecialAuthorityIgnoreSlashes
          continue view // Re-process same character
        }
      SpecialAuthorityIgnoreSlashes =>
        if !(c is ('/' | '\\')) {
          state = Authority
          continue view // Re-process same character in Authority
        } else {
          validation_errors.push(SpecialSchemeMissingFollowingSolidus)
        }
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
      Host =>
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
          let host = try Host::parse(buffer.to_string(), is_opaque=!url.is_special()) catch {
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
          if buffer.is_empty() {
            url.host = Some(Host::Opaque(""))
          } else {
            let host = try Host::parse(buffer.to_string(), is_opaque=!url.is_special()) catch {
              err => {
                validation_errors.push(err)
                return None
              }
            }
            url.host = Some(host)
          }
          buffer.reset()
          state = PathStart
        } else {
          buffer.write_char(c)
        }
      Port => {
        if c.is_ascii_digit() {
          buffer.write_char(c)
        } else if c is ('/' | '?' | '#') || (url.is_special() && c is '\\') {
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
          }
          state = PathStart
          pointer.decrease()
        } else {
          // Invalid port character
          return None
        }
      }
      PathStart =>
        if url.is_special() {
          if c is '\\' {
            validation_errors.push(InvalidReverseSolidus)
          }
          state = Path
          if !(c is ('/' | '\\')) {
            pointer.decrease()
          }
        } else if c is '?' {
          url.query = Some("")
          state = Query
        } else if c is '#' {
          url.fragment = Some("")
          state = Fragment
        } else {
          state = Path
          if !(c is '/') {
            pointer.decrease()
          }
        }
      Path => {
        if c is ('/' | '?'| '#') || (url.is_special() && c is '\\') {
          if url.is_special() && c is '\\' {
            validation_errors.push(InvalidReverseSolidus)
          }
          let buffer_str = buffer.to_string()
          // Handle . and .. path segments
          if buffer_str == ".." || buffer_str.to_lower() is ("..%2e" | ".%2e." | "%2e.." | "%2e%2e") {
            url.path.shorten()
            if !(c is ('/' | '\\')) {
              match url.path {
                Segments(segments) => segments.push("")
                _ => ()
              }
            }
          } else if buffer_str == "." || buffer_str.to_lower() is (".%2e" | "%2e.") {
            if !(c is ('/' | '\\')) {
              match url.path {
                Segments(segments) => segments.push("")
                _ => ()
              }
            }
          } else {
            if url.scheme == "file" && url.path is Segments(segments) && segments.is_empty() {
              // Windows drive letter check
              if buffer_str.length() == 2 {
                match buffer_str {
                  [letter, ':' | '|'] if letter.is_ascii_alphabetic() => {
                    // Normalize Windows drive letter
                    let normalized = "\{letter.to_ascii_uppercase()}:"
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
              Segments(segments) => segments.push(utf8_percent_encode(buffer_str, path_percent_encode_set))
              Opaque(s) => url.path = Opaque(s + "/" + utf8_percent_encode(buffer_str, path_percent_encode_set))
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
        } else {
          // Percent-encode if needed
          if c is '%' {
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
        }
      }
      OpaquePath => {
        if c is '?' {
          url.query = Some("")
          state = Query
        } else if c is '#' {
          url.fragment = Some("")
          state = Fragment
        } else {
          match url.path {
            Opaque(s) => {
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
            }
            _ => ()
          }
        }
      }
      Query => {
        if c is '#' {
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
            Some(q) => {
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
            }
            None => ()
          }
        }
      }
      Fragment =>
        match url.fragment {
          Some(f) => {
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
          }
          None => ()
        }
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
            // Check for Windows drive letter
            let starts_with_drive = match remaining {
              [letter, ':' | '|', .. rest] if letter.is_ascii_alphabetic() =>
                rest is ([] | ['/' | '\\' | '?' | '#', ..])
              _ => false
            }
            if !starts_with_drive {
              url.path.shorten()
            } else {
              url.path = Segments([])
            }
            state = Path
            pointer.decrease()
          }
        } else {
          state = Path
          pointer.decrease()
        }
      }
      FileSlash => {
        url.scheme = "file"
        if c is ('/' | '\\') {
          if c is '\\' {
            validation_errors.push(InvalidReverseSolidus)
          }
          state = FileHost
        } else {
          if base is Some(base) && base.scheme == "file" {
            url.host = base.host
            // Check for Windows drive letter
            match base.path {
              Segments([drive, ..]) if drive.length() == 2 => {
                match drive {
                  [letter, ':'] if letter.is_ascii_alphabetic() =>
                    url.path = Segments([drive])
                  _ => ()
                }
              }
              _ => ()
            }
          }
          state = Path
          pointer.decrease()
        }
      }
      FileHost => {
        url.scheme = "file"
        if c is ('/' | '\\' | '?' | '#') {
          pointer.decrease()
          // Check for Windows drive letter
          let buffer_str = buffer.to_string()
          if buffer_str.length() == 2 {
            match buffer_str {
              [letter, ':' | '|'] if letter.is_ascii_alphabetic() => {
                // It's a Windows drive letter, not a host
                state = Path
              }
              _ => {
                if buffer_str.is_empty() {
                  url.host = Some(Host::Opaque(""))
                  state = PathStart
                } else {
                  let host = try Host::parse(buffer_str) catch {
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
            }
          } else if buffer_str.is_empty() {
            url.host = Some(Host::Opaque(""))
            state = PathStart
          } else {
            let host = try Host::parse(buffer_str) catch {
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
        validation_errors.push(MissingSchemeNonRelativeUrl)
        return None
      }
      Scheme => {
        // EOF in Scheme state without finding ':' - try as NoScheme if base exists
        if base is Some(_) {
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
      }
    Authority => {
      // At EOF in Authority state - buffer contains host (no @ was seen)
      // or remaining host after @
      if at_sign_seen && buffer.is_empty() {
        validation_errors.push(HostMissing)
        return None
      }
      if !at_sign_seen {
        // No @ was seen, so buffer is the host
        if buffer.is_empty() {
          if url.is_special() {
            validation_errors.push(HostMissing)
            return None
          }
          url.host = Some(Host::Opaque(""))
        } else {
          let host = try Host::parse(buffer.to_string(), is_opaque=!url.is_special()) catch {
            err => {
              validation_errors.push(err)
              return None
            }
          }
          url.host = Some(host)
        }
      } else {
        // @ was seen but buffer still has content - this is the host part
        if buffer.is_empty() {
          if url.is_special() {
            validation_errors.push(HostMissing)
            return None
          }
          url.host = Some(Host::Opaque(""))
        } else {
          let host = try Host::parse(buffer.to_string(), is_opaque=!url.is_special()) catch {
            err => {
              validation_errors.push(err)
              return None
            }
          }
          url.host = Some(host)
        }
      }
    }
    Host => {
      if url.is_special() && buffer.is_empty() {
        validation_errors.push(HostMissing)
        return None
      }
      if !buffer.is_empty() {
        let host = try Host::parse(buffer.to_string(), is_opaque=!url.is_special()) catch {
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
    Port => {
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
      }
    }
    Path => {
      let buffer_str = buffer.to_string()
      if buffer_str == ".." || buffer_str.to_lower() is ("..%2e" | ".%2e." | "%2e.." | "%2e%2e") {
        url.path.shorten()
      } else if buffer_str == "." || buffer_str.to_lower() is (".%2e" | "%2e.") {
        // Do nothing for single dot at EOF
        ()
      } else {
        // Push segment (may be empty for trailing slash in non-special URLs)
        match url.path {
          Segments(segments) => segments.push(utf8_percent_encode(buffer_str, path_percent_encode_set))
          Opaque(s) => url.path = Opaque(s + "/" + utf8_percent_encode(buffer_str, path_percent_encode_set))
        }
      }
    }
    FileHost => {
      let buffer_str = buffer.to_string()
      if buffer_str.is_empty() {
        url.host = Some(Host::Opaque(""))
      } else {
        // Check for Windows drive letter
        if buffer_str.length() == 2 {
          match buffer_str {
            [letter, ':' | '|'] if letter.is_ascii_alphabetic() => {
              // Windows drive letter in host position
              url.path = Segments(["\{letter.to_ascii_uppercase()}:"])
            }
            _ => {
              let host = try Host::parse(buffer_str) catch {
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
        } else {
          let host = try Host::parse(buffer_str) catch {
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
    SpecialRelativeOrAuthority | Relative | RelativeSlash => {
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
    _ => ()
    }
    break // Exit outer loop after successful EOF handling
  }
  Some(url)
}
