///|
test "Praat lexer ignores field labels and index brackets" {
  let ts = tokenize(
    "xmin = 0\nitem [99]:\nname = \"a\"\"b\"\ntext = \"two\nlines\"",
    default_limits(),
  )
  assert_eq(ts.length(), 3)
  assert_eq(ts[1].text, "a\"b")
  assert_eq(ts[2].text, "two\nlines")
  assert_true(
    try {
      let _ = tokenize("\"missing", default_limits())
      false
    } catch {
      _ => true
    },
  )
}
