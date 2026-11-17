///|
fn main {
  try {
    for k in 0..<16 {
      let left = (k % 4 - 2).to_double()
      let right = (k % 3 + 4).to_double()
      let label = ["中文", "quote\"ok", "two\nlines", ""][k % 4]
      let tiers : Array[@tg.Tier] = [
        Intervals("词", left, right, [
          { start: 0, end: 1, label, },
          { start: 1, end: 2, label: "last", },
        ]),
        Points("事件", 0, 1, [
          { time: -1, label: "前", },
          { time: 6, label: "后", },
        ]),
      ]
      let d = @tg.document(0, 5, tiers)
      let r = @tg.document_to_grid(d, policy=ExpandAndPad)
      println(
        Json::object({
          "id": Json::number(k.to_double()),
          "long": Json::string(@tg.write_document_long(d)),
          "short": Json::string(@tg.write_document_short(d)),
          "edited_long": Json::string(@tg.write_long(r.grid)),
          "edited_short": Json::string(@tg.write_short(r.grid)),
        }).stringify(),
      )
    }
  } catch {
    e => abort("\{e.to_repr()}")
  }
}
