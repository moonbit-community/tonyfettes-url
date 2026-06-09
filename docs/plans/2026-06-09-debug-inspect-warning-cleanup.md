# Debug Inspect Warning Cleanup

## Goal

Remove deprecated `try?` warnings without test-only JSON `Result` construction boilerplate, then clean the current warning baseline for common lint flags.

## Accepted Design

Use `Debug` output for the affected tests:

- Add or derive `Debug` for the parsed host/address types used by the snapshots.
- Keep existing `ToJson` implementations because they are already part of the package surface.
- Replace the affected `json_inspect(...)` calls with `debug_inspect(...)`.

Clean the warning baseline by keeping the same behavior and public API shape:

- Keep both `@url.Url::parse(...)` and the generated free function `@url.parse(...)` as supported public entry points.
- Remove the `Url::parse` deprecation marker.
- Enable `test_unqualified_package` and qualify black-box test API references with `@url`.
- Update WPT generator scripts so regenerated tests use explicit package-qualified parse calls.
- Remove compiler-reported unnecessary type/package qualifiers.
- Remove the unused optional default value from `Path::shorten`.

## Target Files and Surfaces

- `host.mbt`: `Host` derive list.
- `ipv4.mbt`: `IPv4` debug support and local tests.
- `ipv6.mbt`: `IPv6` debug support.
- `host_test.mbt`, `ipv6_test.mbt`: test snapshots.
- `url.mbt`, `url_test.mbt`, `urlsearchparams.mbt`, `urlsearchparams_test.mbt`, `path.mbt`: warning cleanup.
- `wpt_test.mbt`, `wpt_setters_test.mbt`: generated test warning cleanup.
- `scripts/generate_wpt_tests.py`, `scripts/generate_wpt_setters_tests.py`: keep generated output warning-clean.
- `moon.mod`: enable the cleaned common warning set with mnemonic names.
- `pkg.generated.mbti`: generated public interface summary after `moon info`.

## API / Interface Diff

Expected generated interface changes:

- `Host` gains `Debug` in addition to existing `ToJson`.
- `IPv4` gains public `Debug` support.
- `IPv6` gains public `Debug` support.
- `Url::parse` remains public and non-deprecated.
- No additional public API change is expected from the warning cleanup.

## Open Questions

None. The user confirmed cleaning the warnings.

## Next Implementation Step

Remove the parse deprecation marker, use mnemonic warning names, qualify black-box tests, run formatting and validation, amend the PR commit, and force-push the branch.

## Validation Plan

- `moon fmt`
- `moon info`
- `moon check`
- `moon check --fmt`
- `moon check --deny-warn`
- `moon check --warn-list +unused_optional_argument+unused_default_value+unnecessary_annotation+test_unqualified_package`
- `moon test`
