///|
fn main {
  try {
    let t = @tg.interval_tier("words", 0, 4, [
      { start: 0, end: 2, label: "原文", },
      { start: 2, end: 4, label: "结束", },
    ])
    let source = @tg.grid(0, 4, [t])
    let edited = @tg.replace_tier(
      source,
      0,
      @tg.split_interval(t, 1, "前半", "后半"),
    )
    let first = @tg.crop(edited, 0.5, 1.5, rebase_to_zero=true)
    let second = @tg.crop(edited, 2, 4, rebase_to_zero=true)
    let joined = @tg.concatenate(first, second)
    let csv = @tg.write_csv(joined)
    let restored = @tg.parse_csv(csv)
    println(
      "clips: start=\{restored.start} end=\{restored.end} entries=\{@tg.entry_count(restored.tiers[0])}",
    )
  } catch {
    e => abort("\{e.to_repr()}")
  }
}
