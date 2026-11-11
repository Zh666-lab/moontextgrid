///|
/// Concatenate two grids by tier order, name and kind; right origin is discarded.
/// At a seam, identical point labels are deduplicated; conflicting labels fail.
pub fn concatenate(left : Grid, right : Grid) -> Grid raise GridError {
  validate(left)
  validate(right)
  guard left.tiers.length() == right.tiers.length() else {
    raise Invalid("tier count differs")
  }
  let shifted = rebase(right, left.end)
  let tiers : Array[Tier] = []
  for i, l in left.tiers {
    let r = shifted.tiers[i]
    guard tier_name(l) == tier_name(r) else {
      raise Invalid("tier names or order differ")
    }
    match (l, r) {
      (Intervals(n, _, _, xs), Intervals(_, _, _, ys)) => {
        let out = xs.copy()
        for y in ys {
          out.push(y)
        }
        tiers.push(interval_tier(n, left.start, shifted.end, out))
      }
      (Points(n, _, _, xs), Points(_, _, _, ys)) => {
        let out = xs.copy()
        for y in ys {
          if !out.is_empty() && out[out.length() - 1].time == y.time {
            guard out[out.length() - 1].label == y.label else {
              raise Invalid("conflicting point labels at join")
            }
          } else {
            out.push(y)
          }
        }
        tiers.push(point_tier(n, left.start, shifted.end, out))
      }
      _ => raise Invalid("tier kinds differ")
    }
  }
  grid(left.start, shifted.end, tiers)
}
