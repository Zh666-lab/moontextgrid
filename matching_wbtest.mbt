///|
test "one to one tolerance matching counts each event at most once" {
  let a = point_tier("a", 0, 4, [
    { time: 1, label: "a", },
    { time: 1.25, label: "b", },
    { time: 3, label: "c", },
  ])
  let b = point_tier("b", 0, 4, [
    { time: 1.125, label: "x", },
    { time: 3, label: "c", },
  ])
  let m = match_points(a, b, 0.125)
  assert_eq(m.matches.length(), 2)
  assert_eq(m.matches[0].reference_index, 0)
  assert_eq(m.matches[0].same_label, false)
  assert_eq(m.precision, 1)
  assert_eq(m.recall, 2.0 / 3.0)
  assert_eq(match_points(a, b, 0).matches.length(), 1)
  assert_eq(
    match_points(point_tier("x", 0, 4, []), point_tier("y", 0, 4, []), 0).f1,
    0,
  )
  assert_eq(match_boundaries(sample().tiers[0], sample().tiers[0], 0).f1, 1)
  assert_true(
    try {
      let _ = match_points(a, b, -1)
      false
    } catch {
      _ => true
    },
  )
}
