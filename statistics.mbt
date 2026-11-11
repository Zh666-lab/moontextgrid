///|
pub(all) struct LabelStat {
  label : String
  duration : Double
  entries : Int32
} derive(Debug, Eq)

///|
pub(all) struct TierSummary {
  name : String
  duration : Double
  entries : Int32
  labelled_entries : Int32
  labelled_duration : Double
  coverage : Double
} derive(Debug, Eq)

///|
/// First-occurrence label ordering is deterministic, including the empty label.
/// Points contribute entry counts and zero duration.
pub fn label_statistics(t : Tier) -> Array[LabelStat] raise GridError {
  validate_tier(t)
  let order : Array[String] = []
  let counts : Map[String, Int32] = Map([])
  let durations : Map[String, Double] = Map([])
  let add = fn(label : String, duration : Double) {
    if !counts.contains(label) {
      order.push(label)
    }
    counts[label] = counts.get(label).unwrap_or(0) + 1
    durations[label] = durations.get(label).unwrap_or(0.0) + duration
  }
  match t {
    Intervals(_, _, _, xs) =>
      for x in xs {
        add(x.label, x.end - x.start)
      }
    Points(_, _, _, xs) =>
      for x in xs {
        add(x.label, 0)
      }
  }
  order.map(fn(label) {
    { label, duration: durations[label], entries: counts[label], }
  })
}

///|
/// Empty string alone counts as unlabelled; whitespace is a meaningful label.
/// Point tiers report zero duration coverage, not an invented continuous span.
pub fn summarize(t : Tier) -> TierSummary raise GridError {
  validate_tier(t)
  let (a, b) = tier_bounds(t)
  let mut entries = 0
  let mut labelled_entries = 0
  let mut labelled_duration = 0.0
  for s in label_statistics(t) {
    entries += s.entries
    if s.label != "" {
      labelled_entries += s.entries
      labelled_duration += s.duration
    }
  }
  let coverage = labelled_duration / (b - a)
  {
    name: tier_name(t),
    duration: b - a,
    entries,
    labelled_entries,
    labelled_duration,
    coverage,
  }
}

///|
/// Longest labelled intervals first, retaining source order for equal duration.
/// Insertion into a bounded result keeps memory O(limit), useful for corpus review.
pub fn longest_intervals(
  t : Tier,
  limit : Int32,
  include_empty~ : Bool = false,
) -> Array[Interval] raise GridError {
  validate_tier(t)
  guard limit >= 0 && limit <= 100000 else {
    raise Invalid("invalid result limit")
  }
  match t {
    Points(_, _, _, _) => raise Invalid("expected interval tier")
    Intervals(_, _, _, xs) => {
      let out : Array[Interval] = []
      for x in xs {
        if (include_empty || x.label != "") && limit > 0 {
          let mut position = out.length()
          for j, y in out {
            if x.end - x.start > y.end - y.start {
              position = j
              break
            }
          }
          if position < limit {
            out.push(x)
            let mut j = out.length() - 1
            while j > position {
              out[j] = out[j - 1]
              j -= 1
            }
            out[position] = x
            if out.length() > limit {
              let _ = out.pop()
            }
          }
        }
      }
      out
    }
  }
}

///|
pub extend LabelStat with Eq::{equal, not_equal}

///|
pub extend LabelStat with @debug.Debug::{to_repr}

///|
pub extend TierSummary with Eq::{equal, not_equal}

///|
pub extend TierSummary with @debug.Debug::{to_repr}
