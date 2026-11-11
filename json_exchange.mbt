///|
/// Versioned JSON schema, independent of internal enum representation.
pub fn to_json(g : Grid) -> Json raise GridError {
  validate(g)
  let tiers = g.tiers.map(fn(t) {
    match t {
      Intervals(n, a, b, xs) =>
        Json::object({
          "kind": Json::string("interval"),
          "name": Json::string(n),
          "start": Json::number(a),
          "end": Json::number(b),
          "entries": Json::array(
            xs.map(fn(x) {
              Json::array([
                Json::number(x.start),
                Json::number(x.end),
                Json::string(x.label),
              ])
            }),
          ),
        })
      Points(n, a, b, xs) =>
        Json::object({
          "kind": Json::string("point"),
          "name": Json::string(n),
          "start": Json::number(a),
          "end": Json::number(b),
          "entries": Json::array(
            xs.map(fn(x) {
              Json::array([Json::number(x.time), Json::string(x.label)])
            }),
          ),
        })
    }
  })
  Json::object({
    "schema": Json::string("moontextgrid/1"),
    "start": Json::number(g.start),
    "end": Json::number(g.end),
    "tiers": Json::array(tiers),
  })
}

///|
fn json_field(j : Json, key : String) -> Json raise GridError {
  match j {
    Object(m) =>
      match m.get(key) {
        Some(x) => x
        None => raise Invalid("missing JSON field")
      }
    _ => raise Invalid("expected JSON object")
  }
}

///|
fn json_string(j : Json) -> String raise GridError {
  match j {
    String(s) => s
    _ => raise Invalid("expected JSON string")
  }
}

///|
fn json_number(j : Json) -> Double raise GridError {
  match j {
    Number(n, ..) => {
      guard finite(n) else { raise Invalid("nonfinite JSON time") }
      n
    }
    _ => raise Invalid("expected JSON number")
  }
}

///|
fn json_array(j : Json) -> Array[Json] raise GridError {
  match j {
    Array(xs) => xs
    _ => raise Invalid("expected JSON array")
  }
}

///|
/// Import bounded schema-v1 data. Unknown fields are allowed for additive metadata.
pub fn from_json(
  j : Json,
  limits~ : Limits = default_limits(),
) -> Grid raise GridError {
  guard limits.tiers >= 0 && limits.entries >= 0 else {
    raise Invalid("invalid JSON limits")
  }
  guard json_string(json_field(j, "schema")) == "moontextgrid/1" else {
    raise Invalid("unsupported JSON schema")
  }
  let a = json_number(json_field(j, "start"))
  let b = json_number(json_field(j, "end"))
  let ts = json_array(json_field(j, "tiers"))
  guard ts.length() <= limits.tiers else {
    raise Invalid("tier budget exceeded")
  }
  let tiers : Array[Tier] = []
  let mut remaining = limits.entries
  for t in ts {
    let kind = json_string(json_field(t, "kind"))
    let name = json_string(json_field(t, "name"))
    let start = json_number(json_field(t, "start"))
    let end = json_number(json_field(t, "end"))
    let entries = json_array(json_field(t, "entries"))
    guard entries.length() <= remaining else {
      raise Invalid("entry budget exceeded")
    }
    remaining -= entries.length()
    if kind == "interval" {
      let xs : Array[Interval] = []
      for entry in entries {
        let e = json_array(entry)
        guard e.length() == 3 else {
          raise Invalid("interval JSON entry arity")
        }
        xs.push({
          start: json_number(e[0]),
          end: json_number(e[1]),
          label: json_string(e[2]),
        })
      }
      tiers.push(interval_tier(name, start, end, xs))
    } else if kind == "point" {
      let xs : Array[Point] = []
      for entry in entries {
        let e = json_array(entry)
        guard e.length() == 2 else { raise Invalid("point JSON entry arity") }
        xs.push({ time: json_number(e[0]), label: json_string(e[1]), })
      }
      tiers.push(point_tier(name, start, end, xs))
    } else {
      raise Invalid("unsupported JSON tier kind")
    }
  }
  grid(a, b, tiers)
}

///|
pub fn parse_json(
  text : String,
  limits~ : Limits = default_limits(),
) -> Grid raise GridError {
  guard limits.input_units > 0 && text.length() <= limits.input_units else {
    raise Invalid("JSON text budget exceeded")
  }
  let j = @json.parse(text[:], max_nesting_depth=16, reject_duplicate_keys=true) catch {
    _ => raise Invalid("invalid JSON syntax")
  }
  from_json(j, limits~)
}

///|
pub fn write_json(g : Grid) -> String raise GridError {
  to_json(g).stringify(indent=2)
}
