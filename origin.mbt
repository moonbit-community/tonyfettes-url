///|
/// A URL-derived origin. File and unsupported schemes produce opaque origins.
/// No identity is attached to opaque origins; they never compare same-origin.
pub enum Origin {
  Opaque
  Tuple(scheme~ : String, host~ : Host, port~ : UInt16?)
}

///|
/// Compare tuple origins by scheme, serialized host and port. Opaque origins
/// are never same-origin, even when both arguments are the same value.
pub fn Origin::is_same_origin(self : Origin, other : Origin) -> Bool {
  guard (self, other) is (Tuple(..) as left, Tuple(..) as right) else { false }
  left.scheme == right.scheme &&
  left.host.to_string() == right.host.to_string() &&
  left.port == right.port
}

///|
/// Serialize a tuple origin, or return `"null"` for an opaque origin.
pub fn Origin::to_string(self : Origin) -> String {
  match self {
    Opaque => "null"
    Tuple(scheme~, host~, port~) => {
      let port = port.map(p => ":\{p}").unwrap_or("")
      "\{scheme}://\{host.to_string()}\{port}"
    }
  }
}

///|
/// Return a structured origin. Blob URLs derive it from their embedded URL
/// when its scheme is http, https or file; there is no blob URL store here.
/// The legacy string-returning `origin()` keeps its original behavior.
pub fn Url::get_origin(self : Url) -> Origin {
  match self.scheme {
    "blob" => {
      guard Url::try_parse(self.path.to_string()) is Some(inner) else { Opaque }
      match inner.scheme {
        "http" | "https" | "file" => inner.get_origin()
        _ => Opaque
      }
    }
    "ftp" | "http" | "https" | "ws" | "wss" => {
      guard self.host is Some(host) else { Opaque }
      Tuple(scheme=self.scheme, host~, port=self.port)
    }
    _ => Opaque
  }
}
