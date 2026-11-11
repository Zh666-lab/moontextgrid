///|
/// Apply an increasing affine map around a chosen origin.
/// Finite overflow and precision-induced collapsed intervals are rejected.
pub fn affine(
  g : Grid,
  origin : Double,
  factor : Double,
  offset : Double,
) -> Grid raise GridError {
  validate(g)
  guard finite(origin) && finite(factor) && factor > 0 && finite(offset) else {
    raise Invalid("invalid affine parameters")
  }
  let f = fn(t : Double) { origin + (t - origin) * factor + offset }
  let a = f(g.start)
  let b = f(g.end)
  span(a, b)
  let tiers : Array[Tier] = []
  for t in g.tiers {
    match t {
      Intervals(n, _, _, xs) =>
        tiers.push(
          interval_tier(
            n,
            a,
            b,
            xs.map(fn(x) {
              { start: f(x.start), end: f(x.end), label: x.label, }
            }),
          ),
        )
      Points(n, _, _, xs) =>
        tiers.push(
          point_tier(
            n,
            a,
            b,
            xs.map(fn(x) { { time: f(x.time), label: x.label, } }),
          ),
        )
    }
  }
  grid(a, b, tiers)
}

///|
pub fn shift(g : Grid, offset : Double) -> Grid raise GridError {
  affine(g, 0, 1, offset)
}

///|
/// Stretch around the grid start, retaining that start exactly.
pub fn scale(g : Grid, factor : Double) -> Grid raise GridError {
  affine(g, g.start, factor, 0)
}

///|
/// Rebase the grid without changing durations.
pub fn rebase(g : Grid, new_start : Double) -> Grid raise GridError {
  validate(g)
  guard finite(new_start) else { raise Invalid("nonfinite target origin") }
  affine(g, g.start, 1, new_start - g.start)
}
