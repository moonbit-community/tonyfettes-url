///|
test "Host::parse IDNA" {
  // Test internationalized domain names
  let idn_inputs = [
    "münchen.de", // German umlaut
     "中文.com", // Chinese
     "example.com",
  ] // ASCII passthrough
  @json.inspect(idn_inputs.map(input => try? Host::parse(input)), content=[
    { "Ok": ["Domain", "xn--mnchen-3ya.de"] },
    { "Ok": ["Domain", "xn--fiq228c.com"] },
    { "Ok": ["Domain", "example.com"] },
  ])
}

///|
test "Host::to_unicode" {
  // Test Unicode conversion for display
  // Parse Unicode domains first, which get converted to Punycode internally,
  // then convert back to Unicode for display
  let inputs = [
    "münchen.de", // German umlaut
     "中文.com", // Chinese
     "example.com",
  ] // ASCII passthrough
  @json.inspect(inputs.map(input => Host::parse(input).to_unicode()), content=[
    "münchen.de", "中文.com", "example.com",
  ])
}

///|
test "Host::parse" {
  let inputs = [
    "EXAMPLE.com", "example%2Ecom", "0", "%30", "0x", "0xffffffff", "[0:0::1]", "[0:0::1%5D",
    "[0:0::%31]", "09", "example.255", "example^example",
  ]
  @json.inspect(inputs.map(input => try? Host::parse(input)), content=[
    { "Ok": ["Domain", "example.com"] },
    { "Ok": ["Domain", "example.com"] },
    // "0" is valid IPv4 (single number notation for 0.0.0.0)
    { "Ok": ["IPv4", [0, 0, 0, 0]] },
    // "%30" decodes to "0", also valid IPv4
    { "Ok": ["IPv4", [0, 0, 0, 0]] },
    // "0x" is valid hex notation for 0
    { "Ok": ["IPv4", [0, 0, 0, 0]] },
    { "Ok": ["IPv4", [255, 255, 255, 255]] },
    { "Ok": ["IPv6", [0, 0, 0, 0, 0, 0, 0, 1]] },
    // "[0:0::1%5D" - %5D is ] so this is unclosed bracket
    { "Err": "IPv6Unclosed" },
    // "[0:0::%31]" - %31 is '1' which is invalid in IPv6 context
    { "Err": "IPv6InvalidCodePoint" },
    // "09" - octal with invalid digit 9
    { "Err": "IPv4NonNumericPart" },
    // "example.255" - "example" is not a valid IPv4 number
    { "Err": "IPv4NonNumericPart" },
    // "example^example" - ^ is a forbidden domain code point per WHATWG
    { "Err": "HostInvalidCodePoint" },
  ])
}
