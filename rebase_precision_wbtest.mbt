///|
test "rebasing a large origin preserves the exact requested small origin" {
  let g = grid(1.0e16, 1.0e16 + 4, [
    interval_tier("x", 1.0e16, 1.0e16 + 4, [
      { start: 1.0e16, end: 1.0e16 + 2, label: "a", },
      { start: 1.0e16 + 2, end: 1.0e16 + 4, label: "b", },
    ]),
  ])
  let r = rebase(g, 1)
  assert_eq(r.start, 1)
  assert_eq(r.end, 5)
  assert_eq(interval_at(r.tiers[0], 2).unwrap().start, 1)
}
