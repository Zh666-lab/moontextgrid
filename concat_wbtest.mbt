///|
test "split and concatenate restore annotations up to adjacent equal intervals" {
  let g = sample()
  let joined = concatenate(crop(g, 0, 2), crop(g, 2, 4, rebase_to_zero=true))
  assert_eq(coalesce(joined.tiers[0]), g.tiers[0])
  assert_eq(joined.tiers[1], g.tiers[1])
  let bad = replace_tier(
    crop(g, 2, 4),
    1,
    relabel_point(crop(g, 2, 4).tiers[1], 0, "different"),
  )
  assert_true(
    try {
      let _ = concatenate(crop(g, 0, 2), bad)
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = concatenate(g, remove_tier(g, 0))
      false
    } catch {
      _ => true
    },
  )
}
