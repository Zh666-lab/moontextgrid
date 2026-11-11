///|
test "boundary ownership and point windows are explicit" {
  let g = sample()
  let t = get_tier(g, 0)
  assert_eq(interval_at(t, 1), Some(Interval::{ start: 1, end: 3, label: "", }))
  assert_eq(interval_at(t, 4), interval_at(t, 3.5))
  assert_eq(interval_at(t, -1), None)
  assert_eq(points_between(get_tier(g, 1), 0, 2).length(), 2)
  assert_eq(find_tiers(g, "words"), [0])
  assert_eq(select_tiers(g, [1, 0]).tiers.length(), 2)
  assert_true(
    try {
      let _ = get_tier(g, -1)
      false
    } catch {
      _ => true
    },
  )
}
