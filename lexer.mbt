///|
/// Token locations use UTF-16 code-unit offsets, as MoonBit String indexing does.
priv struct Token {
  text : String
  quoted : Bool
}

///|
fn whitespace(c : UInt16) -> Bool {
  c == 32 || c == 9 || c == 10 || c == 13 || c == 0xFEFF
}

///|
fn numeric_char(c : UInt16) -> Bool {
  (c >= 48 && c <= 57) || c == 43 || c == 45 || c == 46 || c == 69 || c == 101
}

///|
fn tokenize(text : String, limits : Limits) -> Array[Token] raise GridError {
  guard limits.input_units > 0 &&
    limits.tokens > 0 &&
    limits.tiers >= 0 &&
    limits.entries >= 0 else {
    raise Invalid("invalid resource limits")
  }
  guard text.length() <= limits.input_units else {
    raise Invalid("input budget exceeded")
  }
  let out : Array[Token] = []
  let mut i = 0
  while i < text.length() {
    let c = text[i]
    if c == 33 {
      while i < text.length() && text[i] != 10 && text[i] != 13 {
        i += 1
      }
    } else if c == 34 && (i == 0 || whitespace(text[i - 1])) {
      i += 1
      let b = StringBuilder()
      let mut segment = i
      let mut closed = false
      while i < text.length() {
        if text[i] == 34 {
          b.write_string(text[segment:i].to_owned())
          if i + 1 < text.length() && text[i + 1] == 34 {
            b.write_string("\"")
            i += 2
            segment = i
          } else {
            i += 1
            closed = true
            break
          }
        } else {
          i += 1
        }
      }
      guard closed else { raise Invalid("unterminated quoted string") }
      guard i == text.length() || whitespace(text[i]) else {
        raise Invalid("quoted string must stand free")
      }
      out.push({ text: b.to_string(), quoted: true, })
    } else if (i == 0 || whitespace(text[i - 1])) &&
      (numeric_char(c) || c == 60) {
      let start = i
      while i < text.length() && !whitespace(text[i]) {
        i += 1
      }
      let word = text[start:i].to_owned()
      if word == "<exists>" ||
        word == "<absent>" ||
        word.iter().all(fn(ch) { numeric_char(ch.to_int().to_uint16()) }) {
        out.push({ text: word, quoted: false, })
      }
    } else {
      i += 1
    }
    guard out.length() <= limits.tokens else {
      raise Invalid("token budget exceeded")
    }
  }
  out
}

///|
priv struct Reader {
  tokens : Array[Token]
  mut pos : Int32
}

///|
fn Reader::take(self : Reader) -> Token raise GridError {
  guard self.pos < self.tokens.length() else {
    raise Invalid("unexpected end of TextGrid")
  }
  let t = self.tokens[self.pos]
  self.pos += 1
  t
}

///|
fn Reader::string(self : Reader) -> String raise GridError {
  let t = self.take()
  guard t.quoted else { raise Invalid("expected quoted string") }
  t.text
}

///|
fn Reader::number(self : Reader) -> Double raise GridError {
  let t = self.take()
  guard !t.quoted else { raise Invalid("expected unquoted time") }
  let x = @string.parse_double(t.text[:]) catch {
    _ => raise Invalid("invalid time number")
  }
  guard finite(x) else { raise Invalid("nonfinite time") }
  x
}

///|
fn Reader::count(self : Reader, maximum : Int32) -> Int32 raise GridError {
  let t = self.take()
  guard !t.quoted &&
    !t.text.is_empty() &&
    t.text.iter().all(fn(c) { c >= '0' && c <= '9' }) else {
    raise Invalid("expected nonnegative decimal count")
  }
  let mut n = 0
  for c in t.text.iter() {
    let digit = c.to_int() - 48
    guard n <= (maximum - digit) / 10 && digit <= maximum else {
      raise Invalid("count budget exceeded")
    }
    n = n * 10 + digit
  }
  guard n <= maximum else { raise Invalid("count budget exceeded") }
  n
}
