///|
/// Errors identify malformed input without including private annotation text.
pub suberror GridError {
  Invalid(String)
} derive(Debug)

///|
pub(all) struct Interval {
  start : Double
  end : Double
  label : String
} derive(Debug, Eq)

///|
pub(all) struct Point {
  time : Double
  label : String
} derive(Debug, Eq)

///|
pub(all) enum Tier {
  Intervals(String, Double, Double, Array[Interval])
  Points(String, Double, Double, Array[Point])
} derive(Debug, Eq)

///|
pub(all) struct Grid {
  start : Double
  end : Double
  tiers : Array[Tier]
} derive(Debug, Eq)

///|
pub(all) struct Limits {
  input_units : Int32
  tokens : Int32
  tiers : Int32
  entries : Int32
} derive(Debug, Eq)

///|
pub fn default_limits() -> Limits {
  { input_units: 8000000, tokens: 1000000, tiers: 1000, entries: 100000, }
}

///|
fn finite(x : Double) -> Bool {
  x == x && x <= 1.7976931348623157e308 && x >= -1.7976931348623157e308
}

///|
fn span(a : Double, b : Double) -> Unit raise GridError {
  guard finite(a) && finite(b) && a < b && finite(b - a) else {
    raise Invalid("expected finite positive time span")
  }
}

///|
pub fn tier_name(t : Tier) -> String {
  match t {
    Intervals(n, _, _, _) | Points(n, _, _, _) => n
  }
}

///|
pub fn validate_tier(t : Tier) -> Unit raise GridError {
  match t {
    Intervals(_, a, b, xs) => {
      span(a, b)
      guard !xs.is_empty() else { raise Invalid("empty interval partition") }
      let mut cursor = a
      for x in xs {
        span(x.start, x.end)
        guard x.start == cursor && x.end <= b else {
          raise Invalid("noncontiguous or out-of-bounds interval")
        }
        cursor = x.end
      }
      guard cursor == b else {
        raise Invalid("interval partition does not cover tier")
      }
    }
    Points(_, a, b, xs) => {
      span(a, b)
      let mut prev = a
      for i, x in xs {
        guard finite(x.time) && x.time >= a && x.time <= b else {
          raise Invalid("point outside tier")
        }
        guard i == 0 || x.time > prev else {
          raise Invalid("points not strictly increasing")
        }
        prev = x.time
      }
    }
  }
}

///|
pub fn validate(g : Grid) -> Unit raise GridError {
  span(g.start, g.end)
  for t in g.tiers {
    validate_tier(t)
    let (a, b) = match t {
      Intervals(_, a, b, _) | Points(_, a, b, _) => (a, b)
    }
    guard a == g.start && b == g.end else {
      raise Invalid("tier bounds must equal grid bounds")
    }
  }
}

///|
pub fn copy_tier(t : Tier) -> Tier {
  match t {
    Intervals(n, a, b, xs) => Intervals(n, a, b, xs.copy())
    Points(n, a, b, xs) => Points(n, a, b, xs.copy())
  }
}

///|
pub fn copy_grid(g : Grid) -> Grid {
  { start: g.start, end: g.end, tiers: g.tiers.map(copy_tier), }
}

///|
pub fn grid(
  a : Double,
  b : Double,
  tiers : Array[Tier],
) -> Grid raise GridError {
  let g = { start: a, end: b, tiers: tiers.map(copy_tier), }
  validate(g)
  g
}

///|
pub fn interval_tier(
  name : String,
  a : Double,
  b : Double,
  xs : Array[Interval],
) -> Tier raise GridError {
  let t = Intervals(name, a, b, xs.copy())
  validate_tier(t)
  t
}

///|
pub fn point_tier(
  name : String,
  a : Double,
  b : Double,
  xs : Array[Point],
) -> Tier raise GridError {
  let t = Points(name, a, b, xs.copy())
  validate_tier(t)
  t
}

///|
pub extend Interval with Eq::{equal, not_equal}

///|
pub extend Point with Eq::{equal, not_equal}

///|
pub extend Tier with Eq::{equal, not_equal}

///|
pub extend Grid with Eq::{equal, not_equal}

///|
pub extend Limits with Eq::{equal, not_equal}

///|
pub extend GridError with @debug.Debug::{to_repr}

///|
pub extend Interval with @debug.Debug::{to_repr}

///|
pub extend Point with @debug.Debug::{to_repr}

///|
pub extend Tier with @debug.Debug::{to_repr}

///|
pub extend Grid with @debug.Debug::{to_repr}

///|
pub extend Limits with @debug.Debug::{to_repr}
