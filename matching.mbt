///|
pub(all) struct PointMatch {
  reference_index : Int32
  hypothesis_index : Int32
  delta : Double
  same_label : Bool
} derive(Debug, Eq)

///|
pub(all) struct MatchSummary {
  matches : Array[PointMatch]
  reference_count : Int32
  hypothesis_count : Int32
  precision : Double
  recall : Double
  f1 : Double
} derive(Debug, Eq)

///|
/// Earliest-compatible greedy matching of sorted timestamps maximizes cardinality.
/// Labels do not constrain matching; same_label records categorical disagreement.
/// Scores are zero for an empty denominator, including two empty sequences.
pub fn match_points(
  reference : Tier,
  hypothesis : Tier,
  tolerance : Double,
) -> MatchSummary raise GridError {
  validate_tier(reference)
  validate_tier(hypothesis)
  guard finite(tolerance) && tolerance >= 0 else {
    raise Invalid("invalid matching tolerance")
  }
  match (reference, hypothesis) {
    (Points(_, a, b, xs), Points(_, c, d, ys)) => {
      guard a == c && b == d else { raise Invalid("point domains differ") }
      let matches : Array[PointMatch] = []
      let mut i = 0
      let mut j = 0
      while i < xs.length() && j < ys.length() {
        let delta = ys[j].time - xs[i].time
        if delta < -tolerance {
          j += 1
        } else if delta > tolerance {
          i += 1
        } else {
          matches.push({
            reference_index: i,
            hypothesis_index: j,
            delta,
            same_label: xs[i].label == ys[j].label,
          })
          i += 1
          j += 1
        }
      }
      let k = matches.length().to_double()
      let precision = if ys.is_empty() {
        0.0
      } else {
        k / ys.length().to_double()
      }
      let recall = if xs.is_empty() { 0.0 } else { k / xs.length().to_double() }
      let f1 = if precision + recall == 0 {
        0.0
      } else {
        2 * precision * recall / (precision + recall)
      }
      {
        matches,
        reference_count: xs.length(),
        hypothesis_count: ys.length(),
        precision,
        recall,
        f1,
      }
    }
    _ => raise Invalid("matching requires two point tiers")
  }
}

///|
/// Internal interval boundaries become unlabelled points; exterior endpoints omitted.
pub fn boundaries(t : Tier) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Points(_, _, _, _) => raise Invalid("expected interval tier")
    Intervals(n, a, b, xs) => {
      let out : Array[Point] = []
      for i in 1..<xs.length() {
        out.push({ time: xs[i].start, label: "", })
      }
      point_tier(n, a, b, out)
    }
  }
}

///|
pub fn match_boundaries(
  reference : Tier,
  hypothesis : Tier,
  tolerance : Double,
) -> MatchSummary raise GridError {
  match_points(boundaries(reference), boundaries(hypothesis), tolerance)
}

///|
pub extend PointMatch with Eq::{equal, not_equal}

///|
pub extend PointMatch with @debug.Debug::{to_repr}

///|
pub extend MatchSummary with Eq::{equal, not_equal}

///|
pub extend MatchSummary with @debug.Debug::{to_repr}
