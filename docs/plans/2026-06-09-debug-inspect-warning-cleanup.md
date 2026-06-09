# Debug Inspect Warning Cleanup

## Goal

Remove deprecated `try?` warnings without test-only JSON `Result` construction boilerplate.

## Accepted Design

Use `Debug` output for the affected tests:

- Add or derive `Debug` for the parsed host/address types used by the snapshots.
- Keep existing `ToJson` implementations because they are already part of the package surface.
- Replace the affected `json_inspect(...)` calls with `debug_inspect(...)`.

## Target Files and Surfaces

- `host.mbt`: `Host` derive list.
- `ipv4.mbt`: `IPv4` debug support and local tests.
- `ipv6.mbt`: `IPv6` debug support.
- `host_test.mbt`, `ipv6_test.mbt`: test snapshots.
- `pkg.generated.mbti`: generated public interface summary after `moon info`.

## API / Interface Diff

Expected generated interface changes:

- `Host` gains `Debug` in addition to existing `ToJson`.
- `IPv4` gains public `Debug` support.
- `IPv6` gains public `Debug` support.

## Open Questions

None. The user confirmed this interface change.

## Next Implementation Step

Derive or implement `Debug` for the affected types, update the inspect calls, run formatting and validation, amend the PR commit, and force-push the branch.

## Validation Plan

- `moon fmt`
- `moon info`
- `moon check`
- `moon test`
