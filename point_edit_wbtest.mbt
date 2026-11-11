///|
test "point edits retain strict order even across neighbours" {
  let t = get_tier(sample(), 1)
  assert_eq(entry_count(insert_point(t, 1, "x")), 4)
  assert_eq(entry_count(delete_point(t, 1)), 2)
  assert_eq(points_between(move_point(t, 1, 3), 3, 3), [
    Point::{ time: 3, label: "tap", },
  ])
  assert_eq(
    points_between(relabel_point(t, 1, "changed"), 2, 2)[0].label,
    "changed",
  )
  assert_true(
    try {
      let _ = insert_point(t, 2, "dup")
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = move_point(t, 1, 4)
      false
    } catch {
      _ => true
    },
  )
  assert_eq(entry_count(t), 3)
}
