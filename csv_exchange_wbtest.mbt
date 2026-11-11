///|
test "CSV round trip preserves delimiters multiline labels and empty point tiers" {
  let g = insert_tier(sample(), 2, point_tier("a,b\"c", 0, 4, []))
  assert_eq(parse_csv(write_csv(g)), g)
  assert_eq(parse_csv(write_csv(grid(0, 1, []))), grid(0, 1, []))
  assert_true(
    try {
      let _ = parse_csv("record,tier,name,start,end,label\na,b,c\n")
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = csv_records("\"x\"z,a,b,c,d,e", default_limits())
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = csv_records("\"x,a,b,c,d,e", default_limits())
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = parse_csv(write_csv(g), limits={
        input_units: 10000,
        tokens: 10000,
        tiers: 3,
        entries: 0,
      })
      false
    } catch {
      _ => true
    },
  )
}
