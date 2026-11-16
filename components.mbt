///|
/// An encoded query without its leading `?`. This preserves query syntax;
/// use `UrlSearchParams` when interpreting it as form-encoded name/value pairs.
#derive(Eq, Debug)
struct Query(String)

///|
/// Parse component text, preserving existing percent escapes and encoding
/// characters forbidden in a query. A leading `?` is part of the content.
/// Unlike the legacy search setter, tabs and newlines are encoded, not removed.
pub fn Query::parse(encoded : StringView) -> Query {
  Query(utf8_percent_encode(encoded.to_owned(), query_percent_encode_set))
}

///|
/// Encode unescaped query text. Literal `%` becomes `%25`; `+`, `&` and `=`
/// retain their query syntax. This is not form encoding.
pub fn Query::from_text(text : StringView) -> Query {
  Query(
    utf8_percent_encode(text.to_owned(), c => {
      c == '%' || query_percent_encode_set(c)
    }),
  )
}

///|
/// Return encoded content without a leading `?`.
pub fn Query::to_string(self : Query) -> String {
  self.0
}

///|
/// An encoded fragment without its leading `#`.
#derive(Eq, Debug)
struct Fragment(String)

///|
/// Parse component text, preserving percent escapes and encoding characters
/// forbidden in a fragment. A leading `#` is part of the content.
pub fn Fragment::parse(encoded : StringView) -> Fragment {
  Fragment(utf8_percent_encode(encoded.to_owned(), fragment_percent_encode_set))
}

///|
/// Encode unescaped fragment text, including literal `%` characters.
pub fn Fragment::from_text(text : StringView) -> Fragment {
  Fragment(
    utf8_percent_encode(text.to_owned(), c => {
      c == '%' || fragment_percent_encode_set(c)
    }),
  )
}

///|
/// Return encoded content without a leading `#`.
pub fn Fragment::to_string(self : Fragment) -> String {
  self.0
}

///|
/// Whether the path is a single opaque string rather than hierarchical segments.
pub fn Path::is_opaque(self : Path) -> Bool {
  self is Opaque(_)
}

///|
/// Iterate over encoded segments, or return `None` for an opaque path.
/// The iterator owns a snapshot, isolated from legacy URL mutations.
pub fn Path::segments(self : Path) -> Iter[String]? {
  match self {
    Opaque(_) => None
    Segments(segments) => Some(segments.copy().iter())
  }
}

///|
/// Build a hierarchical path from unescaped segments. Separators and literal
/// percent signs are encoded inside each segment. Dot segments are resolved
/// when the path is installed on a URL, using that URL's scheme-specific rules.
/// The caller's array is not retained.
pub fn Path::from_segments(segments : Array[String]) -> Path {
  Segments(
    segments.map(segment => {
      utf8_percent_encode(segment, c => {
        c == '%' || c == '/' || c == '\\' || path_percent_encode_set(c)
      })
    }),
  )
}

///|
/// Build an opaque path from unescaped text. `?`, `#`, spaces and literal `%`
/// are encoded. Installing it on a special URL or a URL with a host is rejected.
pub fn Path::from_opaque(text : StringView) -> Path {
  Opaque(
    utf8_percent_encode(text.to_owned(), c => {
      c == '%' ||
      c == '?' ||
      c == '#' ||
      c == ' ' ||
      c0_control_percent_encode_set(c)
    }),
  )
}
