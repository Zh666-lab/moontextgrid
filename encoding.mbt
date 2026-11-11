///|
/// Supported explicit output encodings. UTF-16 is always written with a BOM.
pub(all) enum TextEncoding {
  Utf8
  Utf16LE
  Utf16BE
} derive(Debug, Eq)

///|
pub extend TextEncoding with Eq::{equal, not_equal}

///|
pub extend TextEncoding with @debug.Debug::{to_repr}

///|
/// Reject byte streams before decoding if they exceed the UTF-16-unit budget.
/// No Latin-1 fallback: malformed Unicode must never silently change labels.
pub fn decode_text(
  data : Bytes,
  max_units~ : Int32 = 8000000,
) -> String raise GridError {
  guard max_units > 0 && max_units <= 500000000 else {
    raise Invalid("invalid decode budget")
  }
  guard data.length() <= max_units * 4 + 4 else {
    raise Invalid("byte budget exceeded")
  }
  let s = try {
    if data.length() >= 2 && data[0] == 0xFF && data[1] == 0xFE {
      @utf16.decode(data[:], ignore_bom=true, endianness=Little)
    } else if data.length() >= 2 && data[0] == 0xFE && data[1] == 0xFF {
      @utf16.decode(data[:], ignore_bom=true, endianness=Big)
    } else {
      @utf8.decode(data[:], ignore_bom=true)
    }
  } catch {
    _ => raise Invalid("malformed UTF-8 or UTF-16")
  }
  guard s.length() <= max_units else {
    raise Invalid("decoded text budget exceeded")
  }
  s
}

///|
pub fn encode_text(s : String, encoding~ : TextEncoding = Utf8) -> Bytes {
  match encoding {
    Utf8 => @utf8.encode(s[:])
    Utf16LE => @utf16.encode(s[:], bom=true, endianness=Little)
    Utf16BE => @utf16.encode(s[:], bom=true, endianness=Big)
  }
}

///|
pub fn parse_bytes(
  data : Bytes,
  limits~ : Limits = default_limits(),
) -> Grid raise GridError {
  parse_text(decode_text(data, max_units=limits.input_units), limits~)
}

///|
pub fn write_bytes(
  g : Grid,
  encoding~ : TextEncoding = Utf8,
  short~ : Bool = false,
) -> Bytes raise GridError {
  encode_text(if short { write_short(g) } else { write_long(g) }, encoding~)
}
