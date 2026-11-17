///|
fn weak_document() -> Document raise GridError {
  document(0, 5, [
    Intervals("词", 1, 4, [{ start: 2, end: 3, label: "原标签", }]),
    Points("事件", 0, 1, [
      { time: -1, label: "前", },
      { time: 6, label: "后", },
    ]),
  ])
}

///|
test "official weak domains survive long short and unicode byte roundtrips" {
  let d = weak_document()
  assert_eq(parse_document(write_document_long(d)), d)
  assert_eq(parse_document(write_document_short(d)), d)
  for encoding in [Utf8, Utf16LE, Utf16BE] {
    for short in [false, true] {
      assert_eq(
        parse_document_bytes(write_document_bytes(d, encoding~, short~)),
        d,
      )
    }
  }
}

///|
test "strict default bridge and original parser reject misaligned domains" {
  let d = weak_document()
  assert_true(
    try {
      let _ = document_to_grid(d)
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = parse_text(write_document_short(d))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(
    d.tiers[0],
    Intervals("词", 1, 4, [{ start: 2, end: 3, label: "原标签", }]),
  )
}

///|
test "expansion preserves all annotations and reports every metadata and padding change" {
  let d = weak_document()
  let result = document_to_grid(d, policy=ExpandAndPad)
  assert_eq(result.grid.start, -1)
  assert_eq(result.grid.end, 6)
  assert_eq(result.changes, [
    GridDomain(0, 5, -1, 6),
    TierDomain(0, 1, 4, -1, 6),
    Padding(0, -1, 2),
    Padding(0, 3, 6),
    TierDomain(1, 0, 1, -1, 6),
  ])
  assert_eq(
    result.grid.tiers[0],
    Intervals("词", -1, 6, [
      { start: -1, end: 2, label: "", },
      { start: 2, end: 3, label: "原标签", },
      { start: 3, end: 6, label: "", },
    ]),
  )
  assert_eq(
    result.grid.tiers[1],
    Points("事件", -1, 6, [
      { time: -1, label: "前", },
      { time: 6, label: "后", },
    ]),
  )
  validate(result.grid)
  assert_eq(parse_text(write_long(result.grid)), result.grid)
  let again = document_to_grid(
    document_from_grid(result.grid),
    policy=ExpandAndPad,
  )
  assert_eq(again.grid, result.grid)
  assert_true(again.changes.is_empty())
}

///|
test "grid domain expands for outer tier metadata even without entries" {
  let d = document(1, 2, [Intervals("empty", -2, 4, []), Points("p", 0, 3, [])])
  let r = document_to_grid(d, policy=ExpandAndPad)
  assert_eq(r.grid.start, -2)
  assert_eq(r.grid.end, 4)
  assert_eq(r.changes, [
    GridDomain(1, 2, -2, 4),
    Padding(0, -2, 4),
    TierDomain(1, 0, 3, -2, 4),
  ])
  assert_eq(
    r.grid.tiers[0],
    Intervals("empty", -2, 4, [{ start: -2, end: 4, label: "", }]),
  )
}

///|
test "entry extent overrides narrower declared tier and grid domains" {
  let d = document(0, 1, [
    Intervals("", 0, 1, [
      { start: -3, end: 0, label: "", },
      { start: 0, end: 4, label: "keep", },
    ]),
  ])
  let r = document_to_grid(d, policy=ExpandAndPad)
  assert_eq(r.changes, [GridDomain(0, 1, -3, 4), TierDomain(0, 0, 1, -3, 4)])
  assert_eq(
    r.grid.tiers[0],
    Intervals("", -3, 4, [
      { start: -3, end: 0, label: "", },
      { start: 0, end: 4, label: "keep", },
    ]),
  )
}

///|
test "empty degenerate document is serializable but not editable without a positive domain" {
  let d = document(1, 1, [Intervals("i", 1, 1, []), Points("p", 1, 1, [])])
  assert_eq(parse_document(write_document_short(d)), d)
  assert_true(
    try {
      let _ = document_to_grid(d, policy=ExpandAndPad)
      false
    } catch {
      _ => true
    },
  )
  let zero = document(0, 0, [])
  assert_eq(parse_document(write_document_long(zero)), zero)
}

///|
test "finite document extremes roundtrip while unrepresentable editing span fails atomically" {
  let d = document(-1.0e308, 1.0e308, [
    Intervals("wide", -1.0e308, 1.0e308, [
      { start: -1.0e308, end: 1.0e308, label: "x", },
    ]),
  ])
  assert_eq(parse_document(write_document_short(d)), d)
  assert_true(
    try {
      let _ = document_to_grid(d, policy=ExpandAndPad)
      false
    } catch {
      _ => true
    },
  )
}

///|
test "weak document still rejects gaps overlaps zero duration and unordered points" {
  for
    xs in [
      [{ start: 0, end: 1, label: "a", }, { start: 2, end: 3, label: "b", }],
      [{ start: 0, end: 2, label: "a", }, { start: 1, end: 3, label: "b", }],
      [{ start: 1, end: 1, label: "zero", }],
    ] {
    assert_true(
      try {
        let _ = document(0, 3, [Intervals("", 0, 3, xs)])
        false
      } catch {
        _ => true
      },
    )
  }
  for times in [[1.0, 1], [2.0, 1]] {
    assert_true(
      try {
        let _ = document(0, 3, [
          Points("", 0, 3, times.map(fn(t) { { time: t, label: "x", } })),
        ])
        false
      } catch {
        _ => true
      },
    )
  }
  assert_true(
    try {
      let _ = document(2, 1, [])
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = document(0, 1, [
        Points("", 0, 1, [{ time: 0.0 / 0.0, label: "", }]),
      ])
      false
    } catch {
      _ => true
    },
  )
}

///|
test "document writers revalidate externally mutated arrays and bridge owns result arrays" {
  let tiers : Array[Tier] = [Points("p", 0, 1, [{ time: 2, label: "keep", }])]
  let d = document(0, 1, tiers)
  tiers.clear()
  assert_eq(d.tiers.length(), 1)
  let r = document_to_grid(d, policy=ExpandAndPad)
  r.grid.tiers.clear()
  assert_eq(d.tiers.length(), 1)
  match d.tiers[0] {
    Points(_, _, _, xs) => xs.push({ time: 1, label: "bad", })
    _ => ()
  }
  assert_true(
    try {
      let _ = write_document_long(d)
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = write_document_short(d)
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      let _ = document_to_grid(d, policy=ExpandAndPad)
      false
    } catch {
      _ => true
    },
  )
}

///|
test "weak document parsing shares resource budgets and rejects trailing data" {
  let s = write_document_short(weak_document())
  for
    limits in [
      { input_units: 10, tokens: 1000, tiers: 10, entries: 10, },
      { input_units: 10000, tokens: 5, tiers: 10, entries: 10, },
      { input_units: 10000, tokens: 1000, tiers: 1, entries: 10, },
      { input_units: 10000, tokens: 1000, tiers: 10, entries: 2, },
    ] {
    assert_true(
      try {
        let _ = parse_document(s, limits~)
        false
      } catch {
        _ => true
      },
    )
  }
  assert_true(
    try {
      let _ = parse_document(s + " 123")
      false
    } catch {
      _ => true
    },
  )
}

///|
test "aligned bridge has no changes and supports editing crop and export" {
  let g = grid(0, 2, [
    interval_tier("", 0, 2, [{ start: 0, end: 2, label: "a", }]),
  ])
  let d = document_from_grid(g)
  assert_eq(document_to_grid(d).grid, g)
  assert_eq(document_to_grid(d, policy=ExpandAndPad).changes, [])
  let changed = replace_tier(
    g,
    0,
    split_interval(g.tiers[0], 1, "left", "right"),
  )
  let clipped = crop(changed, 0.5, 1.5, rebase_to_zero=true)
  assert_eq(
    parse_document(write_document_long(document_from_grid(clipped))),
    document_from_grid(clipped),
  )
}

///|
test "weak outer-domain cross product normalizes with no label loss" {
  for a in [-3.0, 0, 1, 2] {
    for b in [3.0, 4, 7] {
      for left in [-2.0, 1] {
        for right in [3.0, 6] {
          let d = document(a, b, [
            Intervals("same", left, right, [
              { start: 0, end: 1, label: "", },
              { start: 1, end: 2, label: "b\"\n中", },
            ]),
            Points("same", left, right, [
              { time: -1, label: "p", },
              { time: 5, label: "q", },
            ]),
          ])
          let r = document_to_grid(d, policy=ExpandAndPad)
          validate(r.grid)
          assert_eq(parse_document(write_document_long(d)), d)
          match r.grid.tiers[0] {
            Intervals(_, _, _, xs) => {
              assert_eq(xs[1].label, "")
              assert_eq(xs[1].start, 0)
              assert_eq(xs[2].label, "b\"\n中")
              assert_eq(xs[2].end, 2)
            }
            _ => abort("wrong tier")
          }
        }
      }
    }
  }
}
