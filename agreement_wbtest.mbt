///|
test "duration weighted confusion and kappa have independent known answers" {
  let r = interval_tier("r", 0, 4, [
    { start: 0, end: 2, label: "a", },
    { start: 2, end: 4, label: "b", },
  ])
  let h = interval_tier("h", 0, 4, [
    { start: 0, end: 1, label: "a", },
    { start: 1, end: 4, label: "b", },
  ])
  let a = agreement(r, h)
  assert_eq(a.matching_duration, 3)
  assert_eq(a.observed, 0.75)
  assert_eq(a.expected, 0.5)
  assert_eq(a.kappa, Some(0.5))
  assert_eq(a.confusion.length(), 3)
  assert_eq(agreement(r, r).kappa, Some(1))
  let flat = interval_tier("x", 0, 4, [{ start: 0, end: 4, label: "a", }])
  assert_eq(agreement(flat, flat).kappa, None)
  assert_true(
    try {
      let _ = agreement(
        r,
        interval_tier("x", 0, 3, [{ start: 0, end: 3, label: "a", }]),
      )
      false
    } catch {
      _ => true
    },
  )
}
