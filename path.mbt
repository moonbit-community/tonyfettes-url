///|
/// URL path representation per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#url-path
/// A URL's path is either a URL path segment (opaque) or a list of URL path
/// segments (hierarchical).
enum Path {
  Opaque(String)
  Segments(Array[String])
} derive(Eq)

///|
/// Serialize path per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#url-path-serializer
pub fn Path::to_string(self : Path) -> String {
  match self {
    Opaque(path) => path
    Segments(segments) =>
      if segments.is_empty() {
        ""
      } else {
        "/" + segments.iter().map(fn(s) { s }).join("/")
      }
  }
}

///|
pub impl Show for Path with fn output(self : Path, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}

///|
/// Shorten a url's path per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#shorten-a-urls-path
/// To shorten a url's path:
/// 1. Assert: url does not have an opaque path.
/// 2. Let path be url's path.
/// 3. If url's scheme is "file", path's size is 1, and path[0] is a normalized
///    Windows drive letter, then return.
/// 4. Remove path's last item, if any.
fn Path::shorten(self : Path, scheme~ : String) -> Unit {
  match self {
    // 1. Assert: url does not have an opaque path
    Opaque(_) => ()
    Segments(segments) => {
      // 3. If scheme is "file" and path is a Windows drive letter, don't shorten
      if scheme == "file" && segments.length() == 1 {
        match segments.get(0) {
          Some(first) if first.length() == 2 =>
            match first {
              [letter, ':'] if letter.is_ascii_alphabetic() => return
              _ => ()
            }
          _ => ()
        }
      }
      // 4. Remove path's last item, if any
      if !segments.is_empty() {
        segments.pop() |> ignore()
      }
    }
  }
}

///|
/// Create a deep copy of the path
fn Path::clone(self : Path) -> Path {
  match self {
    Opaque(s) => Opaque(s)
    Segments(segments) => Segments(segments.copy())
  }
}
