///|
/// An origin per the HTML Standard.
/// See: https://html.spec.whatwg.org/multipage/browsers.html#concept-origin
///
/// An origin is either an opaque origin, or a tuple origin consisting of a
/// scheme, a host and a port. The tuple's fourth item, domain, is always null
/// for origins derived from a URL and is therefore omitted.
///
/// `Origin` deliberately does not implement `Eq`: an opaque origin is only
/// equal to itself, and a URL library has no identity to attach to it. Use
/// `Origin::is_same_origin` instead.
pub enum Origin {
  Opaque
  Tuple(scheme~ : String, host~ : Host, port~ : UInt16?)
}

///|
/// Whether two origins are same origin.
/// See: https://html.spec.whatwg.org/multipage/browsers.html#same-origin
///
/// Two tuple origins are same origin if their schemes, hosts and ports are
/// identical. An opaque origin is never same origin with anything, because
/// the spec creates a new opaque origin every time one is requested.
pub fn Origin::is_same_origin(self : Origin, other : Origin) -> Bool {
  guard (self, other) is (Tuple(..) as self, Tuple(..) as other) else { false }
  self.scheme == other.scheme &&
  self.host == other.host &&
  self.port == other.port
}

///|
/// Serialize an origin.
/// See: https://html.spec.whatwg.org/multipage/browsers.html#ascii-serialisation-of-an-origin
///
/// An opaque origin serializes to the string "null". A tuple origin serializes
/// to scheme, "://", host, and ":" followed by the port if it is non-null.
pub fn Origin::to_string(self : Origin) -> String {
  match self {
    Opaque => "null"
    Tuple(scheme~, host~, port~) => {
      let result = StringBuilder()
      result.write_string(scheme)
      result.write_string("://")
      result.write_string(host.to_string())
      if port is Some(port) {
        result.write_char(':')
        result.write_string(port.to_string())
      }
      result.to_string()
    }
  }
}

///|
pub impl Show for Origin with fn output(self : Origin, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}
