///|
test "tier composition validates bounds and owns nested arrays" {
  let g = sample()
  let t = rename_tier(get_tier(g, 0), "utterances")
  assert_eq(find_tiers(insert_tier(g, 2, t), "utterances"), [2])
  assert_eq(remove_tier(g, 1).tiers.length(), 1)
  assert_eq(tier_name(replace_tier(g, 0, t).tiers[0]), "utterances")
  let changed = map_labels(t, fn(s) { if s == "" { "sil" } else { s } })
  assert_eq(interval_at(changed, 2).unwrap().label, "sil")
  assert_true(
    try {
      let _ = insert_tier(g, 0, point_tier("bad", 0, 1, []))
      false
    } catch {
      _ => true
    },
  )
}
