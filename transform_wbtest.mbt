///|
test "affine transforms preserve structure and reject loss of ordering" {
  let g = sample()
  assert_eq(shift(shift(g, 2), -2), g)
  assert_eq(scale(scale(g, 2), 0.5), g)
  assert_eq(rebase(g, 10).start, 10)
  assert_eq(rebase(g, 10).end, 14)
  assert_true(
    try {
      let _ = scale(g, 0)
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = scale(g, -1)
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = shift(g, 1.0e300)
      false
    } catch {
      _ => true
    },
  )
}
