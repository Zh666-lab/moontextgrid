///|
fn main {
  let text = "\"ooTextFile short\"\n\"TextGrid\"\n0\n3\n<exists>\n1\n\"IntervalTier\"\n\"words\"\n0\n3\n2\n0\n1\n\"你好\"\n1\n3\n\"世界\"\n"
  let g = @tg.parse_text(text) catch { e => abort("\{e.to_repr()}") }
  let normalized = @tg.write_long(g) catch { e => abort("\{e.to_repr()}") }
  let restored = @tg.parse_text(normalized) catch {
    e => abort("\{e.to_repr()}")
  }
  let s = @tg.summarize(restored.tiers[0]) catch {
    e => abort("\{e.to_repr()}")
  }
  println(
    "import: tiers=\{restored.tiers.length()} entries=\{s.entries} coverage=\{s.coverage}",
  )
}
