///|
/// Tier names need not be unique: return every matching index in document order.
pub fn find_tiers(g : Grid, name : String) -> Array[Int32] {
  let out : Array[Int32] = []
  for i, t in g.tiers {
    if tier_name(t) == name {
      out.push(i)
    }
  }
  out
}

///|
pub fn get_tier(g : Grid, index : Int32) -> Tier raise GridError {
  guard index >= 0 && index < g.tiers.length() else {
    raise Invalid("tier index out of range")
  }
  copy_tier(g.tiers[index])
}

///|
pub fn tier_bounds(t : Tier) -> (Double, Double) {
  match t {
    Intervals(_, a, b, _) | Points(_, a, b, _) => (a, b)
  }
}

///|
pub fn entry_count(t : Tier) -> Int32 {
  match t {
    Intervals(_, _, _, xs) => xs.length()
    Points(_, _, _, xs) => xs.length()
  }
}

///|
/// Intervals are left closed and right open, except that the final end is included.
/// Binary search returns the interval to the right of an internal boundary.
pub fn interval_at(t : Tier, time : Double) -> Interval? raise GridError {
  validate_tier(t)
  guard finite(time) else { raise Invalid("nonfinite query time") }
  match t {
    Points(_, _, _, _) => raise Invalid("expected interval tier")
    Intervals(_, a, b, xs) => {
      if time < a || time > b {
        return None
      }
      let mut lo = 0
      let mut hi = xs.length()
      while lo < hi {
        let mid = lo + (hi - lo) / 2
        if xs[mid].end <= time {
          lo = mid + 1
        } else {
          hi = mid
        }
      }
      Some(xs[if lo == xs.length() { lo - 1 } else { lo }])
    }
  }
}

///|
/// Inclusive window for discrete events. Returned array belongs to the caller.
pub fn points_between(
  t : Tier,
  a : Double,
  b : Double,
) -> Array[Point] raise GridError {
  validate_tier(t)
  guard finite(a) && finite(b) && a <= b else {
    raise Invalid("invalid point window")
  }
  match t {
    Intervals(_, _, _, _) => raise Invalid("expected point tier")
    Points(_, _, _, xs) => {
      let mut lo = 0
      let mut hi = xs.length()
      while lo < hi {
        let mid = lo + (hi - lo) / 2
        if xs[mid].time < a {
          lo = mid + 1
        } else {
          hi = mid
        }
      }
      let out : Array[Point] = []
      while lo < xs.length() && xs[lo].time <= b {
        out.push(xs[lo])
        lo += 1
      }
      out
    }
  }
}

///|
pub fn select_tiers(g : Grid, indices : Array[Int32]) -> Grid raise GridError {
  validate(g)
  let out : Array[Tier] = []
  for i in indices {
    out.push(get_tier(g, i))
  }
  grid(g.start, g.end, out)
}
