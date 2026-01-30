///|
test "ends_in_a_number" {
  assert_eq(ends_in_a_number("example.com.123"), true)
  assert_eq(ends_in_a_number("example.com.abc"), false)
  assert_eq(ends_in_a_number("example.com."), false)
  assert_eq(ends_in_a_number("example.com"), false)
  assert_eq(ends_in_a_number("example.0x1A"), true)
  assert_eq(ends_in_a_number("example.0xG1"), false)
  assert_eq(ends_in_a_number("example.09"), true)
  assert_eq(ends_in_a_number("0xffffffff"), true)
}
