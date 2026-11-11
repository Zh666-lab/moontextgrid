///|
pub(all) struct Overlap {
  start : Double
  end : Double
  left : String
  right : String
} derive(Debug, Eq)

///|
/// Sweep two ordered partitions in O(n+m); zero-duration contacts are omitted.
/// Different domains are allowed and only their intersection is returned.
pub fn overlaps(left : Tier, right : Tier) -> Array[Overlap] raise GridError {
  validate_tier(left)
  validate_tier(right)
  match (left, right) {
    (Intervals(_, _, _, xs), Intervals(_, _, _, ys)) => {
      let out : Array[Overlap] = []
      let mut i = 0
      let mut j = 0
      while i < xs.length() && j < ys.length() {
        let x = xs[i]
        let y = ys[j]
        let a = if x.start > y.start { x.start } else { y.start }
        let b = if x.end < y.end { x.end } else { y.end }
        if a < b {
          out.push({ start: a, end: b, left: x.label, right: y.label, })
        }
        if x.end <= y.end {
          i += 1
        }
        if y.end <= x.end {
          j += 1
        }
      }
      out
    }
    _ => raise Invalid("overlap requires two interval tiers")
  }
}

///|
/// Clip all positive intersections with a named label on a reference tier.
pub fn masked_intervals(
  source : Tier,
  mask : Tier,
  label : String,
) -> Array[Interval] raise GridError {
  let out : Array[Interval] = []
  for x in overlaps(source, mask) {
    if x.right == label {
      out.push({ start: x.start, end: x.end, label: x.left, })
    }
  }
  out
}

///|
pub extend Overlap with Eq::{equal, not_equal}

///|
pub extend Overlap with @debug.Debug::{to_repr}
