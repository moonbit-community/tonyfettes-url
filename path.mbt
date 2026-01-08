///|
enum Path {
  Opaque(String)
  Segments(Array[String])
}

///|
/// Serialize path per WHATWG URL spec
fn Path::to_string(self : Path) -> String {
  match self {
    Opaque(path) => path
    Segments(segments) => {
      if segments.is_empty() {
        ""
      } else {
        "/" + segments.iter().map(fn(s) { s }).join("/")
      }
    }
  }
}

///|
fn Path::shorten(self : Path) -> Unit {
  match self {
    Opaque(_) => ()
    Segments(segments) => if !segments.is_empty() { segments.pop() |> ignore() }
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
