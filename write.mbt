///|
/// Double quotes are doubled; literal newlines and non-ASCII labels are preserved.
fn quote_text(s : String) -> String {
  let b = StringBuilder()
  b.write_string("\"")
  for c in s.iter() {
    if c == '"' {
      b.write_string("\"\"")
    } else {
      b.write_char(c)
    }
  }
  b.write_string("\"")
  b.to_string()
}

///|
/// Canonical short TextGrid output; validation precedes serialization.
pub fn write_short(g : Grid) -> String raise GridError {
  validate(g)
  let b = StringBuilder()
  b.write_string("File type = \"ooTextFile short\"\n\"TextGrid\"\n")
  b.write_string("\{g.start}\n\{g.end}\n<exists>\n\{g.tiers.length()}\n")
  for t in g.tiers {
    match t {
      Intervals(n, a, z, xs) => {
        b.write_string(
          "\"IntervalTier\"\n\{quote_text(n)}\n\{a}\n\{z}\n\{xs.length()}\n",
        )
        for x in xs {
          b.write_string("\{x.start}\n\{x.end}\n\{quote_text(x.label)}\n")
        }
      }
      Points(n, a, z, xs) => {
        b.write_string(
          "\"TextTier\"\n\{quote_text(n)}\n\{a}\n\{z}\n\{xs.length()}\n",
        )
        for x in xs {
          b.write_string("\{x.time}\n\{quote_text(x.label)}\n")
        }
      }
    }
  }
  b.to_string()
}

///|
/// Human-readable long TextGrid. Indices are presentation, not semantic tokens.
pub fn write_long(g : Grid) -> String raise GridError {
  validate(g)
  let b = StringBuilder()
  b.write_string("File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n")
  b.write_string(
    "xmin = \{g.start}\nxmax = \{g.end}\ntiers? <exists>\nsize = \{g.tiers.length()}\nitem []:\n",
  )
  for i, t in g.tiers {
    b.write_string("    item [\{i + 1}]:\n")
    match t {
      Intervals(n, a, z, xs) => {
        b.write_string(
          "        class = \"IntervalTier\"\n        name = \{quote_text(n)}\n        xmin = \{a}\n        xmax = \{z}\n        intervals: size = \{xs.length()}\n",
        )
        for j, x in xs {
          b.write_string(
            "        intervals [\{j + 1}]:\n            xmin = \{x.start}\n            xmax = \{x.end}\n            text = \{quote_text(x.label)}\n",
          )
        }
      }
      Points(n, a, z, xs) => {
        b.write_string(
          "        class = \"TextTier\"\n        name = \{quote_text(n)}\n        xmin = \{a}\n        xmax = \{z}\n        points: size = \{xs.length()}\n",
        )
        for j, x in xs {
          b.write_string(
            "        points [\{j + 1}]:\n            number = \{x.time}\n            mark = \{quote_text(x.label)}\n",
          )
        }
      }
    }
  }
  b.to_string()
}
