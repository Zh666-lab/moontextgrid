///|
pub(all) struct Confusion {
  reference : String
  hypothesis : String
  duration : Double
} derive(Debug, Eq)

///|
pub(all) struct Agreement {
  duration : Double
  matching_duration : Double
  observed : Double
  expected : Double
  kappa : Double?
  confusion : Array[Confusion]
} derive(Debug, Eq)

///|
/// Time-weighted categorical agreement over identical domains, including silence.
/// Kappa is undefined (None) if chance agreement equals one.
pub fn agreement(
  reference : Tier,
  hypothesis : Tier,
) -> Agreement raise GridError {
  validate_tier(reference)
  validate_tier(hypothesis)
  let (a, b) = tier_bounds(reference)
  guard tier_bounds(hypothesis) == (a, b) else {
    raise Invalid("agreement domains differ")
  }
  let duration = b - a
  let reference_counts : Map[String, Double] = Map([])
  let hypothesis_counts : Map[String, Double] = Map([])
  let cells : Map[(String, String), Double] = Map([])
  let order : Array[(String, String)] = []
  let mut matching_duration = 0.0
  for x in overlaps(reference, hypothesis) {
    let d = x.end - x.start
    if x.left == x.right {
      matching_duration += d
    }
    reference_counts[x.left] = reference_counts.get(x.left).unwrap_or(0.0) + d
    hypothesis_counts[x.right] = hypothesis_counts.get(x.right).unwrap_or(0.0) +
      d
    let pair = (x.left, x.right)
    if !cells.contains(pair) {
      order.push(pair)
    }
    cells[pair] = cells.get(pair).unwrap_or(0.0) + d
  }
  let mut expected = 0.0
  for label, d in reference_counts {
    expected += d /
      duration *
      (hypothesis_counts.get(label).unwrap_or(0.0) / duration)
  }
  let observed = matching_duration / duration
  let kappa = if expected >= 1.0 {
    None
  } else {
    Some((observed - expected) / (1.0 - expected))
  }
  let confusion = order.map(fn(pair) {
    let (r, h) = pair
    { reference: r, hypothesis: h, duration: cells[pair], }
  })
  { duration, matching_duration, observed, expected, kappa, confusion, }
}

///|
pub extend Confusion with Eq::{equal, not_equal}

///|
pub extend Confusion with @debug.Debug::{to_repr}

///|
pub extend Agreement with Eq::{equal, not_equal}

///|
pub extend Agreement with @debug.Debug::{to_repr}
