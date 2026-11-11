///|
/// Insert a distinct timestamp in sorted order; duplicate timestamps are errors.
pub fn insert_point(
  t : Tier,
  time : Double,
  label : String,
) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Intervals(_, _, _, _) => raise Invalid("expected point tier")
    Points(n, a, b, xs) => {
      guard finite(time) && time >= a && time <= b else {
        raise Invalid("point outside tier")
      }
      let out : Array[Point] = []
      let mut inserted = false
      for x in xs {
        guard x.time != time else { raise Invalid("duplicate point timestamp") }
        if !inserted && time < x.time {
          out.push({ time, label, })
          inserted = true
        }
        out.push(x)
      }
      if !inserted {
        out.push({ time, label, })
      }
      point_tier(n, a, b, out)
    }
  }
}

///|
pub fn delete_point(t : Tier, index : Int32) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Intervals(_, _, _, _) => raise Invalid("expected point tier")
    Points(n, a, b, xs) => {
      guard index >= 0 && index < xs.length() else {
        raise Invalid("point index out of range")
      }
      let out : Array[Point] = []
      for i, x in xs {
        if i != index {
          out.push(x)
        }
      }
      point_tier(n, a, b, out)
    }
  }
}

///|
pub fn relabel_point(
  t : Tier,
  index : Int32,
  label : String,
) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Intervals(_, _, _, _) => raise Invalid("expected point tier")
    Points(n, a, b, xs) => {
      guard index >= 0 && index < xs.length() else {
        raise Invalid("point index out of range")
      }
      let out = xs.copy()
      out[index] = { time: xs[index].time, label, }
      point_tier(n, a, b, out)
    }
  }
}

///|
/// A point may cross neighbours; remove then reinsert to retain ordering.
pub fn move_point(
  t : Tier,
  index : Int32,
  time : Double,
) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Intervals(_, _, _, _) => raise Invalid("expected point tier")
    Points(_, _, _, xs) => {
      guard index >= 0 && index < xs.length() else {
        raise Invalid("point index out of range")
      }
      insert_point(delete_point(t, index), time, xs[index].label)
    }
  }
}
