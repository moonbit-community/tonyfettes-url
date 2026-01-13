///|
/// Represents an IPv4 address as a 32-bit unsigned integer.
/// See: https://url.spec.whatwg.org/#concept-ipv4
struct IPv4(UInt)

///|
/// Serialize IPv4 address to dotted-decimal notation (e.g., "192.168.1.1").
/// See: https://url.spec.whatwg.org/#concept-ipv4-serializer
pub fn IPv4::to_string(self : IPv4) -> String {
  let n = self.0
  let b0 = (n >> 24) & 0xFF
  let b1 = (n >> 16) & 0xFF
  let b2 = (n >> 8) & 0xFF
  let b3 = n & 0xFF
  "\{b0}.\{b1}.\{b2}.\{b3}"
}

///|
/// Implement Show trait for IPv4, outputting dotted-decimal notation
pub impl Show for IPv4 with output(self : IPv4, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}

///|
/// Implement ToJson trait for IPv4, outputting as array of 4 bytes
pub impl ToJson for IPv4 with to_json(self : IPv4) -> Json {
  let b0 = ((self.0 >> 24) & 0xFF).to_byte()
  let b1 = ((self.0 >> 16) & 0xFF).to_byte()
  let b2 = ((self.0 >> 8) & 0xFF).to_byte()
  let b3 = (self.0 & 0xFF).to_byte()
  [b0, b1, b2, b3].to_json()
}

///|
/// Parse an IPv4 address per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#concept-ipv4-parser
/// Supports decimal, octal (0-prefix), and hexadecimal (0x-prefix) notation.
///
/// The IPv4 parser takes an ASCII string input and then runs these steps:
/// 1. Let parts be the result of strictly splitting input on U+002E (.).
/// 2. If the last item in parts is the empty string, then:
///    2.1. IPv4-empty-part validation error.
///    2.2. If parts's size is greater than 1, then remove the last item from parts.
/// 3. If parts's size is greater than 4, IPv4-too-many-parts validation error,
///    return failure.
/// 4. Let numbers be an empty list.
/// 5. For each part of parts:
///    5.1. Let result be the result of parsing part.
///    5.2. If result is failure, IPv4-non-numeric-part validation error, return failure.
///    5.3. Append result to numbers.
/// 6. If any item in numbers is greater than 255, IPv4-out-of-range-part validation error.
/// 7. If the last item in numbers is greater than or equal to 256^(5 - numbers's size),
///    IPv4-out-of-range-part validation error, return failure.
/// 8. If any but the last item in numbers is greater than 255, then return failure.
/// 9. Let ipv4 be the last item in numbers.
/// 10. Remove the last item from numbers.
/// 11. Let counter be 0.
/// 12. For each n of numbers:
///     12.1. Increment ipv4 by n * 256^(3 - counter).
///     12.2. Increment counter by 1.
/// 13. Return ipv4.
pub fn IPv4::parse(input : StringView) -> IPv4 raise ValidationError {
  // 1. Let parts be the result of strictly splitting input on U+002E (.).
  let parts = input.split(".").collect()
  // 2. If the last item in parts is the empty string, remove it (if size > 1)
  let parts = if parts is [.. parts, ""] { parts } else { parts }
  // 3. If parts's size is greater than 4, return failure
  if parts.length() > 4 {
    raise IPv4TooManyParts
  }
  // 4-5. Parse each part as a number
  let numbers = []
  for part in parts {
    let number = IPv4::parse_number(part)
    numbers.push(number)
  }
  guard numbers is [.. numbers, last_number] else { abort("unreachable") }
  // 6, 8. If any but the last item in numbers is greater than 255, return failure
  for number in numbers {
    if number > 255 {
      raise IPv4OutOfRangePart
    }
  }
  // 7. If the last item in numbers is >= 256^(5 - numbers's size), return failure
  if last_number >= 1UL << (8 * (4 - numbers.length())) {
    raise IPv4OutOfRangePart
  }
  // 9-12. Calculate final IPv4 value
  let mut ipv4 = last_number.to_uint()
  let mut counter = 0
  for n in numbers {
    ipv4 = ipv4 + (n.to_uint() << (8 * (3 - counter)))
    counter = counter + 1
  }
  // 13. Return ipv4
  IPv4(ipv4)
}

///|
/// Parse an IPv4 number component per WHATWG URL spec.
/// See: https://url.spec.whatwg.org/#ipv4-number-parser
/// The IPv4 number parser takes an ASCII string input and then runs these steps:
/// 1. If input is the empty string, then return failure.
/// 2. Let validationError be false.
/// 3. Let R be 10.
/// 4. If input contains at least 2 code points and the first two code points
///    are either "0X" or "0x", then:
///    4.1. Set validationError to true.
///    4.2. Remove the first two code points from input.
///    4.3. Set R to 16.
/// 5. Otherwise, if input contains at least 2 code points and the first code
///    point is U+0030 (0), then:
///    5.1. Set validationError to true.
///    5.2. Remove the first code point from input.
///    5.3. Set R to 8.
/// 6. If input is the empty string, then return (0, true).
/// 7. If input contains a code point that is not a radix-R digit, then return failure.
/// 8. Let output be the mathematical integer value represented by input in radix-R.
/// 9. Return (output, validationError).
fn IPv4::parse_number(input : StringView) -> UInt64 raise ValidationError {
  // 1. If input is the empty string, return failure
  if input is "" {
    raise IPv4EmptyPart
  }
  match input {
    // 4. If input starts with "0x" or "0X", use radix 16 (hexadecimal)
    ['0', 'x' | 'X', .. rest] => {
      let mut value : UInt64 = 0
      for c in rest {
        let digit = match c {
          '0'..='9' => c.to_int() - '0'
          'a'..='f' => c.to_int() - 'a' + 10
          'A'..='F' => c.to_int() - 'A' + 10
          _ => raise IPv4NonNumericPart
        }
        guard digit < 16 else { raise IPv4NonNumericPart }
        value = value * 16 + digit.to_uint64()
      }
      value
    }
    // 5. If input starts with "0" followed by digits, use radix 8 (octal)
    ['0', '0'..='9' as c, .. rest] => {
      guard c >= '0' && c <= '7' else { raise IPv4NonNumericPart }
      let mut value : UInt64 = (c.to_int() - '0').to_uint64()
      for c in rest {
        guard c >= '0' && c <= '7' else { raise IPv4NonNumericPart }
        value = value * 8 + (c.to_int() - '0').to_uint64()
      }
      value
    }
    // 6. Single "0" is decimal 0
    ['0'] => 0UL
    // Default: radix 10 (decimal)
    ['1'..='9' as c, .. rest] => {
      let mut value : UInt64 = (c.to_int() - '0').to_uint64()
      for c in rest {
        guard c >= '0' && c <= '9' else { raise IPv4NonNumericPart }
        value = value * 10 + (c.to_int() - '0').to_uint64()
      }
      value
    }
    // 7. If input contains non-radix-R digit, return failure
    _ => raise IPv4NonNumericPart
  }
}

///|
test "IPv4::parse" {
  let inputs = ["127.0.0.1", "0xffffffff"]
  @json.inspect(inputs.map(input => try? IPv4::parse(input)), content=[
    { "Ok": [127, 0, 0, 1] },
    { "Ok": [255, 255, 255, 255] },
  ])
}

///|
test "IPv4::parse_number" {
  @json.inspect(IPv4::parse_number("255"), content="255")
  @json.inspect(IPv4::parse_number("0xff"), content="255")
  @json.inspect(IPv4::parse_number("0377"), content="255")
  @json.inspect(try? IPv4::parse_number("09"), content={
    "Err": "IPv4NonNumericPart",
  })
}
