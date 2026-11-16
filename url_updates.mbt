///|
/// An invalid component or a component incompatible with the URL being updated.
/// New `with_*` methods fail explicitly; legacy setters keep their old behavior.
#derive(Eq, Debug)
pub suberror UpdateError {
  InvalidScheme
  SpecialSchemeMismatch
  HostRequired
  HostKindMismatch
  InvalidHost
  HasOpaquePath
  CannotHaveCredentialsOrPort
  InvalidPath
}

///|
/// Copy all mutable URL storage. Strings and host values have no public
/// mutation API and can be shared; path arrays must be copied for old setters.
fn Url::copy_for_update(self : Url) -> Url {
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
/// The scheme without its trailing colon.
pub fn Url::get_scheme(self : Url) -> String {
  self.scheme
}

///|
/// The encoded username.
pub fn Url::get_username(self : Url) -> String {
  self.username
}

///|
/// The encoded password.
pub fn Url::get_password(self : Url) -> String {
  self.password
}

///|
/// The host, excluding the port; `None` means there is no host.
pub fn Url::get_host(self : Url) -> Host? {
  self.host
}

///|
/// The explicit port; default ports are absent on parsed URLs.
pub fn Url::get_port(self : Url) -> UInt16? {
  self.port
}

///|
/// A snapshot of the path. Special URLs with an implicit root expose `[""]`.
pub fn Url::get_path(self : Url) -> Path {
  match self.path {
    Segments([]) if self.is_special() => Segments([""])
    _ => self.path.clone()
  }
}

///|
/// Encoded query content; absent and present-but-empty queries are distinct.
pub fn Url::get_query(self : Url) -> Query? {
  self.query.map(value => Query(value))
}

///|
/// Encoded fragment content, excluding the `#` delimiter.
pub fn Url::get_fragment(self : Url) -> Fragment? {
  self.fragment.map(value => Fragment(value))
}

///|
/// A detached, mutable set of form-encoded search parameters.
pub fn Url::get_search_params(self : Url) -> UrlSearchParams {
  self.search_params()
}

///|
fn Url::check_credentials_or_port(self : Url) -> Unit raise UpdateError {
  if has_empty_host(self.host) ||
    self.scheme == "file" ||
    self.path is Opaque(_) {
    raise CannotHaveCredentialsOrPort
  }
}

///|
/// Return an independent copy with a validated, lowercased scheme (no colon).
/// Special and non-special schemes cannot be exchanged. Unlike `set_protocol`,
/// invalid updates raise and no suffix or parser-ignored whitespace is accepted.
pub fn Url::with_scheme(self : Url, scheme : String) -> Url raise UpdateError {
  guard scheme[:] is [first, .. rest] && first.is_ascii_alphabetic() else {
    raise InvalidScheme
  }
  for c in rest {
    guard c is ('a'..<='z' | 'A'..<='Z' | '0'..<='9' | '+' | '-' | '.') else {
      raise InvalidScheme
    }
  }
  let scheme = scheme.to_lower()
  if is_special_scheme(scheme) != self.is_special() {
    raise SpecialSchemeMismatch
  }
  let url = self.copy_for_update()
  if scheme == self.scheme {
    return url
  }
  if scheme == "file" &&
    (self.username != "" || self.password != "" || self.port is Some(_)) {
    raise CannotHaveCredentialsOrPort
  }
  if self.scheme == "file" && has_empty_host(self.host) {
    raise HostRequired
  }
  url.scheme = scheme
  if url.port == default_port(scheme) {
    url.port = None
  }
  url
}

///|
/// Return a copy with a userinfo-encoded username, preserving percent escapes.
pub fn Url::with_username(
  self : Url,
  username : String,
) -> Url raise UpdateError {
  self.check_credentials_or_port()
  let url = self.copy_for_update()
  url.set_username(username)
  url
}

///|
/// Return a copy with a userinfo-encoded password, preserving percent escapes.
pub fn Url::with_password(
  self : Url,
  password : String,
) -> Url raise UpdateError {
  self.check_credentials_or_port()
  let url = self.copy_for_update()
  url.set_password(password)
  url
}

///|
/// Replace only the host, preserving the port. Public string-backed host
/// variants are validated and normalized before use. `None` removes the host
/// only on non-special hierarchical URLs without credentials or a port.
pub fn Url::with_host(self : Url, host : Host?) -> Url raise UpdateError {
  guard self.path is Segments(_) else { raise HasOpaquePath }
  let normalized : Host? = match host {
    None => {
      if self.is_special() {
        raise HostRequired
      }
      None
    }
    Some(value) => {
      match value {
        Opaque("") => ()
        Opaque(_) if self.is_special() => raise HostKindMismatch
        Domain(_) | IPv4(_) if !self.is_special() => raise HostKindMismatch
        _ => ()
      }
      let serialized = value.to_string()
      if serialized.is_empty() {
        if self.is_special() && self.scheme != "file" {
          raise HostRequired
        }
        Some(Opaque(""))
      } else {
        let parsed = Host::parse(serialized, is_opaque=!self.is_special()) catch {
          _ => raise InvalidHost
        }
        if self.scheme == "file" && parsed is Domain("localhost") {
          Some(Opaque(""))
        } else {
          Some(parsed)
        }
      }
    }
  }
  if has_empty_host(normalized) &&
    (self.username != "" || self.password != "" || self.port is Some(_)) {
    raise CannotHaveCredentialsOrPort
  }
  let url = self.copy_for_update()
  url.host = normalized
  if normalized is None && url.path is Segments([]) {
    url.path = Segments([""])
  }
  url
}

///|
/// Return a copy with a port, or remove it with `None`. The scheme's default
/// port is normalized to `None`. Hostless, empty-host and file URLs reject ports.
pub fn Url::with_port(self : Url, port : UInt16?) -> Url raise UpdateError {
  self.check_credentials_or_port()
  let url = self.copy_for_update()
  url.port = if port == default_port(self.scheme) { None } else { port }
  url
}

///|
/// Replace a typed path without re-encoding it. Scheme-specific normalization
/// resolves dot segments and file drive letters. Opaque paths require a
/// non-special URL without a host and cannot start with `/`.
pub fn Url::with_path(self : Url, path : Path) -> Url raise UpdateError {
  if path is Opaque(text) {
    if self.is_special() || self.host is Some(_) || text.has_prefix("/") {
      raise InvalidPath
    }
  }
  let url = self.copy_for_update()
  url.path = path.clone()
  if path is Segments([]) && (self.is_special() || self.host is None) {
    url.path = Segments([""])
  }
  // Use the existing parser for context-dependent path normalization, without
  // changing the other components or sharing the parsed path with the caller.
  guard Url::try_parse(url.to_string()) is Some(parsed) &&
    parsed.path.is_opaque() == path.is_opaque() &&
    parsed.host.map(h => h.to_string()) == url.host.map(h => h.to_string()) else {
    raise InvalidPath
  }
  url.path = parsed.path
  url
}

///|
/// Parse a pathname on an independent copy, resolving dot segments and file
/// drive letters. Existing percent escapes are preserved. Opaque URLs reject it.
pub fn Url::with_pathname(
  self : Url,
  pathname : String,
) -> Url raise UpdateError {
  guard self.path is Segments(_) else { raise HasOpaquePath }
  let url = self.copy_for_update()
  url.set_pathname(pathname)
  url
}

///|
/// Replace an encoded query without re-encoding percent escapes. Apostrophes
/// are additionally encoded for special schemes. `None` removes the query;
/// `Some(Query::parse(""))` preserves a bare `?`.
///
/// ```mbt check
/// test {
///   let original = @url.Url::parse("https://example.com/a")
///   let updated = original.with_query(
///     Some(@url.Query::from_text("q=hello world")),
///   )
///   inspect(original.to_string(), content="https://example.com/a")
///   inspect(updated.to_string(), content="https://example.com/a?q=hello%20world")
/// }
/// ```
pub fn Url::with_query(self : Url, query : Query?) -> Url {
  let url = self.copy_for_update()
  url.query = query.map(value => {
    if self.is_special() {
      utf8_percent_encode(value.0, special_query_percent_encode_set)
    } else {
      value.0
    }
  })
  url.strip_opaque_trailing_spaces()
  url
}

///|
/// Replace an encoded fragment, without re-encoding it. `None` removes it;
/// a present empty fragment preserves a bare `#`.
pub fn Url::with_fragment(self : Url, fragment : Fragment?) -> Url {
  let url = self.copy_for_update()
  url.fragment = fragment.map(value => value.0)
  url.strip_opaque_trailing_spaces()
  url
}

///|
/// Replace the query with form-encoded parameters. The mutable parameter
/// collection is serialized immediately and is not retained.
pub fn Url::with_search_params(self : Url, params : UrlSearchParams) -> Url {
  let url = self.copy_for_update()
  url.set_search_params(params)
  url.strip_opaque_trailing_spaces()
  url
}

///|
fn Url::strip_opaque_trailing_spaces(self : Url) -> Unit {
  if self.query is None && self.fragment is None && self.path is Opaque(text) {
    let text = for text = text[:] {
      match text {
        [.. rest, ' '] => continue rest
        _ => break text
      }
    }
    self.path = Opaque(text.to_owned())
  }
}
