// Generated ORIGINAL synthetic vectors by tools/differential.py using tgt 1.5.

///|
test "tgt independent long fixture 1" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 0.25\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 0.25\n\t\tintervals: size = 1\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 0.25\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 0.25\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":0.25,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":0.25,\"entries\":[[0.0,0.25,\"词语\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":0.25,\"entries\":[[0.0,\"start\"],[0.25,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 1" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n0.25\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n0.25\n1\n0.0\n0.25\n\"词语\"\n\"TextTier\"\n\"events\"\n0.0\n0.25\n2\n0.0\n\"start\"\n0.25\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":0.25,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":0.25,\"entries\":[[0.0,0.25,\"词语\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":0.25,\"entries\":[[0.0,\"start\"],[0.25,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 2" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 0.5\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 0.5\n\t\tintervals: size = 2\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 0.5\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 0.5\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":0.5,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":0.5,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":0.5,\"entries\":[[0.0,\"start\"],[0.5,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 2" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n0.5\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n0.5\n2\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n\"TextTier\"\n\"events\"\n0.0\n0.5\n2\n0.0\n\"start\"\n0.5\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":0.5,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":0.5,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":0.5,\"entries\":[[0.0,\"start\"],[0.5,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 3" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 0.75\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 0.75\n\t\tintervals: size = 3\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 0.75\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 0.75\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":0.75,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":0.75,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":0.75,\"entries\":[[0.0,\"start\"],[0.75,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 3" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n0.75\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n0.75\n3\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n\"TextTier\"\n\"events\"\n0.0\n0.75\n2\n0.0\n\"start\"\n0.75\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":0.75,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":0.75,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":0.75,\"entries\":[[0.0,\"start\"],[0.75,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 4" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 1.0\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 1.0\n\t\tintervals: size = 4\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 1.0\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 1.0\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":1.0,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":1.0,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":1.0,\"entries\":[[0.0,\"start\"],[1.0,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 4" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n1.0\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n1.0\n4\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n\"TextTier\"\n\"events\"\n0.0\n1.0\n2\n0.0\n\"start\"\n1.0\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":1.0,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":1.0,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":1.0,\"entries\":[[0.0,\"start\"],[1.0,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 5" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 1.25\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 1.25\n\t\tintervals: size = 5\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\t\tintervals [5]:\n\t\t\txmin = 1.0\n\t\t\txmax = 1.25\n\t\t\ttext = \"词语\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 1.25\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 1.25\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":1.25,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":1.25,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":1.25,\"entries\":[[0.0,\"start\"],[1.25,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 5" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n1.25\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n1.25\n5\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n1.0\n1.25\n\"词语\"\n\"TextTier\"\n\"events\"\n0.0\n1.25\n2\n0.0\n\"start\"\n1.25\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":1.25,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":1.25,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":1.25,\"entries\":[[0.0,\"start\"],[1.25,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 6" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 1.5\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 1.5\n\t\tintervals: size = 6\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\t\tintervals [5]:\n\t\t\txmin = 1.0\n\t\t\txmax = 1.25\n\t\t\ttext = \"词语\"\n\t\tintervals [6]:\n\t\t\txmin = 1.25\n\t\t\txmax = 1.5\n\t\t\ttext = \"\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 1.5\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 1.5\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":1.5,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":1.5,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":1.5,\"entries\":[[0.0,\"start\"],[1.5,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 6" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n1.5\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n1.5\n6\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n1.0\n1.25\n\"词语\"\n1.25\n1.5\n\"\"\n\"TextTier\"\n\"events\"\n0.0\n1.5\n2\n0.0\n\"start\"\n1.5\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":1.5,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":1.5,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":1.5,\"entries\":[[0.0,\"start\"],[1.5,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 7" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 1.75\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 1.75\n\t\tintervals: size = 7\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\t\tintervals [5]:\n\t\t\txmin = 1.0\n\t\t\txmax = 1.25\n\t\t\ttext = \"词语\"\n\t\tintervals [6]:\n\t\t\txmin = 1.25\n\t\t\txmax = 1.5\n\t\t\ttext = \"\"\n\t\tintervals [7]:\n\t\t\txmin = 1.5\n\t\t\txmax = 1.75\n\t\t\ttext = \"quote\"\"ok\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 1.75\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 1.75\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":1.75,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":1.75,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":1.75,\"entries\":[[0.0,\"start\"],[1.75,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 7" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n1.75\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n1.75\n7\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n1.0\n1.25\n\"词语\"\n1.25\n1.5\n\"\"\n1.5\n1.75\n\"quote\"\"ok\"\n\"TextTier\"\n\"events\"\n0.0\n1.75\n2\n0.0\n\"start\"\n1.75\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":1.75,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":1.75,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":1.75,\"entries\":[[0.0,\"start\"],[1.75,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 8" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 2.0\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 2.0\n\t\tintervals: size = 8\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\t\tintervals [5]:\n\t\t\txmin = 1.0\n\t\t\txmax = 1.25\n\t\t\ttext = \"词语\"\n\t\tintervals [6]:\n\t\t\txmin = 1.25\n\t\t\txmax = 1.5\n\t\t\ttext = \"\"\n\t\tintervals [7]:\n\t\t\txmin = 1.5\n\t\t\txmax = 1.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [8]:\n\t\t\txmin = 1.75\n\t\t\txmax = 2.0\n\t\t\ttext = \"café\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 2.0\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 2.0\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":2.0,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":2.0,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":2.0,\"entries\":[[0.0,\"start\"],[2.0,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 8" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n2.0\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n2.0\n8\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n1.0\n1.25\n\"词语\"\n1.25\n1.5\n\"\"\n1.5\n1.75\n\"quote\"\"ok\"\n1.75\n2.0\n\"café\"\n\"TextTier\"\n\"events\"\n0.0\n2.0\n2\n0.0\n\"start\"\n2.0\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":2.0,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":2.0,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":2.0,\"entries\":[[0.0,\"start\"],[2.0,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 9" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 2.25\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 2.25\n\t\tintervals: size = 9\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\t\tintervals [5]:\n\t\t\txmin = 1.0\n\t\t\txmax = 1.25\n\t\t\ttext = \"词语\"\n\t\tintervals [6]:\n\t\t\txmin = 1.25\n\t\t\txmax = 1.5\n\t\t\ttext = \"\"\n\t\tintervals [7]:\n\t\t\txmin = 1.5\n\t\t\txmax = 1.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [8]:\n\t\t\txmin = 1.75\n\t\t\txmax = 2.0\n\t\t\ttext = \"café\"\n\t\tintervals [9]:\n\t\t\txmin = 2.0\n\t\t\txmax = 2.25\n\t\t\ttext = \"词语\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 2.25\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 2.25\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":2.25,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":2.25,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"],[2.0,2.25,\"词语\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":2.25,\"entries\":[[0.0,\"start\"],[2.25,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 9" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n2.25\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n2.25\n9\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n1.0\n1.25\n\"词语\"\n1.25\n1.5\n\"\"\n1.5\n1.75\n\"quote\"\"ok\"\n1.75\n2.0\n\"café\"\n2.0\n2.25\n\"词语\"\n\"TextTier\"\n\"events\"\n0.0\n2.25\n2\n0.0\n\"start\"\n2.25\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":2.25,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":2.25,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"],[2.0,2.25,\"词语\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":2.25,\"entries\":[[0.0,\"start\"],[2.25,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 10" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 2.5\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 2.5\n\t\tintervals: size = 10\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\t\tintervals [5]:\n\t\t\txmin = 1.0\n\t\t\txmax = 1.25\n\t\t\ttext = \"词语\"\n\t\tintervals [6]:\n\t\t\txmin = 1.25\n\t\t\txmax = 1.5\n\t\t\ttext = \"\"\n\t\tintervals [7]:\n\t\t\txmin = 1.5\n\t\t\txmax = 1.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [8]:\n\t\t\txmin = 1.75\n\t\t\txmax = 2.0\n\t\t\ttext = \"café\"\n\t\tintervals [9]:\n\t\t\txmin = 2.0\n\t\t\txmax = 2.25\n\t\t\ttext = \"词语\"\n\t\tintervals [10]:\n\t\t\txmin = 2.25\n\t\t\txmax = 2.5\n\t\t\ttext = \"\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 2.5\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 2.5\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":2.5,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":2.5,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"],[2.0,2.25,\"词语\"],[2.25,2.5,\"\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":2.5,\"entries\":[[0.0,\"start\"],[2.5,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 10" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n2.5\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n2.5\n10\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n1.0\n1.25\n\"词语\"\n1.25\n1.5\n\"\"\n1.5\n1.75\n\"quote\"\"ok\"\n1.75\n2.0\n\"café\"\n2.0\n2.25\n\"词语\"\n2.25\n2.5\n\"\"\n\"TextTier\"\n\"events\"\n0.0\n2.5\n2\n0.0\n\"start\"\n2.5\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":2.5,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":2.5,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"],[2.0,2.25,\"词语\"],[2.25,2.5,\"\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":2.5,\"entries\":[[0.0,\"start\"],[2.5,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 11" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 2.75\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 2.75\n\t\tintervals: size = 11\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\t\tintervals [5]:\n\t\t\txmin = 1.0\n\t\t\txmax = 1.25\n\t\t\ttext = \"词语\"\n\t\tintervals [6]:\n\t\t\txmin = 1.25\n\t\t\txmax = 1.5\n\t\t\ttext = \"\"\n\t\tintervals [7]:\n\t\t\txmin = 1.5\n\t\t\txmax = 1.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [8]:\n\t\t\txmin = 1.75\n\t\t\txmax = 2.0\n\t\t\ttext = \"café\"\n\t\tintervals [9]:\n\t\t\txmin = 2.0\n\t\t\txmax = 2.25\n\t\t\ttext = \"词语\"\n\t\tintervals [10]:\n\t\t\txmin = 2.25\n\t\t\txmax = 2.5\n\t\t\ttext = \"\"\n\t\tintervals [11]:\n\t\t\txmin = 2.5\n\t\t\txmax = 2.75\n\t\t\ttext = \"quote\"\"ok\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 2.75\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 2.75\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":2.75,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":2.75,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"],[2.0,2.25,\"词语\"],[2.25,2.5,\"\"],[2.5,2.75,\"quote\\\"ok\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":2.75,\"entries\":[[0.0,\"start\"],[2.75,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 11" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n2.75\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n2.75\n11\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n1.0\n1.25\n\"词语\"\n1.25\n1.5\n\"\"\n1.5\n1.75\n\"quote\"\"ok\"\n1.75\n2.0\n\"café\"\n2.0\n2.25\n\"词语\"\n2.25\n2.5\n\"\"\n2.5\n2.75\n\"quote\"\"ok\"\n\"TextTier\"\n\"events\"\n0.0\n2.75\n2\n0.0\n\"start\"\n2.75\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":2.75,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":2.75,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"],[2.0,2.25,\"词语\"],[2.25,2.5,\"\"],[2.5,2.75,\"quote\\\"ok\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":2.75,\"entries\":[[0.0,\"start\"],[2.75,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent long fixture 12" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0.0\nxmax = 3.0\ntiers? <exists>\nsize = 2\nitem []:\n\titem [1]:\n\t\tclass = \"IntervalTier\"\n\t\tname = \"words\"\n\t\txmin = 0.0\n\t\txmax = 3.0\n\t\tintervals: size = 12\n\t\tintervals [1]:\n\t\t\txmin = 0.0\n\t\t\txmax = 0.25\n\t\t\ttext = \"词语\"\n\t\tintervals [2]:\n\t\t\txmin = 0.25\n\t\t\txmax = 0.5\n\t\t\ttext = \"\"\n\t\tintervals [3]:\n\t\t\txmin = 0.5\n\t\t\txmax = 0.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [4]:\n\t\t\txmin = 0.75\n\t\t\txmax = 1.0\n\t\t\ttext = \"café\"\n\t\tintervals [5]:\n\t\t\txmin = 1.0\n\t\t\txmax = 1.25\n\t\t\ttext = \"词语\"\n\t\tintervals [6]:\n\t\t\txmin = 1.25\n\t\t\txmax = 1.5\n\t\t\ttext = \"\"\n\t\tintervals [7]:\n\t\t\txmin = 1.5\n\t\t\txmax = 1.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [8]:\n\t\t\txmin = 1.75\n\t\t\txmax = 2.0\n\t\t\ttext = \"café\"\n\t\tintervals [9]:\n\t\t\txmin = 2.0\n\t\t\txmax = 2.25\n\t\t\ttext = \"词语\"\n\t\tintervals [10]:\n\t\t\txmin = 2.25\n\t\t\txmax = 2.5\n\t\t\ttext = \"\"\n\t\tintervals [11]:\n\t\t\txmin = 2.5\n\t\t\txmax = 2.75\n\t\t\ttext = \"quote\"\"ok\"\n\t\tintervals [12]:\n\t\t\txmin = 2.75\n\t\t\txmax = 3.0\n\t\t\ttext = \"café\"\n\titem [2]:\n\t\tclass = \"TextTier\"\n\t\tname = \"events\"\n\t\txmin = 0.0\n\t\txmax = 3.0\n\t\tpoints: size = 2\n\t\tpoints [1]:\n\t\t\tnumber = 0.0\n\t\t\tmark = \"start\"\n\t\tpoints [2]:\n\t\t\tnumber = 3.0\n\t\t\tmark = \"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":3.0,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":3.0,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"],[2.0,2.25,\"词语\"],[2.25,2.5,\"\"],[2.5,2.75,\"quote\\\"ok\"],[2.75,3.0,\"café\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":3.0,\"entries\":[[0.0,\"start\"],[3.0,\"end\"]]}]}",
      ),
    ),
  )
}

///|
test "tgt independent short fixture 12" {
  assert_eq(
    write_json(
      parse_text(
        "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0.0\n3.0\n<exists>\n2\n\"IntervalTier\"\n\"words\"\n0.0\n3.0\n12\n0.0\n0.25\n\"词语\"\n0.25\n0.5\n\"\"\n0.5\n0.75\n\"quote\"\"ok\"\n0.75\n1.0\n\"café\"\n1.0\n1.25\n\"词语\"\n1.25\n1.5\n\"\"\n1.5\n1.75\n\"quote\"\"ok\"\n1.75\n2.0\n\"café\"\n2.0\n2.25\n\"词语\"\n2.25\n2.5\n\"\"\n2.5\n2.75\n\"quote\"\"ok\"\n2.75\n3.0\n\"café\"\n\"TextTier\"\n\"events\"\n0.0\n3.0\n2\n0.0\n\"start\"\n3.0\n\"end\"",
      ),
    ),
    write_json(
      parse_json(
        "{\"schema\":\"moontextgrid/1\",\"start\":0.0,\"end\":3.0,\"tiers\":[{\"kind\":\"interval\",\"name\":\"words\",\"start\":0.0,\"end\":3.0,\"entries\":[[0.0,0.25,\"词语\"],[0.25,0.5,\"\"],[0.5,0.75,\"quote\\\"ok\"],[0.75,1.0,\"café\"],[1.0,1.25,\"词语\"],[1.25,1.5,\"\"],[1.5,1.75,\"quote\\\"ok\"],[1.75,2.0,\"café\"],[2.0,2.25,\"词语\"],[2.25,2.5,\"\"],[2.5,2.75,\"quote\\\"ok\"],[2.75,3.0,\"café\"]]},{\"kind\":\"point\",\"name\":\"events\",\"start\":0.0,\"end\":3.0,\"entries\":[[0.0,\"start\"],[3.0,\"end\"]]}]}",
      ),
    ),
  )
}
