///|
test "UTF-8 and both UTF-16 endians preserve annotations" {
  let g = sample()
  for encoding in [Utf8, Utf16LE, Utf16BE] {
    assert_eq(parse_bytes(write_bytes(g, encoding~)), g)
    assert_eq(
      decode_text(encode_text("中文🙂\r\n", encoding~)),
      "中文🙂\r\n",
    )
  }
  assert_true(
    try {
      let _ = decode_text(b"\xff")
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = decode_text(b"\xff\xfe\x00")
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = decode_text(b"abc", max_units=2)
      false
    } catch {
      _ => true
    },
  )
}
