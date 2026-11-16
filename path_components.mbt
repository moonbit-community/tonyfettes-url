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
