///|
/// Split strictly inside an interval; both new labels are explicit.
pub fn split_interval(
  t : Tier,
  time : Double,
  left : String,
  right : String,
) -> Tier raise GridError {
  validate_tier(t)
  guard finite(time) else { raise Invalid("nonfinite split time") }
  match t {
    Points(_, _, _, _) => raise Invalid("expected interval tier")
    Intervals(n, a, b, xs) => {
      let out : Array[Interval] = []
      let mut found = false
      for x in xs {
        if x.start < time && time < x.end {
          out.push({ start: x.start, end: time, label: left, })
          out.push({ start: time, end: x.end, label: right, })
          found = true
        } else {
          out.push(x)
        }
      }
      guard found else {
        raise Invalid("split must lie strictly inside an interval")
      }
      interval_tier(n, a, b, out)
    }
  }
}

///|
/// Merge a nonempty inclusive range; the replacement label is never guessed.
pub fn merge_intervals(
  t : Tier,
  first : Int32,
  last : Int32,
  label : String,
) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Points(_, _, _, _) => raise Invalid("expected interval tier")
    Intervals(n, a, b, xs) => {
      guard first >= 0 && first <= last && last < xs.length() else {
        raise Invalid("invalid merge range")
      }
      let out : Array[Interval] = []
      for i, x in xs {
        if i == first {
          out.push({ start: x.start, end: xs[last].end, label, })
        } else if i < first || i > last {
          out.push(x)
        }
      }
      interval_tier(n, a, b, out)
    }
  }
}

///|
pub fn relabel_interval(
  t : Tier,
  index : Int32,
  label : String,
) -> Tier raise GridError {
  merge_intervals(t, index, index, label)
}

///|
/// Collapse only adjacent equal labels; this preserves all covered time.
pub fn coalesce(t : Tier) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Points(_, _, _, _) => raise Invalid("expected interval tier")
    Intervals(n, a, b, xs) => {
      let out : Array[Interval] = []
      for x in xs {
        if !out.is_empty() && out[out.length() - 1].label == x.label {
          let k = out.length() - 1
          out[k] = { start: out[k].start, end: x.end, label: x.label, }
        } else {
          out.push(x)
        }
      }
      interval_tier(n, a, b, out)
    }
  }
}

///|
/// Move one internal boundary; endpoints and interval count remain fixed.
pub fn move_boundary(
  t : Tier,
  right_index : Int32,
  time : Double,
) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Points(_, _, _, _) => raise Invalid("expected interval tier")
    Intervals(n, a, b, xs) => {
      guard right_index > 0 && right_index < xs.length() else {
        raise Invalid("boundary index out of range")
      }
      let l = xs[right_index - 1]
      let r = xs[right_index]
      guard finite(time) && l.start < time && time < r.end else {
        raise Invalid("boundary would collapse an interval")
      }
      let out = xs.copy()
      out[right_index - 1] = { start: l.start, end: time, label: l.label, }
      out[right_index] = { start: time, end: r.end, label: r.label, }
      interval_tier(n, a, b, out)
    }
  }
}
