# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

WHATWG URL Standard parser implementation in MoonBit. Parses and serializes URLs according to https://url.spec.whatwg.org/ with web-platform-tests (WPT) compliance.

## Build Commands

```bash
moon check      # Type check and lint
moon test       # Run all tests
moon build      # Build the project
```

## Architecture

### Core Data Structures

**Url struct** (`url.mbt`): Main URL representation with scheme, username, password, host, port, path, query, and fragment fields.

**Host enum** (`host.mbt`): Four host types - `Domain(String)`, `IPv4(IPv4)`, `IPv6(IPv6)`, `Opaque(String)`.

**Path enum** (`path.mbt`): `Opaque(String)` for non-hierarchical schemes, `Segments(Array[String])` for hierarchical.

### Parser State Machine

`Url::parse_basic()` in `url.mbt` implements a 16-state machine following the WHATWG spec:
- States include SchemeStart, Scheme, Authority, Host, Port, Path, Query, Fragment
- File URLs have special states (FileSlash, FileHost) for Windows drive letter handling
- Uses `StringPointer` for cursor tracking and `StringBuilder` for buffering

### Key Parsing Modules

| File | Purpose |
|------|---------|
| `url.mbt` | Main parser state machine, percent-encoding, serialization |
| `host.mbt` | Host type dispatch (IPv4/IPv6/Domain/Opaque detection) |
| `ipv4.mbt` | IPv4 parsing (supports decimal, octal, hex notation) |
| `ipv6.mbt` | IPv6 parsing with `::` compression and IPv4-mapped addresses |

### Percent-Encoding

Different URL components use different encoding sets defined in `url.mbt`:
- `userinfo_percent_encode_set` - username/password
- `path_percent_encode_set` - path segments
- `query_percent_encode_set` - query strings
- `fragment_percent_encode_set` - fragments

### Special Schemes

`is_special_scheme()` identifies: ftp, file, http, https, ws, wss. These have default ports and special parsing rules.

## Dependencies

- `tonyfettes/unicode` (v0.1.1): Provides IDNA support via `@idna.to_ascii()` for Punycode domain name conversion

## Testing

- `wpt_test.mbt`: 3700+ auto-generated test vectors from WHATWG WPT
- `whatwg_test.mbt`: Additional WHATWG compliance tests
- Unit tests: `url_test.mbt`, `host_test.mbt`, `ipv4_test.mbt`, `ipv6_test.mbt`

Regenerate WPT tests: `python3 scripts/gen_wpt_tests.py`
