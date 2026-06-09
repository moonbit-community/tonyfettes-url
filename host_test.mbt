///|
test "@url.Host::parse IDNA" {
  // Test internationalized domain names
  let idn_inputs = [
    "münchen.de", // German umlaut
     "中文.com", // Chinese
     "example.com",
  ] // ASCII passthrough
  debug_inspect(
    idn_inputs.map(input => {
      try @url.Host::parse(input) catch {
        err => Err(err)
      } noraise {
        host => Ok(host)
      }
    }),
    content=(
      #|[
      #|  Ok(Domain("xn--mnchen-3ya.de")),
      #|  Ok(Domain("xn--fiq228c.com")),
      #|  Ok(Domain("example.com")),
      #|]
    ),
  )
}

///|
test "@url.Host::to_unicode" {
  // Test Unicode conversion for display
  // Parse Unicode domains first, which get converted to Punycode internally,
  // then convert back to Unicode for display
  let inputs = [
    "münchen.de", // German umlaut
     "中文.com", // Chinese
     "example.com",
  ] // ASCII passthrough
  json_inspect(inputs.map(input => @url.Host::parse(input).to_unicode()), content=[
    "münchen.de", "中文.com", "example.com",
  ])
}

///|
test "@url.Host::parse" {
  let inputs = [
    "EXAMPLE.com", "example%2Ecom", "0", "%30", "0x", "0xffffffff", "[0:0::1]", "[0:0::1%5D",
    "[0:0::%31]", "09", "example.255", "example^example",
  ]
  debug_inspect(
    inputs.map(input => {
      try @url.Host::parse(input) catch {
        err => Err(err)
      } noraise {
        host => Ok(host)
      }
    }),
    content=(
      #|[
      #|  Ok(Domain("example.com")),
      #|  Ok(Domain("example.com")),
      #|  Ok(IPv4(IPv4(0))),
      #|  Ok(IPv4(IPv4(0))),
      #|  Ok(IPv4(IPv4(0))),
      #|  Ok(IPv4(IPv4(4294967295))),
      #|  Ok(IPv6(IPv6(<FixedArray: [0, 0, 0, 0, 0, 0, 0, 1]>))),
      #|  Err(IPv6Unclosed),
      #|  Err(IPv6InvalidCodePoint),
      #|  Err(IPv4NonNumericPart),
      #|  Err(IPv4NonNumericPart),
      #|  Err(HostInvalidCodePoint),
      #|]
    ),
  )
}
