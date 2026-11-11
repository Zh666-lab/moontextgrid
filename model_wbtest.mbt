///|
test "partition validation, points and ownership" {
  let xs : Array[Interval] = [{ start: 0.0, end: 1.0, label: "你", }]
  let t = interval_tier("words", 0.0, 1.0, xs)
  xs.clear()
  let g = grid(0.0, 1.0, [t])
  validate(g)
  assert_eq(g.tiers.length(), 1)
  let bad = try {
    let _ = interval_tier("bad", 0.0, 2.0, [
      { start: 1.0, end: 2.0, label: "", },
    ])
    false
  } catch {
    _ => true
  }
  assert_true(bad)
  assert_true(
    try {
      let _ = point_tier("x", 0.0, 1.0, [
        { time: 0.5, label: "", },
        { time: 0.5, label: "", },
      ])
      false
    } catch {
      _ => true
    },
  )
}
