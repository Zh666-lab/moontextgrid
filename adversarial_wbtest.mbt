///|
fn fails(f : () -> Unit raise GridError) -> Bool {
  try {
    f()
    false
  } catch {
    _ => true
  }
}

///|
test "partitions reject gaps overlap collapse overflow and reversed endpoints" {
  for
    xs in [
      [
        Interval::{ start: 0, end: 1, label: "", },
        { start: 2, end: 4, label: "", },
      ],
      [{ start: 0, end: 3, label: "", }, { start: 2, end: 4, label: "", }],
      [{ start: 0, end: 0, label: "", }, { start: 0, end: 4, label: "", }],
      [{ start: 0, end: 5, label: "", }],
      [],
    ] {
    assert_true(
      fails(fn() raise GridError { let _ = interval_tier("x", 0, 4, xs) }),
    )
  }
  assert_true(
    fails(fn() raise GridError { let _ = grid(-1.0e308, 1.0e308, []) }),
  )
  assert_true(fails(fn() raise GridError { let _ = grid(1, 0, []) }))
}

///|
test "point validation rejects duplicates unordered outside and nonfinite" {
  for
    xs in [
      [Point::{ time: 1, label: "a", }, { time: 1, label: "b", }],
      [{ time: 2, label: "a", }, { time: 1, label: "b", }],
      [{ time: -1, label: "", }],
      [{ time: 5, label: "", }],
      [{ time: 0.0 / 0.0, label: "", }],
    ] {
    assert_true(
      fails(fn() raise GridError { let _ = point_tier("x", 0, 4, xs) }),
    )
  }
}

///|
test "constructors and getters copy nested mutable arrays" {
  let xs = [Interval::{ start: 0, end: 4, label: "a", }]
  let t = interval_tier("x", 0, 4, xs)
  xs[0] = { start: 0, end: 4, label: "b", }
  assert_eq(interval_at(t, 0).unwrap().label, "a")
  let ts = [t]
  let g = grid(0, 4, ts)
  ts[0] = point_tier("changed", 0, 4, [])
  let fetched = get_tier(g, 0)
  match fetched {
    Intervals(_, _, _, ys) => ys[0] = { start: 0, end: 4, label: "changed", }
    _ => ()
  }
  assert_eq(interval_at(g.tiers[0], 0).unwrap().label, "a")
}

///|
test "free standing values ignore display indices and exclamation comments" {
  let text = "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\nxmin = +0.0e0\nxmax = 4E+0\ntiers? <exists> ! 987 \"ignored\"\nsize = 1\nitem [999]:\nclass = \"IntervalTier\"\nname = \"word\"\nxmin = 0\nxmax = 4\nintervals: size = 1\nintervals [777]:\nxmin = 0\nxmax = 4\ntext = \"1, 2 ! 3\"\n"
  let g = parse_text(text)
  assert_eq(entry_count(g.tiers[0]), 1)
  assert_eq(interval_at(g.tiers[0], 1).unwrap().label, "1, 2 ! 3")
}

///|
test "truncated token prefixes never form a complete document" {
  let text = write_short(sample())
  for i in 0..<(text.length() - 2) {
    assert_true(
      fails(fn() raise GridError { let _ = parse_text(text[0:i].to_owned()) }),
    )
  }
}

///|
test "TextGrid budgets and class count grammar fail closed" {
  let s = write_short(sample())
  for
    limits in [
      Limits::{ input_units: 1, tokens: 1000, tiers: 10, entries: 10, },
      { input_units: 10000, tokens: 2, tiers: 10, entries: 10, },
      { input_units: 10000, tokens: 1000, tiers: 1, entries: 10, },
      { input_units: 10000, tokens: 1000, tiers: 10, entries: 5, },
      { input_units: 10000, tokens: 1000, tiers: -1, entries: 10, },
    ] {
    assert_true(fails(fn() raise GridError { let _ = parse_text(s, limits~) }))
  }
  for suffix in ["-1", "1.0", "1e2", "9999999999999999999999999999999"] {
    assert_true(
      fails(fn() raise GridError {
        let _ = parse_text("\"ooTextFile\" \"TextGrid\" 0 1 <exists> " + suffix)
      }),
    )
  }
  assert_true(fails(fn() raise GridError { let _ = parse_text(s + " 123") }))
  assert_true(
    fails(fn() raise GridError {
      let _ = parse_text(
        "\"ooTextFile\" \"TextGrid\" 0 1 <exists> 1 \"Unsupported\" \"x\" 0 1 0",
      )
    }),
  )
}

///|
test "malformed Unicode rejected rather than repaired" {
  for
    bytes in [
      b"\xc0\x80", b"\xed\xa0\x80", b"\xf4\x90\x80\x80", b"\xff\xfe\x00\xd8", b"\xfe\xff\xdc\x00",
    ] {
    assert_true(fails(fn() raise GridError { let _ = decode_text(bytes) }))
  }
  assert_eq(decode_text(b"\xef\xbb\xbfok"), "ok")
}

///|
test "all serializers reject externally mutated invalid models" {
  let g = sample()
  g.tiers[0] = Intervals("bad", 0, 4, [])
  assert_true(fails(fn() raise GridError { let _ = write_long(g) }))
  assert_true(fails(fn() raise GridError { let _ = write_short(g) }))
  assert_true(fails(fn() raise GridError { let _ = write_json(g) }))
  assert_true(fails(fn() raise GridError { let _ = write_csv(g) }))
  assert_true(fails(fn() raise GridError { let _ = write_bytes(g) }))
}

///|
test "JSON structural errors reject unsupported versions and wrong types" {
  for
    s in [
      "null", "[]", "{\"schema\":\"moontextgrid/2\"}", "{\"schema\":\"moontextgrid/1\",\"start\":\"0\",\"end\":1,\"tiers\":[]}",
      "{\"schema\":\"moontextgrid/1\",\"start\":0,\"end\":1,\"tiers\":[{\"kind\":\"point\",\"name\":\"x\",\"start\":0,\"end\":1,\"entries\":[[0]]}]}",
    ] {
    assert_true(fails(fn() raise GridError { let _ = parse_json(s) }))
  }
}

///|
test "CSV line endings and quoting preserve exact label characters" {
  let t = interval_tier("a,b", 0, 1, [
    { start: 0, end: 1, label: "comma, quote\" CR\r LF\n🙂", },
  ])
  let g = grid(0, 1, [t])
  assert_eq(parse_csv(write_csv(g)), g)
  for
    s in [
      "record,tier,name,start,end,label\ngrid,,,0,1,\n", "record,tier,name,start,end,label\rgrid,,,0,1,\r",
      "record,tier,name,start,end,label\r\ngrid,,,0,1,",
    ] {
    assert_eq(parse_csv(s), grid(0, 1, []))
  }
  for s in ["a,b,c,d,e,f,g", "a\"b,c,d,e,f,g", "\"a\" ,b,c,d,e,f"] {
    assert_true(
      fails(fn() raise GridError { let _ = csv_records(s, default_limits()) }),
    )
  }
}

///|
fn partition(n : Int32, offset : Int32) -> Tier raise GridError {
  let xs : Array[Interval] = []
  for i in 0..<n {
    xs.push({
      start: i.to_double(),
      end: (i + 1).to_double(),
      label: "\{(i+offset)%3}",
    })
  }
  interval_tier("x", 0, n.to_double(), xs)
}

///|
test "sweep agrees with independent quadratic intersections" {
  for n in 1..<=16 {
    let left = partition(n, 0)
    let right = scale(grid(0, n.to_double(), [partition(n, 1)]), 0.5).tiers[0]
    let actual = overlaps(left, right)
    let expected : Array[Overlap] = []
    match (left, right) {
      (Intervals(_, _, _, xs), Intervals(_, _, _, ys)) =>
        for x in xs {
          for y in ys {
            let a = if x.start > y.start { x.start } else { y.start }
            let b = if x.end < y.end { x.end } else { y.end }
            if a < b {
              expected.push({ start: a, end: b, left: x.label, right: y.label, })
            }
          }
        }
      _ => abort("bad fixture")
    }
    assert_eq(actual, expected)
  }
}

///|
fn optimal(
  xs : Array[Point],
  ys : Array[Point],
  i : Int32,
  j : Int32,
  tolerance : Double,
) -> Int32 {
  if i == xs.length() || j == ys.length() {
    return 0
  }
  let a = optimal(xs, ys, i + 1, j, tolerance)
  let b = optimal(xs, ys, i, j + 1, tolerance)
  let mut best = if a > b { a } else { b }
  let delta = ys[j].time - xs[i].time
  if delta >= -tolerance && delta <= tolerance {
    let c = 1 + optimal(xs, ys, i + 1, j + 1, tolerance)
    if c > best {
      best = c
    }
  }
  best
}

///|
test "greedy matching agrees with exhaustive order preserving optimum" {
  for left_mask in 0..<16 {
    for right_mask in 0..<16 {
      let xs : Array[Point] = []
      let ys : Array[Point] = []
      for i in 0..<4 {
        if (left_mask & (1 << i)) != 0 {
          xs.push({ time: i.to_double(), label: "", })
        }
        if (right_mask & (1 << i)) != 0 {
          ys.push({ time: i.to_double() + 0.25, label: "", })
        }
      }
      for tolerance in [0.0, 0.25, 0.75, 1.0] {
        let m = match_points(
          point_tier("l", 0, 4, xs),
          point_tier("r", 0, 4, ys),
          tolerance,
        )
        assert_eq(m.matches.length(), optimal(xs, ys, 0, 0, tolerance))
      }
    }
  }
}

///|
test "generated grids roundtrip every public exchange and conserve coverage" {
  for n in 1..<=32 {
    let g = grid(0, n.to_double(), [
      partition(n, 0),
      point_tier("empty", 0, n.to_double(), []),
    ])
    assert_eq(parse_text(write_long(g)), g)
    assert_eq(parse_text(write_short(g)), g)
    assert_eq(parse_csv(write_csv(g)), g)
    assert_eq(parse_json(write_json(g)), g)
    assert_eq(parse_bytes(write_bytes(g, encoding=Utf16BE)), g)
    assert_eq(summarize(g.tiers[0]).labelled_duration, n.to_double())
    assert_eq(agreement(g.tiers[0], g.tiers[0]).observed, 1)
  }
}
