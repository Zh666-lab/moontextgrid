///|
test "crop clips intervals and includes exact endpoint events" {
  let g = sample()
  let c = crop(g, 0.5, 2, rebase_to_zero=true)
  assert_eq(c.start, 0)
  assert_eq(c.end, 1.5)
  assert_eq(entry_count(c.tiers[0]), 2)
  assert_eq(points_between(c.tiers[1], 1.5, 1.5), [
    Point::{ time: 1.5, label: "tap", },
  ])
  assert_eq(crop(g, 0, 4), g)
  assert_true(
    try {
      let _ = crop(g, -1, 2)
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = crop(g, 2, 2)
      false
    } catch {
      _ => true
    },
  )
}
