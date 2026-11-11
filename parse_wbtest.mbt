///|
test "short text parser including mixed tiers and budgets" {
  let src = "\"ooTextFile short\"\n\"TextGrid\"\n0 2 <exists> 2\n\"IntervalTier\" \"词\" 0 2 1 0 2 \"hi\"\n\"TextTier\" \"点\" 0 2 1 1 \"!\""
  let g = parse_text(src)
  assert_eq(g.tiers.length(), 2)
  assert_true(
    try {
      let _ = parse_text(src, limits={
        input_units: 10000,
        tokens: 100,
        tiers: 1,
        entries: 10,
      })
      false
    } catch {
      _ => true
    },
  )
  assert_eq(
    parse_text("\"ooTextFile\" \"TextGrid\" 0 1 <absent>").tiers.length(),
    0,
  )
}
