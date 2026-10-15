// Explicitly attach trait methods to the public types, the way
// `moonbitlang/core` does: methods that belong to the type's regular API go
// in the "promoted" section, and everything else stays callable (through an
// `extend`) but is deprecated and hidden from the generated interface.
//
// Without these declarations the compiler implicitly promotes the methods and
// reports the deprecated `implicit_impl_as_method` (E0079) warning.

// --- promoted: kept as regular methods (blessed public API) ---

///|
pub extend ValidationError with Show::{to_string}

///|
pub extend ValidationErrors with Show::{to_string}

// --- deprecated: hidden from the generated interface ---

///|
#deprecated("Use `Debug::to_repr` instead", skip_current_package=true)
#doc(hidden)
pub extend Host with @debug.Debug::{to_repr}

///|
#deprecated("Use `Show::output` via the trait or `to_string` instead", skip_current_package=true)
#doc(hidden)
pub extend Host with Show::{output}

///|
#deprecated("Use `Json(value)` instead", skip_current_package=true)
#doc(hidden)
pub extend Host with ToJson::{to_json}

///|
#deprecated("Use `Debug::to_repr` instead", skip_current_package=true)
#doc(hidden)
pub extend ValidationError with @debug.Debug::{to_repr}

///|
#deprecated("Use `Show::output` via the trait or `to_string` instead", skip_current_package=true)
#doc(hidden)
pub extend ValidationError with Show::{output}

///|
#deprecated("Use `Json(value)` instead", skip_current_package=true)
#doc(hidden)
pub extend ValidationError with ToJson::{to_json}

///|
#deprecated("Use `Debug::to_repr` instead", skip_current_package=true)
#doc(hidden)
pub extend ValidationErrors with @debug.Debug::{to_repr}

///|
#deprecated("Use `Show::output` via the trait or `to_string` instead", skip_current_package=true)
#doc(hidden)
pub extend ValidationErrors with Show::{output}

///|
#deprecated("Use `Debug::to_repr` instead", skip_current_package=true)
#doc(hidden)
pub extend IPv4 with @debug.Debug::{to_repr}

///|
#deprecated("Use `Show::output` via the trait or `to_string` instead", skip_current_package=true)
#doc(hidden)
pub extend IPv4 with Show::{output}

///|
#deprecated("Use `Json(value)` instead", skip_current_package=true)
#doc(hidden)
pub extend IPv4 with ToJson::{to_json}

///|
#deprecated("Use `Debug::to_repr` instead", skip_current_package=true)
#doc(hidden)
pub extend IPv6 with @debug.Debug::{to_repr}

///|
#deprecated("Use `Show::output` via the trait or `to_string` instead", skip_current_package=true)
#doc(hidden)
pub extend IPv6 with Show::{output}

///|
#deprecated("Use `Json(value)` instead", skip_current_package=true)
#doc(hidden)
pub extend IPv6 with ToJson::{to_json}

///|
#deprecated("Use `Show::output` via the trait or `to_string` instead", skip_current_package=true)
#doc(hidden)
pub extend Path with Show::{output}

///|
#deprecated("Use `Show::output` via the trait or `to_string` instead", skip_current_package=true)
#doc(hidden)
pub extend Url with Show::{output}

///|
#deprecated("Use `Json(value)` instead", skip_current_package=true)
#doc(hidden)
pub extend Url with ToJson::{to_json}

///|
#deprecated("Use `Show::output` via the trait or `to_string` instead", skip_current_package=true)
#doc(hidden)
pub extend UrlSearchParams with Show::{output}

///|
#deprecated("Use `Json(value)` instead", skip_current_package=true)
#doc(hidden)
pub extend UrlSearchParams with ToJson::{to_json}
