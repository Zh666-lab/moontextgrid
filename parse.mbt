///|
pub fn parse_text(
  text : String,
  limits~ : Limits = default_limits(),
) -> Grid raise GridError {
  let r = Reader::{ tokens: tokenize(text, limits), pos: 0, }
  let header = r.string()
  guard header == "ooTextFile" || header == "ooTextFile short" else {
    raise Invalid("unsupported TextGrid header")
  }
  guard r.string() == "TextGrid" else { raise Invalid("not a TextGrid object") }
  let a = r.number()
  let b = r.number()
  span(a, b)
  let presence = r.take()
  guard !presence.quoted else { raise Invalid("expected tier presence flag") }
  let tiers : Array[Tier] = []
  if presence.text == "<exists>" {
    let n = r.count(limits.tiers)
    let mut remaining = limits.entries
    for _ in 0..<n {
      let kind = r.string()
      let name = r.string()
      let start = r.number()
      let end = r.number()
      let count = r.count(remaining)
      remaining -= count
      match kind {
        "IntervalTier" => {
          let xs : Array[Interval] = []
          for _ in 0..<count {
            let lo = r.number()
            let hi = r.number()
            let label = r.string()
            xs.push({ start: lo, end: hi, label, })
          }
          tiers.push(interval_tier(name, start, end, xs))
        }
        "TextTier" => {
          let xs : Array[Point] = []
          for _ in 0..<count {
            let time = r.number()
            let label = r.string()
            xs.push({ time, label, })
          }
          tiers.push(point_tier(name, start, end, xs))
        }
        _ => raise Invalid("unsupported tier class")
      }
    }
  } else {
    guard presence.text == "<absent>" else {
      raise Invalid("invalid tier presence flag")
    }
  }
  guard r.pos == r.tokens.length() else {
    raise Invalid("unexpected trailing data")
  }
  grid(a, b, tiers)
}
