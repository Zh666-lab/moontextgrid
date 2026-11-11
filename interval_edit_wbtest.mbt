///|
test "interval editing preserves partitions and never mutates sources" {
  let t = get_tier(sample(), 0)
  let split = split_interval(t, 2, "", "")
  assert_eq(entry_count(split), 4)
  assert_eq(entry_count(coalesce(split)), 3)
  assert_eq(merge_intervals(split, 1, 2, ""), t)
  let moved = move_boundary(t, 1, 0.5)
  assert_eq(
    interval_at(moved, 0.75),
    Some(Interval::{ start: 0.5, end: 3, label: "", }),
  )
  assert_eq(entry_count(t), 3)
  assert_eq(entry_count(relabel_interval(t, 0, "new")), 3)
  for v in [0.0, 1.0, 4.0, -1.0] {
    assert_true(
      try {
        let _ = split_interval(t, v, "a", "b")
        false
      } catch {
        _ => true
      },
    )
  }
  assert_true(
    try {
      let _ = move_boundary(t, 1, 3)
      false
    } catch {
      _ => true
    },
  )
}
