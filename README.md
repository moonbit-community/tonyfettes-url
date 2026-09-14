# tonyfettes/url

WHATWG URL Standard parser for MoonBit. Parses and serializes URLs per
<https://url.spec.whatwg.org/>, validated against the web-platform-tests
(WPT) URL test suite.

## Install

```bash
moon add tonyfettes/url
```

## Quick start

```moonbit
let url = @url.Url::parse(
  "https://user:pass@example.com:8080/path?query=value#fragment",
)
url.scheme()        // "https"
url.host()          // Some(Domain("example.com"))
url.port()          // Some(8080)
url.path()          // Segments(["path"]), serializes as "/path"
url.query()         // Some("query=value")
url.fragment()      // Some("fragment")
url.to_string()     // "https://user:pass@example.com:8080/path?query=value#fragment"

// Relative resolution
let base = @url.Url::parse("https://example.com/a/b/c")
@url.Url::parse("../d", base~).to_string() // "https://example.com/a/d"

// Updates: with_* returns a new Url, set_* changes it in place
let updated = url.with_scheme("http").with_port(None).with_fragment(None)
updated.to_string() // "http://user:pass@example.com/path?query=value"
url.to_string()     // unchanged
url.set_fragment(Some("top"))
url.to_string()     // "https://user:pass@example.com:8080/path?query=value#top"
```

## API

### Parsing

```moonbit
Url::parse(input, base?, validation_errors?) -> Url raise ValidationError
```

Also available as the free function `@url.parse`. When parsing fails it
raises the `ValidationError` that stopped the parser, for example `HostMissing`
or `PortOutOfRange`. The spec's non-fatal validation errors, such as
`SpecialSchemeMissingFollowingSolidus`, do not stop parsing; pass an array as
`validation_errors` to collect them. To get an `Option` instead of an error:

```moonbit
let url = try @url.Url::parse(input) catch {
  _ => None
} noraise {
  url => Some(url)
}
```

### Getters

Getters return the URL record's components as the spec models them: absent
components are `None`, and nothing carries the `:`, `?` or `#` prefixes of the
JavaScript `URL` interface.

| Method | Returns |
|--------|---------|
| `scheme()` | `String`, lowercased, without the trailing colon |
| `username()` / `password()` | `String`, empty when absent |
| `host()` | `Host?` |
| `port()` | `UInt16?`, `None` when absent or equal to the scheme's default port |
| `path()` | `Path`; `is_opaque()`, `segments() -> Iter[String]?` and `to_string()` inspect it |
| `path_segments()` | `Iter[String]?`, shorthand for `path().segments()` |
| `query()` / `fragment()` | `String?`, `Some("")` for a present but empty value |
| `search_params()` | `UrlSearchParams` parsed from the query; not live-bound to the URL |
| `origin()` | `Origin` |
| `to_string()` | The serialized URL |

### Updates

Every component has a pair of update methods with identical rules: `set_*`
changes the URL in place, `with_*` returns a modified copy and leaves the
receiver untouched. Values are normalized and percent-encoded the way the
parser would. Updates the URL Standard forbids raise `UpdateError` instead of
being silently ignored, and a rejected update changes nothing.
`set_pathname`/`with_pathname` parse a path string with the rules of the
JavaScript `pathname` setter, resolving `.` and `..`; `set_path`/`with_path`
take another URL's `Path` as is.

| Method | Raises |
|--------|--------|
| `set_scheme(String)` | `InvalidScheme`, `SpecialSchemeMismatch`, `CannotHaveCredentialsOrPort`, `HostRequired` |
| `set_username(String)` / `set_password(String)` | `CannotHaveCredentialsOrPort` |
| `set_host(Host?)` | `HasOpaquePath`, `HostRequired`, `HostKindMismatch`, `CannotHaveCredentialsOrPort` |
| `set_port(UInt16?)` | `CannotHaveCredentialsOrPort` |
| `set_pathname(String)` | `HasOpaquePath` |
| `set_path(Path)` | `InvalidPath` |
| `set_query(String?)` / `set_fragment(String?)` | never |
| `set_search_params(UrlSearchParams)` | never |

Each `set_x` has a `with_x` twin with the same parameters that returns `Url`.

### Origin

`Url::origin()` returns an `Origin`, which is either `Opaque` or
`Tuple(scheme~, host~, port~)`. Use `Origin::is_same_origin` to compare two
origins; an opaque origin is never same origin with anything, including
itself. `Origin::to_string()` gives the browser serialization, `"null"` for an
opaque origin.

### Hosts

`Host` has four variants:

- `Domain(String)` for domain names, IDNA/Punycode encoded
- `IPv4(IPv4)` for IPv4 addresses, accepting decimal, octal and hex notation
- `IPv6(IPv6)` for IPv6 addresses, with `::` compression and IPv4-mapped forms
- `Opaque(String)` for hosts of non-special schemes

`Host::parse(input, is_opaque?)` parses a host on its own, and
`Host::to_unicode()` renders a domain with Unicode labels.

### Search params

`UrlSearchParams` wraps an ordered list of name-value pairs in the
`application/x-www-form-urlencoded` format:

```moonbit
let params = @url.UrlSearchParams::parse("a=1&b=two+words")
params.get("b")             // Some("two words")
params.append("a", "2")
params.get_all("a")         // ["1", "2"]
params.to_string()          // "a=1&b=two+words&a=2"
url.with_search_params(params)
```

`UrlSearchParams(pairs)` builds one from an array of pairs without copying it;
the mutating methods (`append`, `delete`, `set`, `sort`) modify that array in
place.

### Deprecated JavaScript-style getters

`href()`, `protocol()`, `search()` and `hash()` return the serialized
fragments the JavaScript `URL` interface exposes. They are kept for
compatibility and marked deprecated; use `to_string()`, `scheme()`, `query()`
and `fragment()` instead.

## Features

- Full WHATWG URL Standard compliance
- 1100+ WPT test vectors passing (parsing, setters, `URLSearchParams`)
- Special scheme handling (http, https, ftp, file, ws, wss)
- Default port normalization
- Relative URL resolution
- Percent-encoding and decoding
- IPv4 and IPv6 address parsing
- IDNA/Punycode domain name support
- Windows drive letter handling for `file:` URLs

## Development

```bash
moon check      # Type check and lint
moon test       # Run all tests
moon fmt        # Format
moon info       # Regenerate pkg.generated.mbti
```

Regenerate the WPT tests:

```bash
python3 scripts/generate_wpt_tests.py > wpt_test.mbt
moon run --target native scripts/generate_wpt_setters_tests.mbtx > wpt_setters_test.mbt
```

The setters generator fetches `setters_tests.json` from the WPT repository;
pass a local copy as its first argument to work offline. It covers the
protocol, username, password, pathname, search and hash sections, whose
JavaScript setters have typed counterparts with the same rules.

## License

Apache-2.0
