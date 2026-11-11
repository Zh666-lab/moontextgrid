///|
test "sweep emits exactly the positive pair intersections" {
  let a = get_tier(sample(), 0)
  let b = interval_tier("mask", 0, 4, [
    { start: 0, end: 2, label: "yes", },
    { start: 2, end: 4, label: "no", },
  ])
  let xs = overlaps(a, b)
  assert_eq(xs.length(), 4)
  let mut duration = 0.0
  for x in xs {
    duration += x.end - x.start
  }
  assert_eq(duration, 4)
  assert_eq(masked_intervals(a, b, "yes").length(), 2)
  assert_eq(
    overlaps(
      a,
      interval_tier("other", 4, 5, [{ start: 4, end: 5, label: "x", }]),
    ).length(),
    0,
  )
}
