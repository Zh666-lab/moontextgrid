///|
fn main {
  try {
    let input = "\"ooTextFile short\" \"TextGrid\" 0 5 <exists> 1 \"IntervalTier\" \"words\" 1 4 1 2 3 \"hello\""
    let doc = @tg.parse_document(input)
    let preserved = @tg.write_document_short(doc)
    let result = @tg.document_to_grid(doc, policy=ExpandAndPad)
    let edited = @tg.replace_tier(
      result.grid,
      0,
      @tg.split_interval(result.grid.tiers[0], 2.5, "hel", "lo"),
    )
    let output = @tg.write_short(edited)
    println("INPUT\n" + input)
    println("PRESERVED\n" + preserved)
    println("CHANGES")
    for change in result.changes {
      println("\{change.to_repr()}")
    }
    println("OUTPUT\n" + output)
    let _ = @tg.parse_text(output)
    println("compatibility: preserved=true changes=3 edited_intervals=4")
  } catch {
    e => abort("\{e.to_repr()}")
  }
}
