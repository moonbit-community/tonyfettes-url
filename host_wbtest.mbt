///|
test "ends_in_a_number" {
  @assert.t(ends_in_a_number("example.com.123"))
  @assert.t(!ends_in_a_number("example.com.abc"))
  @assert.t(!ends_in_a_number("example.com."))
  @assert.t(!ends_in_a_number("example.com"))
  @assert.t(ends_in_a_number("example.0x1A"))
  @assert.t(!ends_in_a_number("example.0xG1"))
  @assert.t(!ends_in_a_number("example.09"))
  @assert.t(ends_in_a_number("0xffffffff"))
}
