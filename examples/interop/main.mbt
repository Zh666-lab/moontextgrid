///|
fn main {
  try {
    for k in 1..<=12 {
      let xs : Array[@tg.Interval] = []
      for i in 0..<k {
        let label = match i % 4 {
          0 => "词语"
          1 => ""
          2 => "quote\"ok"
          _ => "café"
        }
        xs.push({
          start: i.to_double() * 0.25,
          end: (i + 1).to_double() * 0.25,
          label,
        })
      }
      let end = k.to_double() * 0.25
      let g = @tg.grid(0, end, [
        @tg.interval_tier("words", 0, end, xs),
        @tg.point_tier("events", 0, end, [
          { time: 0, label: "start", },
          { time: end, label: "end", },
        ]),
      ])
      println(
        Json::object({
          "long": Json::string(@tg.write_long(g)),
          "short": Json::string(@tg.write_short(g)),
          "expected": @tg.to_json(g),
        }).stringify(),
      )
    }
  } catch {
    e => abort("\{e.to_repr()}")
  }
}
