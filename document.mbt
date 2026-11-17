///|
/// Official text document model. Declared domains need not coincide with
/// entries or the grid. Interval adjacency and point ordering remain required.
pub(all) struct Document {
  start : Double
  end : Double
  tiers : Array[Tier]
} derive(Debug, Eq)

///|
fn document_domain(a : Double, b : Double) -> Unit raise GridError {
  guard finite(a) && finite(b) && a <= b else {
    raise Invalid("expected finite ordered document domain")
  }
}

///|
pub fn validate_document(d : Document) -> Unit raise GridError {
  document_domain(d.start, d.end)
  for t in d.tiers {
    match t {
      Intervals(_, a, b, xs) => {
        document_domain(a, b)
        let mut prev = a
        for i, x in xs {
          guard finite(x.start) && finite(x.end) && x.start < x.end else {
            raise Invalid("document interval must have positive finite bounds")
          }
          guard i == 0 || x.start == prev else {
            raise Invalid("document intervals must be adjacent")
          }
          prev = x.end
        }
      }
      Points(_, a, b, xs) => {
        document_domain(a, b)
        let mut prev = a
        for i, x in xs {
          guard finite(x.time) && (i == 0 || x.time > prev) else {
            raise Invalid(
              "document points must be finite and strictly increasing",
            )
          }
          prev = x.time
        }
      }
    }
  }
}

///|
pub fn document(
  a : Double,
  b : Double,
  tiers : Array[Tier],
) -> Document raise GridError {
  let d : Document = { start: a, end: b, tiers: tiers.map(copy_tier), }
  validate_document(d)
  d
}

///|
pub fn document_from_grid(g : Grid) -> Document raise GridError {
  validate(g)
  document(g.start, g.end, g.tiers)
}

///|
/// Only layout, comments and numeric spellings are canonicalized. Declared
/// bounds, tier order, labels and entry times are retained without normalization.
pub fn write_document_short(d : Document) -> String raise GridError {
  validate_document(d)
  render_short({ start: d.start, end: d.end, tiers: d.tiers, })
}

///|
pub fn write_document_long(d : Document) -> String raise GridError {
  validate_document(d)
  render_long({ start: d.start, end: d.end, tiers: d.tiers, })
}

///|
pub fn parse_document_bytes(
  data : Bytes,
  limits~ : Limits = default_limits(),
) -> Document raise GridError {
  parse_document(decode_text(data, max_units=limits.input_units), limits~)
}

///|
pub fn write_document_bytes(
  d : Document,
  encoding~ : TextEncoding = Utf8,
  short~ : Bool = false,
) -> Bytes raise GridError {
  encode_text(
    if short {
      write_document_short(d)
    } else {
      write_document_long(d)
    },
    encoding~,
  )
}

///|
pub extend Document with Eq::{equal, not_equal}

///|
pub extend Document with @debug.Debug::{to_repr}
