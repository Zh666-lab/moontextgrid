///|
fn main {
  try {
    let reference = @tg.interval_tier("reference", 0, 4, [
      { start: 0, end: 2, label: "a", },
      { start: 2, end: 4, label: "b", },
    ])
    let candidate = @tg.interval_tier("candidate", 0, 4, [
      { start: 0, end: 1, label: "a", },
      { start: 1, end: 4, label: "b", },
    ])
    let result = @tg.agreement(reference, candidate)
    let boundaries = @tg.match_boundaries(reference, candidate, 1)
    let data = @tg.grid(0, 4, [reference, candidate])
    let restored = @tg.parse_json(@tg.write_json(data))
    println(
      "evaluate: observed=\{result.observed} boundary_f1=\{boundaries.f1} exported_tiers=\{restored.tiers.length()}",
    )
  } catch {
    e => abort("\{e.to_repr()}")
  }
}
