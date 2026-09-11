# url

WHATWG URL Standard parser implementation in MoonBit. Parses and serializes URLs according to the [WHATWG URL Standard](https://url.spec.whatwg.org/) with web-platform-tests (WPT) compliance.

## Installation

```bash
moon add tonyfettes/url
```

## Usage

`Url` values are immutable: parsing produces a value that never changes, and
the `with_*` methods return an updated copy instead of modifying the receiver.

```moonbit
// Parse a URL (raises ValidationErrors on invalid input)
let url = @url.parse("https://user:pass@example.com:8080/path?query=value#fragment")
println(url.protocol())   // "https:"
println(url.hostname())   // "example.com"
println(url.pathname())   // "/path"
println(url.search())     // "?query=value"
println(url.hash())       // "#fragment"
println(url.to_string())  // full URL

// Or get a Url? instead of raising
if @url.try_parse("not a url") is None {
  println("Invalid URL")
}

// Parse relative URLs with a base
let base = @url.parse("https://example.com/a/b/c")
let relative = @url.parse("../d", base~)
// Result: "https://example.com/a/d"

// Derive updated URLs; the original is untouched
let updated = @url.parse("http://example.com/path")
  .with_protocol("https:")
  .with_port("8080")
  .with_pathname("/new/path")
  .with_search("?foo=bar")
  .with_hash("#section")
// Result: "https://example.com:8080/new/path?foo=bar#section"
```

## API

### Parsing

- `parse(input: String, base?: Url) -> Url raise ValidationErrors` - Parse a URL string, optionally with a base URL for relative resolution
- `try_parse(input: String, base?: Url, validation_errors?: Array[ValidationError]) -> Url?` - Like `parse`, but returns `None` on failure

### Getters

| Method | Description |
|--------|-------------|
| `href()` | Full serialized URL |
| `protocol()` | Scheme with trailing colon (e.g., `"https:"`) |
| `username()` | Username component |
| `password()` | Password component |
| `host()` | Host with port (e.g., `"example.com:8080"`) |
| `hostname()` | Host without port |
| `port()` | Port as string (empty if default/none) |
| `pathname()` | Path component |
| `search()` | Query string with leading `?` |
| `hash()` | Fragment with leading `#` |
| `origin()` | Origin (scheme + host + port) |

### Builders

Each `with_*` method returns a new `Url` with one component replaced,
following the WHATWG setter steps. Methods that can reject the value raise a
`ValidationError`; catching it and keeping the original URL reproduces the
silent-ignore behavior of the JavaScript `URL` setters.

| Method | Description |
|--------|-------------|
| `with_protocol(protocol: String) raise` | Scheme (special ↔ non-special changes raise) |
| `with_username(username: String) raise` | Username |
| `with_password(password: String) raise` | Password |
| `with_host(host: String) raise` | Host (with optional port) |
| `with_hostname(hostname: String) raise` | Hostname only |
| `with_port(port: String) raise` | Port (`""` removes it) |
| `with_pathname(pathname: String) raise` | Path |
| `with_search(search: String)` | Query string (`""` removes it) |
| `with_hash(hash: String)` | Fragment (`""` removes it) |
| `with_search_params(params: UrlSearchParams)` | Query from search params |

### UrlSearchParams

`UrlSearchParams` is immutable as well: `append`, `set`, `delete`, and `sort`
return a new instance.

```moonbit
let params = @url.UrlSearchParams::from_string("a=1&b=2")
  .append("c", "3")
  .set("a", "updated")
  .delete("b")
let url = @url.parse("https://example.com/").with_search_params(params)
// Result: "https://example.com/?a=updated&c=3"
```

### Host Types

The parser recognizes four host types:

- `Domain(String)` - Domain names (with IDNA/Punycode support)
- `IPv4(IPv4)` - IPv4 addresses (supports decimal, octal, hex notation)
- `IPv6(IPv6)` - IPv6 addresses (supports `::` compression and IPv4-mapped)
- `Opaque(String)` - Opaque hosts for non-special schemes

## Features

- Full WHATWG URL Standard compliance
- 3700+ WPT test vectors passing
- Special scheme handling (http, https, ftp, file, ws, wss)
- Default port normalization
- Relative URL resolution
- Percent-encoding/decoding
- IPv4 and IPv6 address parsing
- IDNA/Punycode domain name support
- Windows drive letter handling for file URLs

## Build

```bash
moon check      # Type check and lint
moon build      # Build the project
moon test       # Run all tests
```

## License

Apache-2.0
