///|
pub(all) enum BridgePolicy {
  RequireAligned
  ExpandAndPad
} derive(Debug, Eq)

///|
/// Tier indices are zero based. Padding always has an empty label.
pub(all) enum BridgeChange {
  GridDomain(Double, Double, Double, Double)
  TierDomain(Int32, Double, Double, Double, Double)
  Padding(Int32, Double, Double)
} derive(Debug, Eq)

///|
pub(all) struct BridgeResult {
  grid : Grid
  changes : Array[BridgeChange]
} derive(Debug, Eq)

///|
/// RequireAligned never repairs data. ExpandAndPad takes the union of all
/// declared domains and entry times, changes metadata and pads only outer gaps.
/// Original annotation times/labels/order are never clipped, moved or merged.
/// Degenerate or unrepresentable editing spans return GridError, atomically.
pub fn document_to_grid(
  d : Document,
  policy~ : BridgePolicy = RequireAligned,
) -> BridgeResult raise GridError {
  validate_document(d)
  if policy == RequireAligned {
    return { grid: grid(d.start, d.end, d.tiers), changes: [], }
  }
  let mut a = d.start
  let mut b = d.end
  for t in d.tiers {
    match t {
      Intervals(_, lo, hi, xs) => {
        a = if a < lo { a } else { lo }
        b = if b > hi { b } else { hi }
        if !xs.is_empty() {
          a = if a < xs[0].start { a } else { xs[0].start }
          b = if b > xs[xs.length() - 1].end {
            b
          } else {
            xs[xs.length() - 1].end
          }
        }
      }
      Points(_, lo, hi, xs) => {
        a = if a < lo { a } else { lo }
        b = if b > hi { b } else { hi }
        if !xs.is_empty() {
          a = if a < xs[0].time { a } else { xs[0].time }
          b = if b > xs[xs.length() - 1].time {
            b
          } else {
            xs[xs.length() - 1].time
          }
        }
      }
    }
  }
  span(a, b)
  let changes : Array[BridgeChange] = []
  if a != d.start || b != d.end {
    changes.push(GridDomain(d.start, d.end, a, b))
  }
  let tiers : Array[Tier] = []
  for i, t in d.tiers {
    let (lo, hi) = match t {
      Intervals(_, lo, hi, _) | Points(_, lo, hi, _) => (lo, hi)
    }
    if lo != a || hi != b {
      changes.push(TierDomain(i, lo, hi, a, b))
    }
    match t {
      Intervals(name, _, _, xs) => {
        let out : Array[Interval] = []
        if xs.is_empty() {
          out.push({ start: a, end: b, label: "", })
          changes.push(Padding(i, a, b))
        } else {
          if a < xs[0].start {
            out.push({ start: a, end: xs[0].start, label: "", })
            changes.push(Padding(i, a, xs[0].start))
          }
          for x in xs {
            out.push(x)
          }
          let last = xs[xs.length() - 1].end
          if last < b {
            out.push({ start: last, end: b, label: "", })
            changes.push(Padding(i, last, b))
          }
        }
        tiers.push(interval_tier(name, a, b, out))
      }
      Points(name, _, _, xs) => tiers.push(point_tier(name, a, b, xs))
    }
  }
  { grid: grid(a, b, tiers), changes, }
}

///|
pub extend BridgePolicy with Eq::{equal, not_equal}

///|
pub extend BridgeChange with Eq::{equal, not_equal}

///|
pub extend BridgeResult with Eq::{equal, not_equal}

///|
pub extend BridgePolicy with @debug.Debug::{to_repr}

///|
pub extend BridgeChange with @debug.Debug::{to_repr}

///|
pub extend BridgeResult with @debug.Debug::{to_repr}
