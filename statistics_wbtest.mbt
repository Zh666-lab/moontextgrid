///|
test "statistics include silence and count points without duration" {
  let g = sample()
  let s = summarize(g.tiers[0])
  assert_eq(s.entries, 3)
  assert_eq(s.labelled_duration, 2)
  assert_eq(s.coverage, 0.5)
  assert_eq(label_statistics(g.tiers[0])[1], LabelStat::{
    label: "",
    duration: 2,
    entries: 1,
  })
  assert_eq(summarize(g.tiers[1]).labelled_duration, 0)
  assert_eq(longest_intervals(g.tiers[0], 1, include_empty=true)[0].label, "")
  assert_eq(longest_intervals(g.tiers[0], 0).length(), 0)
  assert_eq(longest_intervals(g.tiers[0], 2).length(), 2)
}
