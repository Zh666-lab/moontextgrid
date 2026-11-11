///|
fn csv_row(fields : Array[String]) -> String {
  let b = StringBuilder()
  for i, s in fields {
    if i > 0 {
      b.write_string(",")
    }
    b.write_string(quote_text(s))
  }
  b.write_string("\r\n")
  b.to_string()
}

///|
/// Lossless record CSV: grid, tier metadata, then entries. Empty tiers survive.
/// Every field is quoted; doubled quotes and literal multiline labels are legal.
pub fn write_csv(g : Grid) -> String raise GridError {
  validate(g)
  let b = StringBuilder()
  b.write_string("record,tier,name,start,end,label\r\n")
  b.write_string(csv_row(["grid", "", "", "\{g.start}", "\{g.end}", ""]))
  for i, t in g.tiers {
    let (a, z) = tier_bounds(t)
    match t {
      Intervals(n, _, _, xs) => {
        b.write_string(
          csv_row(["interval-tier", "\{i}", n, "\{a}", "\{z}", ""]),
        )
        for x in xs {
          b.write_string(
            csv_row(["interval", "\{i}", "", "\{x.start}", "\{x.end}", x.label]),
          )
        }
      }
      Points(n, _, _, xs) => {
        b.write_string(csv_row(["point-tier", "\{i}", n, "\{a}", "\{z}", ""]))
        for x in xs {
          b.write_string(
            csv_row(["point", "\{i}", "", "\{x.time}", "\{x.time}", x.label]),
          )
        }
      }
    }
  }
  b.to_string()
}

///|
/// Strict six-column CSV tokenizer, permitting CRLF, LF, or CR record endings.
fn csv_records(
  text : String,
  limits : Limits,
) -> Array[Array[String]] raise GridError {
  guard limits.input_units > 0 &&
    text.length() <= limits.input_units &&
    limits.tiers >= 0 &&
    limits.entries >= 0 else {
    raise Invalid("invalid CSV limits or input size")
  }
  let rows : Array[Array[String]] = []
  let mut row : Array[String] = []
  let mut field = StringBuilder()
  let mut quoted = false
  let mut closed = false
  let mut started = false
  let mut skip_lf = false
  for c in text.iter() {
    if skip_lf && c == '\n' {
      skip_lf = false
      continue
    }
    skip_lf = false
    if quoted {
      if c == '"' {
        quoted = false
        closed = true
      } else {
        field.write_char(c)
      }
    } else if closed && c == '"' {
      field.write_string("\"")
      quoted = true
      closed = false
    } else if c == ',' || c == '\r' || c == '\n' {
      row.push(field.to_string())
      guard row.length() <= 6 else { raise Invalid("CSV has too many columns") }
      field = StringBuilder()
      started = false
      closed = false
      if c != ',' {
        guard row.length() == 6 else {
          raise Invalid("CSV requires six columns")
        }
        rows.push(row)
        row = []
        // Subtract instead of adding user supplied limits, avoiding integer overflow.
        guard rows.length() <= 2 ||
          rows.length() - 2 <= limits.tiers ||
          rows.length() - 2 - limits.tiers <= limits.entries else {
          raise Invalid("CSV record budget exceeded")
        }
        skip_lf = c == '\r'
      }
    } else if c == '"' && !started && !closed {
      started = true
      quoted = true
    } else {
      guard !closed && c != '"' else { raise Invalid("invalid CSV quoting") }
      started = true
      field.write_char(c)
    }
  }
  guard !quoted else { raise Invalid("unterminated CSV quote") }
  if started || closed || !row.is_empty() {
    row.push(field.to_string())
    guard row.length() == 6 else { raise Invalid("CSV requires six columns") }
    rows.push(row)
  }
  rows
}

///|
fn csv_number(s : String) -> Double raise GridError {
  let x = @string.parse_double(s[:]) catch {
    _ => raise Invalid("invalid CSV time")
  }
  guard finite(x) else { raise Invalid("nonfinite CSV time") }
  x
}

///|
pub fn parse_csv(
  text : String,
  limits~ : Limits = default_limits(),
) -> Grid raise GridError {
  let rows = csv_records(text, limits)
  guard rows.length() >= 2 &&
    rows[0] == ["record", "tier", "name", "start", "end", "label"] else {
    raise Invalid("unsupported CSV header")
  }
  let root = rows[1]
  guard root[0] == "grid" && root[1] == "" && root[2] == "" && root[5] == "" else {
    raise Invalid("invalid CSV grid row")
  }
  let a = csv_number(root[3])
  let b = csv_number(root[4])
  let tiers : Array[Tier] = []
  let mut i = 2
  let mut remaining = limits.entries
  while i < rows.length() {
    guard tiers.length() < limits.tiers else {
      raise Invalid("CSV tier budget exceeded")
    }
    let meta = rows[i]
    let index = "\{tiers.length()}"
    guard (meta[0] == "interval-tier" || meta[0] == "point-tier") &&
      meta[1] == index &&
      meta[5] == "" else {
      raise Invalid("invalid CSV tier metadata")
    }
    let start = csv_number(meta[3])
    let end = csv_number(meta[4])
    let intervals : Array[Interval] = []
    let points : Array[Point] = []
    i += 1
    while i < rows.length() &&
          rows[i][0] != "interval-tier" &&
          rows[i][0] != "point-tier" {
      let r = rows[i]
      guard remaining > 0 && r[1] == index && r[2] == "" else {
        raise Invalid("invalid CSV entry index or budget")
      }
      remaining -= 1
      let lo = csv_number(r[3])
      let hi = csv_number(r[4])
      if meta[0] == "interval-tier" {
        guard r[0] == "interval" else { raise Invalid("wrong CSV entry kind") }
        intervals.push({ start: lo, end: hi, label: r[5], })
      } else {
        guard r[0] == "point" && lo == hi else {
          raise Invalid("wrong CSV point entry")
        }
        points.push({ time: lo, label: r[5], })
      }
      i += 1
    }
    tiers.push(
      if meta[0] == "interval-tier" {
        interval_tier(meta[2], start, end, intervals)
      } else {
        point_tier(meta[2], start, end, points)
      },
    )
  }
  grid(a, b, tiers)
}
