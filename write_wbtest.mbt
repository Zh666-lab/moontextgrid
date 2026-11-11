///|
fn sample() -> Grid raise GridError {
  grid(0, 4, [
    interval_tier("words", 0, 4, [
      { start: 0, end: 1, label: "你好\"", },
      { start: 1, end: 3, label: "", },
      { start: 3, end: 4, label: "世界\n🙂", },
    ]),
    point_tier("events", 0, 4, [
      { time: 0, label: "start", },
      { time: 2, label: "tap", },
      { time: 4, label: "end", },
    ]),
  ])
}

///|
test "long and short serialization preserve multilingual multiline labels" {
  let g = sample()
  assert_eq(parse_text(write_long(g)), g)
  assert_eq(parse_text(write_short(g)), g)
  assert_eq(write_short(parse_text(write_long(g))), write_short(g))
}
