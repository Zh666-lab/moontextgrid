///|
pub fn rename_tier(t : Tier, name : String) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Intervals(_, a, b, xs) => interval_tier(name, a, b, xs)
    Points(_, a, b, xs) => point_tier(name, a, b, xs)
  }
}

///|
pub fn replace_tier(g : Grid, index : Int32, t : Tier) -> Grid raise GridError {
  validate(g)
  guard index >= 0 && index < g.tiers.length() else {
    raise Invalid("tier index out of range")
  }
  let out = g.tiers.copy()
  out[index] = t
  grid(g.start, g.end, out)
}

///|
/// Insert before index; appending at length is permitted.
pub fn insert_tier(g : Grid, index : Int32, t : Tier) -> Grid raise GridError {
  validate(g)
  guard index >= 0 && index <= g.tiers.length() else {
    raise Invalid("tier index out of range")
  }
  let out : Array[Tier] = []
  for i in 0..<=g.tiers.length() {
    if i == index {
      out.push(t)
    }
    if i < g.tiers.length() {
      out.push(g.tiers[i])
    }
  }
  grid(g.start, g.end, out)
}

///|
pub fn remove_tier(g : Grid, index : Int32) -> Grid raise GridError {
  validate(g)
  guard index >= 0 && index < g.tiers.length() else {
    raise Invalid("tier index out of range")
  }
  let out : Array[Tier] = []
  for i, t in g.tiers {
    if i != index {
      out.push(t)
    }
  }
  grid(g.start, g.end, out)
}

///|
/// Apply label mapping to intervals or points; callback side effects belong to caller.
pub fn map_labels(t : Tier, f : (String) -> String) -> Tier raise GridError {
  validate_tier(t)
  match t {
    Intervals(n, a, b, xs) =>
      interval_tier(
        n,
        a,
        b,
        xs.map(fn(x) { { start: x.start, end: x.end, label: f(x.label), } }),
      )
    Points(n, a, b, xs) =>
      point_tier(
        n,
        a,
        b,
        xs.map(fn(x) { { time: x.time, label: f(x.label), } }),
      )
  }
}
