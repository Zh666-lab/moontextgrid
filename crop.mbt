///|
/// Extract a positive window fully inside the source domain.
/// Intervals are clipped, points include both window endpoints.
/// Adjacent clips can duplicate seam points; concat handles identical seam marks.
pub fn crop(
  g : Grid,
  start : Double,
  end : Double,
  rebase_to_zero~ : Bool = false,
) -> Grid raise GridError {
  validate(g)
  span(start, end)
  guard start >= g.start && end <= g.end else {
    raise Invalid("crop outside source domain")
  }
  let tiers : Array[Tier] = []
  for t in g.tiers {
    match t {
      Intervals(n, _, _, xs) => {
        let out : Array[Interval] = []
        for x in xs {
          let a = if x.start > start { x.start } else { start }
          let b = if x.end < end { x.end } else { end }
          if a < b {
            out.push({ start: a, end: b, label: x.label, })
          }
        }
        tiers.push(interval_tier(n, start, end, out))
      }
      Points(n, _, _, _) =>
        tiers.push(point_tier(n, start, end, points_between(t, start, end)))
    }
  }
  let out = grid(start, end, tiers)
  if rebase_to_zero {
    rebase(out, 0)
  } else {
    out
  }
}
