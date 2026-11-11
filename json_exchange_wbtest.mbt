///|
test "JSON exchange is bounded versioned and rejects duplicate keys" {
  let g = sample()
  assert_eq(parse_json(write_json(g)), g)
  assert_eq(from_json(to_json(g)), g)
  assert_true(
    try {
      let _ = parse_json("{\"schema\":\"moontextgrid/1\",\"schema\":\"x\"}")
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = parse_json("{}")
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = from_json(to_json(g), limits={
        input_units: 1000,
        tokens: 1000,
        tiers: 2,
        entries: 2,
      })
      false
    } catch {
      _ => true
    },
  )
}
