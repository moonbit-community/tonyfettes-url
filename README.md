# url

WHATWG URL Standard parser implementation in MoonBit. Parses and serializes URLs according to the [WHATWG URL Standard](https://url.spec.whatwg.org/) with web-platform-tests (WPT) compliance.

## Installation

```bash
moon add tonyfettes/url
```

## Usage

```moonbit
let url = @url.Url::parse("https://user:pass@example.com:8080/path?query=value#fragment")
println(url.protocol())   // "https:"
println(url.hostname())   // "example.com"
println(url.pathname())   // "/path"
println(url.search())     // "?query=value"
println(url.hash())       // "#fragment"

// Relative resolution; parse raises ValidationErrors on invalid input.
let base = @url.Url::parse("https://example.com/a/b/c")
let relative = @url.Url::parse("../d", base~)

// Existing setters still update the URL in place.
url.set_port("9000")

// New with_* methods return independent copies.
let updated = url.with_scheme("http")
  .with_port(Some(8080))
  .with_path(@url.Path::from_segments(["new", "a/b"]))
  .with_query(Some(@url.Query::from_text("q=hello world")))
  .with_fragment(Some(@url.Fragment::parse("section%201")))
// http://user:pass@example.com:8080/new/a%2Fb?q=hello%20world#section%201
```

## API

### Parsing

- `Url::parse(input, base?) -> Url raise ValidationErrors` — Parse a URL, optionally resolving against a base.
- `Url::try_parse(input, base?, validation_errors?) -> Url?` — Return `None` on failure and optionally collect validation errors.

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

### Setters

| Method | Description |
|--------|-------------|
| `set_protocol(protocol: String)` | Set scheme |
| `set_username(username: String)` | Set username |
| `set_password(password: String)` | Set password |
| `set_host(host: String)` | Set host (with optional port) |
| `set_hostname(hostname: String)` | Set hostname only |
| `set_port(port: String)` | Set port |
| `set_pathname(pathname: String)` | Set path |
| `set_search(search: String)` | Set query string |
| `set_hash(hash: String)` | Set fragment |

### Typed getters and copying updates

These are additive APIs: existing getters, setters, public fields, constructors,
JSON formats and parsing errors remain available with their original behavior.
`Url` remains mutable. A `with_*` call leaves its receiver unchanged and returns
an independent copy, including path storage, so later legacy setters on either
URL do not affect the other.

| Getter | Return type | Copying update |
|--------|-------------|----------------|
| `get_scheme()` | `String` without `:` | `with_scheme(String)` |
| `get_username()` | encoded `String` | `with_username(String)` |
| `get_password()` | encoded `String` | `with_password(String)` |
| `get_host()` | `Host?` without port | `with_host(Host?)` |
| `get_port()` | `UInt16?` | `with_port(UInt16?)` |
| `get_path()` | `Path` snapshot | `with_path(Path)` |
| `get_query()` | `Query?` without `?` | `with_query(Query?)` |
| `get_fragment()` | `Fragment?` without `#` | `with_fragment(Fragment?)` |
| `get_search_params()` | detached mutable `UrlSearchParams` | `with_search_params(UrlSearchParams)` |
| `get_origin()` | `Origin` (`Opaque` or `Tuple`) | — |

Fallible updates to scheme, credentials, host, port and path raise `UpdateError`
instead of silently ignoring an invalid update. `with_host` replaces only the
host and preserves the port; it validates and normalizes string-backed host
variants. Default ports normalize to `None`. Query, fragment and search-parameter
updates cannot fail. Removing a query or fragment strips trailing spaces from an
opaque path when both components are absent.

`Query::parse` and `Fragment::parse` accept encoded component content and preserve
percent escapes, including their spelling. Characters forbidden in the component
are percent-encoded; leading `?` or `#` is content, not a delimiter to strip.
Malformed percent escapes are preserved, matching the URL parser. `from_text`
encodes literal `%` as `%25` as well. These methods encode tabs and newlines;
the old search/hash setters retain their parser-style whitespace removal.
A query installed on a special-scheme URL additionally encodes apostrophes.

`None` removes a query or fragment; a present empty component preserves the bare
`?` or `#`. Queries are not assumed to be form data: `+`, `&` and `=` retain their
query syntax. Use `UrlSearchParams` for form encoding and name/value operations.
Passing getter results to matching `with_*` methods preserves parsed components
without double encoding.

`Path::from_segments` accepts unescaped segments, copies the input array and
encodes embedded `/`, `\` and `%`. `with_path` resolves dot segments and normalizes
file drive letters using the target URL's rules. `Path::from_opaque` constructs
an opaque path; special URLs and URLs with a host reject it. Opaque paths cannot
start with `/`. `Path::is_opaque` and `Path::segments` inspect paths without
exposing mutable storage. `with_pathname(String)` is the convenience parsing
entry point: it preserves percent escapes and applies the existing pathname
parser, and rejects URLs that already have opaque paths.

`get_origin()` recognizes embedded http/https origins in blob URLs. The legacy
`origin()` keeps its original string-returning behavior. Opaque origins serialize
as `"null"` and never compare same-origin; use `Origin::is_same_origin` for tuples.

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
