///|
/// Represents a URL host per the WHATWG URL Standard.
/// See: https://url.spec.whatwg.org/#host-representation
/// Can be a domain name, IPv4 address, IPv6 address, or opaque string.
pub enum Host {
  Domain(String)
  IPv4(IPv4)
  IPv6(IPv6)
  Opaque(String)
} derive(ToJson)

///|
/// Serialize host per WHATWG URL spec
pub fn Host::to_string(self : Host) -> String {
  match self {
    Domain(domain) => domain
    IPv4(ipv4) => ipv4.to_string()
    IPv6(ipv6) => "[\{ipv6.to_string()}]"
    Opaque(opaque_) => opaque_
  }
}

///|
/// Implement Show trait for Host, outputting the serialized host string
pub impl Show for Host with fn output(self : Host, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}

///|
/// Convert host to Unicode form for display (Punycode → Unicode)
pub fn Host::to_unicode(self : Host) -> String {
  match self {
    Domain(domain) =>
      @idna.to_unicode(domain) catch {
        _ => domain // If IDNA conversion fails, return as-is
      }
    IPv4(ipv4) => ipv4.to_string()
    IPv6(ipv6) => "[\{ipv6.to_string()}]"
    Opaque(s) => s
  }
}

///|
/// URL parsing validation errors per the WHATWG URL Standard.
/// Each variant represents a specific parsing failure condition.
suberror ValidationError {
  DomainToAscii
  HostInvalidCodePoint
  IPv4EmptyPart
  IPv4TooManyParts
  IPv4NonNumericPart
  IPv4OutOfRangePart
  IPv6InvalidCompression
  IPv6MultipleCompression
  IPv6TooManyPieces
  IPv6InvalidCodePoint
  IPv6TooFewPieces
  IPv6Unclosed
  IPv4InIPv6InvalidCodePoint
  IPv4InIPv6TooManyPieces
  IPv4InIPv6OutOfRangePart
  IPv4InIPv6TooFewParts
  MissingSchemeNonRelativeUrl
  SpecialSchemeMissingFollowingSolidus
  InvalidReverseSolidus
  InvalidCredentials
  HostMissing
} derive(ToJson, Debug)

///|
pub impl Show for ValidationError with fn output(self, logger) {
  let message = match self {
    DomainToAscii => "DomainToAscii"
    HostInvalidCodePoint => "HostInvalidCodePoint"
    IPv4EmptyPart => "IPv4EmptyPart"
    IPv4TooManyParts => "IPv4TooManyParts"
    IPv4NonNumericPart => "IPv4NonNumericPart"
    IPv4OutOfRangePart => "IPv4OutOfRangePart"
    IPv6InvalidCompression => "IPv6InvalidCompression"
    IPv6MultipleCompression => "IPv6MultipleCompression"
    IPv6TooManyPieces => "IPv6TooManyPieces"
    IPv6InvalidCodePoint => "IPv6InvalidCodePoint"
    IPv6TooFewPieces => "IPv6TooFewPieces"
    IPv6Unclosed => "IPv6Unclosed"
    IPv4InIPv6InvalidCodePoint => "IPv4InIPv6InvalidCodePoint"
    IPv4InIPv6TooManyPieces => "IPv4InIPv6TooManyPieces"
    IPv4InIPv6OutOfRangePart => "IPv4InIPv6OutOfRangePart"
    IPv4InIPv6TooFewParts => "IPv4InIPv6TooFewParts"
    MissingSchemeNonRelativeUrl => "MissingSchemeNonRelativeUrl"
    SpecialSchemeMissingFollowingSolidus =>
      "SpecialSchemeMissingFollowingSolidus"
    InvalidReverseSolidus => "InvalidReverseSolidus"
    InvalidCredentials => "InvalidCredentials"
    HostMissing => "HostMissing"
  }
  logger.write_string(message)
}

///|
fn percent_decode_string(input : StringView) -> Bytes {
  let bytes = @encoding/utf8.encode(input, bom=false)
  return percent_decode_bytes(bytes)
}

///|
fn percent_decode_bytes(input : Bytes) -> Bytes {
  let output = Buffer()
  for view = input[:] {
    match view {
      [b'%', c0, c1, .. rest] => {
        let b0 = match c0 {
          b'0'..=b'9' => c0.to_int() - b'0'.to_int()
          b'a'..=b'f' => c0.to_int() - b'a'.to_int() + 10
          b'A'..=b'F' => c0.to_int() - b'A'.to_int() + 10
          _ => {
            output.write_byte(b'%')
            continue view[1:]
          }
        }
        let b1 = match c1 {
          b'0'..=b'9' => c1.to_int() - b'0'.to_int()
          b'a'..=b'f' => c1.to_int() - b'a'.to_int() + 10
          b'A'..=b'F' => c1.to_int() - b'A'.to_int() + 10
          _ => {
            output.write_byte(b'%')
            output.write_byte(c0)
            continue view[2:]
          }
        }
        output.write_byte(((b0 << 4) | b1).to_byte())
        continue rest
      }
      [byte, .. rest] => {
        output.write_byte(byte)
        continue rest
      }
      [] => break
    }
  }
  output.contents()
}

///|
/// Check if a string contains any forbidden domain code point per WHATWG URL spec
/// Forbidden domain code points = forbidden host code points + C0 controls + % + DEL
fn contains_forbidden_domain_codepoint(s : String) -> Bool {
  for c in s {
    // C0 controls (U+0000-U+001F) and DEL (U+007F)
    if c is ('\u{0000}'..='\u{001f}' | '\u{007f}') {
      return true
    }
    // Forbidden host code points plus %
    if c
      is (' '
      | '#'
      | '%'
      | '/'
      | ':'
      | '<'
      | '>'
      | '?'
      | '@'
      | '['
      | '\\'
      | ']'
      | '^'
      | '|') {
      return true
    }
  }
  false
}

///|
/// Parse a host string per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#host-parsing
/// Handles IPv4, IPv6 (in brackets), domain names with IDNA/Punycode, and opaque hosts.
///
/// The host parser takes a string input with an optional boolean isOpaque
/// (default false), and then runs these steps:
/// 1. If input starts with U+005B ([), then:
///    1.1. If input does not end with U+005D (]), IPv6-unclosed validation error,
///         return failure.
///    1.2. Return the result of IPv6 parsing input with its leading U+005B ([)
///         and trailing U+005D (]) removed.
/// 2. If isOpaque is true, then return the result of opaque-host parsing input.
/// 3. Assert: input is not the empty string.
/// 4. Let domain be the result of running UTF-8 decode without BOM on the
///    percent-decoding of input.
/// 5. Let asciiDomain be the result of running domain to ASCII with domain and false.
/// 6. If asciiDomain is failure, then return failure.
/// 7. If asciiDomain contains a forbidden domain code point, domain-invalid-code-point
///    validation error, return failure.
/// 8. If asciiDomain ends in a number, then return the result of IPv4 parsing asciiDomain.
/// 9. Return asciiDomain.
pub fn Host::parse(
  input : StringView,
  is_opaque? : Bool = false,
) -> Host raise ValidationError {
  match input {
    // 1. If input starts with U+005B ([)
    ['[', .. rest, ']'] => {
      // 1.2. Return the result of IPv6 parsing
      let ipv6 = IPv6::parse(rest)
      IPv6(ipv6)
    }
    ['[', ..] => raise IPv6Unclosed // 1.1. IPv6-unclosed validation error
    input => {
      // 2. If isOpaque is true, return the result of opaque-host parsing
      if is_opaque {
        let opaque_host = Host::parse_opaque(input)
        return Host::Opaque(opaque_host)
      }
      // 4. Let domain be the result of UTF-8 decode without BOM on percent-decoding of input
      let domain = @encoding/utf8.decode_lossy(percent_decode_string(input))
      // 5. Let asciiDomain be the result of running domain to ASCII
      // Per WHATWG, empty labels are allowed (unlike strict DNS/IDNA)
      let ascii_domain = @idna.to_ascii(
        domain,
        use_std3_ascii_rules=false,
        verify_dns_length=false,
      ) catch {
        @idna.EmptyLabel => {
          // Allow empty labels per WHATWG only if domain consists of
          // valid ASCII domain characters (intentional empty labels like "." or "..")
          // Reject if empty label comes from IDNA mapping (e.g., soft hyphen -> "")
          let is_valid_ascii_domain = domain
            .iter()
            .all(fn(c) {
              c.is_ascii_lowercase() ||
              c.is_ascii_uppercase() ||
              c.is_ascii_digit() ||
              c is ('.' | '-')
            })
          if is_valid_ascii_domain && !domain.is_empty() {
            domain
          } else {
            raise DomainToAscii
          }
        }
        _ => {
          // Per WHATWG: If IDNA fails but the string is ASCII and doesn't
          // contain forbidden domain code points, use it as-is
          // This allows hosts like `!"$&'()*+,-.;=_`{}~` which are valid per spec
          // BUT: domains containing "xn--" labels must be valid punycode - reject if IDNA fails
          let is_ascii = domain.iter().all(fn(c) { c.to_int() < 128 })
          let has_punycode_label = domain.to_lower().contains("xn--")
          if is_ascii &&
            !contains_forbidden_domain_codepoint(domain) &&
            !has_punycode_label {
            domain
          } else {
            raise DomainToAscii
          }
        }
      }
      // 7. If asciiDomain contains a forbidden domain code point, return failure
      if contains_forbidden_domain_codepoint(ascii_domain) {
        raise HostInvalidCodePoint
      }
      // 8. If asciiDomain ends in a number, return the result of IPv4 parsing
      if ends_in_a_number(ascii_domain) {
        return IPv4(IPv4::parse(ascii_domain))
      }
      // 9. Return asciiDomain
      return Domain(ascii_domain)
    }
  }
}

///|
/// Check if a string ends in a number per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#ends-in-a-number-checker
/// A string input ends in a number if:
/// 1. Let parts be the result of strictly splitting input on U+002E (.).
/// 2. If the last item in parts is the empty string, then:
///    2.1. If parts's size is 1, then return false.
///    2.2. Remove the last item from parts.
/// 3. Let last be the last item in parts.
/// 4. If last is non-empty and contains only ASCII digits, then return true.
/// 5. If parsing last as an IPv4 number does not return failure, then return true.
/// 6. Return false.
fn ends_in_a_number(input : StringView) -> Bool {
  let parts = input.split(".").collect()
  match parts {
    [] | [""] => return false
    [.., last, ""] | [.., last] => {
      if last is "" {
        return false
      }
      match last {
        ['0', 'x' | 'X', .. last] =>
          for c in last {
            if c is ('0'..='9' | 'a'..='f' | 'A'..='F') {
              continue
            } else {
              return false
            }
          } nobreak {
            return true
          }
        ['0'..='9', .. last] =>
          for c in last {
            if c is ('0'..='9') {
              continue
            } else {
              return false
            }
          } nobreak {
            return true
          }
        _ => return false
      }
    }
  }
}

///|
/// Parse an opaque host per WHATWG URL spec
/// Only rejects forbidden host code points, accepts everything else
fn Host::parse_opaque(input : StringView) -> String raise ValidationError {
  // Check for forbidden host code points
  for c in input {
    if c
      is ('\u{0000}'
      | '\u{0009}'
      | '\u{000a}'
      | '\u{000d}'
      | ' '
      | '#'
      | '/'
      | ':'
      | '<'
      | '>'
      | '?'
      | '@'
      | '['
      | '\\'
      | ']'
      | '^'
      | '|') {
      raise HostInvalidCodePoint
    }
  }
  // Percent-encode C0 controls in the output
  utf8_percent_encode(input, c0_control_percent_encode_set)
}

///|
let hex_digits : ReadOnlyArray[Char] = [
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
]

///|
/// C0 control percent-encode set.
/// See: https://url.spec.whatwg.org/#c0-control-percent-encode-set
/// The C0 control percent-encode set are the C0 controls and all code points
/// greater than U+007E (~).
fn c0_control_percent_encode_set(char : Char) -> Bool {
  return char is ('\u{0000}'..='\u{001f}' | '\u{007f}'..<_)
}

///|
/// Query percent-encode set.
/// See: https://url.spec.whatwg.org/#query-percent-encode-set
/// The query percent-encode set is the C0 control percent-encode set and
/// U+0020 SPACE, U+0022 ("), U+0023 (#), U+003C (<), and U+003E (>).
fn query_percent_encode_set(char : Char) -> Bool {
  return char
    is ('\u{0000}'..='\u{001f}' | '\u{007f}'..<_ | ' ' | '"' | '#' | '<' | '>')
}

///|
/// Special-query percent-encode set.
/// See: https://url.spec.whatwg.org/#special-query-percent-encode-set
/// The special-query percent-encode set is the query percent-encode set and
/// U+0027 (').
fn special_query_percent_encode_set(char : Char) -> Bool {
  return char
    is ('\u{0000}'..='\u{001f}'
    | '\u{007f}'..<_
    | ' '
    | '"'
    | '#'
    | '<'
    | '>'
    | '\'')
}

///|
/// Fragment percent-encode set.
/// See: https://url.spec.whatwg.org/#fragment-percent-encode-set
/// The fragment percent-encode set is the C0 control percent-encode set and
/// U+0020 SPACE, U+0022 ("), U+003C (<), U+003E (>), and U+0060 (`).
fn fragment_percent_encode_set(char : Char) -> Bool {
  return char
    is ('\u{0000}'..='\u{001f}' | '\u{007f}'..<_ | ' ' | '"' | '<' | '>' | '`')
}

///|
/// Path percent-encode set.
/// See: https://url.spec.whatwg.org/#path-percent-encode-set
/// The path percent-encode set is the query percent-encode set and
/// U+003F (?), U+0060 (`), U+007B ({), and U+007D (}).
fn path_percent_encode_set(char : Char) -> Bool {
  return char
    is ('\u{0000}'..='\u{001f}'
    | '\u{007f}'..<_
    | ' '
    | '"'
    | '#'
    | '<'
    | '>'
    | '?'
    | '^'
    | '`'
    | '{'
    | '}')
}

///|
/// Userinfo percent-encode set.
/// See: https://url.spec.whatwg.org/#userinfo-percent-encode-set
/// The userinfo percent-encode set is the path percent-encode set and
/// U+002F (/), U+003A (:), U+003B (;), U+003D (=), U+0040 (@), U+005B ([)
/// to U+005E (^), and U+007C (|).
fn userinfo_percent_encode_set(char : Char) -> Bool {
  return char
    is ('\u{0000}'..='\u{001f}'
    | '\u{007f}'..<_
    | ' '
    | '"'
    | '#'
    | '<'
    | '>'
    | '?'
    | '^'
    | '`'
    | '{'
    | '}'
    | '/'
    | ':'
    | ';'
    | '='
    | '@'
    | '['..=']'
    | '|')
}

///|
#locals(percent_encode_set)
fn utf8_percent_encode(
  input : StringView,
  percent_encode_set : (Char) -> Bool,
  space_as_plus? : Bool = false,
) -> String {
  let output = StringBuilder::new()
  let encode_output = @encoding/utf8.encode(input)
  for byte in encode_output {
    if space_as_plus && byte is b' ' {
      output.write_char('+')
      continue
    }
    let isomorph = byte.to_char()
    if percent_encode_set(isomorph) {
      output.write_char('%')
      let byte = byte.to_int()
      output.write_char(hex_digits[(byte >> 4) & 0x0f])
      output.write_char(hex_digits[byte & 0x0f])
      continue
    } else {
      output.write_char(isomorph)
    }
  }
  output.to_string()
}
