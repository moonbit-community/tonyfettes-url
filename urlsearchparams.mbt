///|
/// Represents URL search parameters per the WHATWG URL Standard.
/// See: https://url.spec.whatwg.org/#interface-urlsearchparams
/// Provides methods to work with the query string of a URL using
/// application/x-www-form-urlencoded format.
///
/// Values are immutable: `append`, `delete`, `set`, and `sort` return a new
/// instance instead of modifying the receiver.
struct UrlSearchParams {
  list : Array[(String, String)]
} derive(Eq)

///|
/// Create a new empty UrlSearchParams instance.
pub fn UrlSearchParams::new() -> UrlSearchParams {
  { list: [] }
}

///|
/// Parse a query string into UrlSearchParams.
/// Strips a leading "?" if present.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-urlsearchparams
pub fn UrlSearchParams::from_string(input : String) -> UrlSearchParams {
  // Strip leading "?" if present
  let input = match input[:] {
    ['?', .. rest] => rest
    s => s
  }
  let list : Array[(String, String)] = []
  urlencoded_parse(input, list)
  { list, }
}

///|
/// Create UrlSearchParams from an array of (name, value) pairs.
pub fn UrlSearchParams::from_pairs(
  pairs : Array[(String, String)],
) -> UrlSearchParams {
  { list: pairs.copy() }
}

///|
/// application/x-www-form-urlencoded percent-encode set.
/// See: https://url.spec.whatwg.org/#application-x-www-form-urlencoded-percent-encode-set
/// Encodes everything EXCEPT: 0-9, A-Z, a-z, *, -, ., _
fn urlencoded_percent_encode_set(char : Char) -> Bool {
  match char {
    '0'..='9' | 'A'..='Z' | 'a'..='z' | '*' | '-' | '.' | '_' => false
    _ => true
  }
}

///|
/// Parse application/x-www-form-urlencoded input.
/// See: https://url.spec.whatwg.org/#concept-urlencoded-parser
fn urlencoded_parse(
  input : StringView,
  output : Array[(String, String)],
) -> Unit {
  // 1. Let sequences be the result of splitting input on `&`.
  for sequence in input.split("&") {
    // 2. For each byte sequence bytes in sequences:
    // 2.1. If bytes is the empty byte sequence, then continue.
    if sequence.is_empty() {
      continue
    }
    // 2.2. If bytes contains a `=`, then let name be the bytes from the start
    //      of bytes up to but excluding its first `=`, and let value be the
    //      bytes, if any, after the first `=` up to the end of bytes.
    //      Otherwise, let name be bytes and let value be the empty byte sequence.
    let (name_raw, value_raw) = find_first_equals(sequence)
    // 2.3. Replace any `+` in name and value with U+0020 SPACE.
    let name_plus_decoded = replace_plus_with_space(name_raw)
    let value_plus_decoded = replace_plus_with_space(value_raw)
    // 2.4. Let nameString and valueString be the result of running UTF-8 decode
    //      without BOM on the percent-decoding of name and value, respectively.
    let name = @encoding/utf8.decode_lossy(
      percent_decode_string(name_plus_decoded[:]),
    )
    let value = @encoding/utf8.decode_lossy(
      percent_decode_string(value_plus_decoded[:]),
    )
    // 2.5. Append (nameString, valueString) to output.
    output.push((name, value))
  }
}

///|
/// Find first '=' in StringView and split into (name, value).
fn find_first_equals(input : StringView) -> (String, String) {
  let name_builder = StringBuilder::new()
  let value_builder = StringBuilder::new()
  let mut found_equals = false
  for c in input {
    if !found_equals && c == '=' {
      found_equals = true
    } else if found_equals {
      value_builder.write_char(c)
    } else {
      name_builder.write_char(c)
    }
  }
  (name_builder.to_string(), value_builder.to_string())
}

///|
/// Replace all `+` characters with spaces.
fn replace_plus_with_space(input : String) -> String {
  let output = StringBuilder::new()
  for c in input {
    if c == '+' {
      output.write_char(' ')
    } else {
      output.write_char(c)
    }
  }
  output.to_string()
}

///|
/// Serialize UrlSearchParams to application/x-www-form-urlencoded string.
/// See: https://url.spec.whatwg.org/#concept-urlencoded-serializer
pub fn UrlSearchParams::to_string(self : UrlSearchParams) -> String {
  let output = StringBuilder::new()
  for i, pair in self.list {
    if i > 0 {
      output.write_char('&')
    }
    let name = pair.0
    let value = pair.1
    // Percent-encode name and value, encoding space as +
    let encoded_name = utf8_percent_encode(
      name,
      urlencoded_percent_encode_set,
      space_as_plus=true,
    )
    let encoded_value = utf8_percent_encode(
      value,
      urlencoded_percent_encode_set,
      space_as_plus=true,
    )
    output.write_string(encoded_name)
    output.write_char('=')
    output.write_string(encoded_value)
  }
  output.to_string()
}

///|
/// Return the number of name-value pairs.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-size
pub fn UrlSearchParams::size(self : UrlSearchParams) -> Int {
  self.list.length()
}

///|
/// Return a copy with a new name-value pair appended.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-append
pub fn UrlSearchParams::append(
  self : UrlSearchParams,
  name : String,
  value : String,
) -> UrlSearchParams {
  { list: [..self.list, (name, value)] }
}

///|
/// Return a copy with all pairs with the given name removed.
/// If value is provided, only remove pairs where both name and value match.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-delete
pub fn UrlSearchParams::delete(
  self : UrlSearchParams,
  name : String,
  value? : String,
) -> UrlSearchParams {
  let list = match value {
    Some(v) => self.list.filter(fn(pair) { pair.0 != name || pair.1 != v })
    None => self.list.filter(fn(pair) { pair.0 != name })
  }
  { list, }
}

///|
/// Get the first value for the given name, or None if not found.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-get
pub fn UrlSearchParams::get(self : UrlSearchParams, name : String) -> String? {
  for pair in self.list {
    if pair.0 == name {
      return Some(pair.1)
    }
  }
  None
}

///|
/// Get all values for the given name.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-getall
pub fn UrlSearchParams::get_all(
  self : UrlSearchParams,
  name : String,
) -> Array[String] {
  let result : Array[String] = []
  for pair in self.list {
    if pair.0 == name {
      result.push(pair.1)
    }
  }
  result
}

///|
/// Check if a name exists in the search params.
/// If value is provided, check if a pair with both name and value exists.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-has
pub fn UrlSearchParams::has(
  self : UrlSearchParams,
  name : String,
  value? : String,
) -> Bool {
  match value {
    Some(v) => self.list.iter().any(fn(pair) { pair.0 == name && pair.1 == v })
    None => self.list.iter().any(fn(pair) { pair.0 == name })
  }
}

///|
/// Return a copy with a value set for the given name.
/// If name already exists, replaces the first occurrence and removes any others.
/// Otherwise, appends a new pair.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-set
pub fn UrlSearchParams::set(
  self : UrlSearchParams,
  name : String,
  value : String,
) -> UrlSearchParams {
  // Find first matching pair
  let mut found = false
  let new_list : Array[(String, String)] = []
  for pair in self.list {
    if pair.0 == name {
      if !found {
        // Replace first occurrence
        new_list.push((name, value))
        found = true
      }
      // Skip subsequent occurrences
    } else {
      new_list.push(pair)
    }
  }
  if !found {
    // Name not found, append new pair
    new_list.push((name, value))
  }
  { list: new_list }
}

///|
/// Compare two strings by UTF-16 code unit order.
/// WHATWG URL Standard requires sorting by "code unit less than".
/// See: https://infra.spec.whatwg.org/#code-unit-less-than
fn compare_utf16_code_units(a : String, b : String) -> Int {
  let iter_a = a.iter()
  let iter_b = b.iter()
  while true {
    let char_a = iter_a.next()
    let char_b = iter_b.next()
    match (char_a, char_b) {
      (None, None) => return 0
      (None, Some(_)) => return -1
      (Some(_), None) => return 1
      (Some(ca), Some(cb)) => {
        let code_a = ca.to_int()
        let code_b = cb.to_int()
        // For BMP characters (< 0x10000), code point == code unit
        // For supplementary characters, compare by high surrogate first
        let (unit_a, next_a) : (Int, Int?) = if code_a >= 0x10000 {
          // Compute high surrogate: 0xD800 + ((code - 0x10000) >> 10)
          let high = 0xD800 + ((code_a - 0x10000) >> 10)
          let low = 0xDC00 + ((code_a - 0x10000) & 0x3FF)
          (high, Some(low))
        } else {
          (code_a, None)
        }
        let (unit_b, next_b) : (Int, Int?) = if code_b >= 0x10000 {
          let high = 0xD800 + ((code_b - 0x10000) >> 10)
          let low = 0xDC00 + ((code_b - 0x10000) & 0x3FF)
          (high, Some(low))
        } else {
          (code_b, None)
        }
        // Compare first code units
        if unit_a < unit_b {
          return -1
        }
        if unit_a > unit_b {
          return 1
        }
        // First units equal, compare second units if present
        match (next_a, next_b) {
          (Some(la), Some(lb)) =>
            if la < lb {
              return -1
            } else if la > lb {
              return 1
            }
          (Some(_), None) =>
            // a has more code units for this character
            return 1
          (None, Some(_)) =>
            // b has more code units for this character
            return -1
          (None, None) => ()
        }
      }
    }
  }
  0 // unreachable
}

///|
/// Return a copy with all name-value pairs sorted by name using stable sort.
/// Uses UTF-16 code unit order per WHATWG URL Standard.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-sort
pub fn UrlSearchParams::sort(self : UrlSearchParams) -> UrlSearchParams {
  let list = self.list.copy()
  list.sort_by(fn(a, b) { compare_utf16_code_units(a.0, b.0) })
  { list, }
}

///|
/// Iterate over all (name, value) pairs.
/// See: https://url.spec.whatwg.org/#urlsearchparams-iteration
pub fn UrlSearchParams::iter(self : UrlSearchParams) -> Iter[(String, String)] {
  self.list.iter()
}

///|
/// Iterate over all (name, value) pairs (alias for iter).
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-entries
pub fn UrlSearchParams::entries(
  self : UrlSearchParams,
) -> Iter[(String, String)] {
  self.iter()
}

///|
/// Iterate over all names.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-keys
pub fn UrlSearchParams::keys(self : UrlSearchParams) -> Iter[String] {
  self.list.iter().map(fn(pair) { pair.0 })
}

///|
/// Iterate over all values.
/// See: https://url.spec.whatwg.org/#dom-urlsearchparams-values
pub fn UrlSearchParams::values(self : UrlSearchParams) -> Iter[String] {
  self.list.iter().map(fn(pair) { pair.1 })
}

///|
/// Implement Show trait for UrlSearchParams, outputting the serialized string.
pub impl Show for UrlSearchParams with fn output(
  self : UrlSearchParams,
  logger : &Logger,
) -> Unit {
  logger.write_string(self.to_string())
}

///|
/// Serialize UrlSearchParams to JSON as a string.
pub impl ToJson for UrlSearchParams with fn to_json(self : UrlSearchParams) -> Json {
  self.to_string().to_json()
}
