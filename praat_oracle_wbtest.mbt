// Original synthetic vectors written by Praat 6.1.38; regenerate with tools/praat_differential.py --generate.

///|
test "Praat independent weak 0 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = -2 \n        xmax = 4 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"中文\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -2.0, 4.0, [
        { start: 0.0, end: 1.0, label: "中文", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 0 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n-2\n4\n2\n0\n1\n\"中文\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -2.0, 4.0, [
        { start: 0.0, end: 1.0, label: "中文", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 1 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = -1 \n        xmax = 5 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"quote\"\"ok\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -1.0, 5.0, [
        { start: 0.0, end: 1.0, label: "quote\"ok", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 1 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n-1\n5\n2\n0\n1\n\"quote\"\"ok\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -1.0, 5.0, [
        { start: 0.0, end: 1.0, label: "quote\"ok", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 2 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = 0 \n        xmax = 6 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"two\nlines\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 0.0, 6.0, [
        { start: 0.0, end: 1.0, label: "two\nlines", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 2 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n0\n6\n2\n0\n1\n\"two\nlines\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 0.0, 6.0, [
        { start: 0.0, end: 1.0, label: "two\nlines", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 3 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = 1 \n        xmax = 4 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 1.0, 4.0, [
        { start: 0.0, end: 1.0, label: "", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 3 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n1\n4\n2\n0\n1\n\"\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 1.0, 4.0, [
        { start: 0.0, end: 1.0, label: "", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 4 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = -2 \n        xmax = 5 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"中文\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -2.0, 5.0, [
        { start: 0.0, end: 1.0, label: "中文", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 4 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n-2\n5\n2\n0\n1\n\"中文\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -2.0, 5.0, [
        { start: 0.0, end: 1.0, label: "中文", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 5 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = -1 \n        xmax = 6 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"quote\"\"ok\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -1.0, 6.0, [
        { start: 0.0, end: 1.0, label: "quote\"ok", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 5 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n-1\n6\n2\n0\n1\n\"quote\"\"ok\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -1.0, 6.0, [
        { start: 0.0, end: 1.0, label: "quote\"ok", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 6 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = 0 \n        xmax = 4 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"two\nlines\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 0.0, 4.0, [
        { start: 0.0, end: 1.0, label: "two\nlines", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 6 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n0\n4\n2\n0\n1\n\"two\nlines\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 0.0, 4.0, [
        { start: 0.0, end: 1.0, label: "two\nlines", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 7 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = 1 \n        xmax = 5 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 1.0, 5.0, [
        { start: 0.0, end: 1.0, label: "", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 7 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n1\n5\n2\n0\n1\n\"\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 1.0, 5.0, [
        { start: 0.0, end: 1.0, label: "", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 8 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = -2 \n        xmax = 6 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"中文\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -2.0, 6.0, [
        { start: 0.0, end: 1.0, label: "中文", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 8 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n-2\n6\n2\n0\n1\n\"中文\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -2.0, 6.0, [
        { start: 0.0, end: 1.0, label: "中文", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 9 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = -1 \n        xmax = 4 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"quote\"\"ok\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -1.0, 4.0, [
        { start: 0.0, end: 1.0, label: "quote\"ok", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 9 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n-1\n4\n2\n0\n1\n\"quote\"\"ok\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -1.0, 4.0, [
        { start: 0.0, end: 1.0, label: "quote\"ok", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 10 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = 0 \n        xmax = 5 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"two\nlines\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 0.0, 5.0, [
        { start: 0.0, end: 1.0, label: "two\nlines", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 10 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n0\n5\n2\n0\n1\n\"two\nlines\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 0.0, 5.0, [
        { start: 0.0, end: 1.0, label: "two\nlines", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 11 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = 1 \n        xmax = 6 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 1.0, 6.0, [
        { start: 0.0, end: 1.0, label: "", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 11 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n1\n6\n2\n0\n1\n\"\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 1.0, 6.0, [
        { start: 0.0, end: 1.0, label: "", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 12 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = -2 \n        xmax = 4 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"中文\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -2.0, 4.0, [
        { start: 0.0, end: 1.0, label: "中文", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 12 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n-2\n4\n2\n0\n1\n\"中文\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -2.0, 4.0, [
        { start: 0.0, end: 1.0, label: "中文", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 13 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = -1 \n        xmax = 5 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"quote\"\"ok\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -1.0, 5.0, [
        { start: 0.0, end: 1.0, label: "quote\"ok", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 13 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n-1\n5\n2\n0\n1\n\"quote\"\"ok\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", -1.0, 5.0, [
        { start: 0.0, end: 1.0, label: "quote\"ok", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 14 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = 0 \n        xmax = 6 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"two\nlines\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 0.0, 6.0, [
        { start: 0.0, end: 1.0, label: "two\nlines", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 14 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n0\n6\n2\n0\n1\n\"two\nlines\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 0.0, 6.0, [
        { start: 0.0, end: 1.0, label: "two\nlines", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 15 long" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\nxmin = 0 \nxmax = 5 \ntiers? <exists> \nsize = 2 \nitem []: \n    item [1]:\n        class = \"IntervalTier\" \n        name = \"词\" \n        xmin = 1 \n        xmax = 4 \n        intervals: size = 2 \n        intervals [1]:\n            xmin = 0 \n            xmax = 1 \n            text = \"\" \n        intervals [2]:\n            xmin = 1 \n            xmax = 2 \n            text = \"last\" \n    item [2]:\n        class = \"TextTier\" \n        name = \"事件\" \n        xmin = 0 \n        xmax = 1 \n        points: size = 2 \n        points [1]:\n            number = -1 \n            mark = \"前\" \n        points [2]:\n            number = 6 \n            mark = \"后\" \n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 1.0, 4.0, [
        { start: 0.0, end: 1.0, label: "", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}

///|
test "Praat independent weak 15 short" {
  assert_eq(
    parse_document(
      "File type = \"ooTextFile\"\nObject class = \"TextGrid\"\n\n0\n5\n<exists>\n2\n\"IntervalTier\"\n\"词\"\n1\n4\n2\n0\n1\n\"\"\n1\n2\n\"last\"\n\"TextTier\"\n\"事件\"\n0\n1\n2\n-1\n\"前\"\n6\n\"后\"\n",
    ),
    document(0.0, 5.0, [
      Intervals("词", 1.0, 4.0, [
        { start: 0.0, end: 1.0, label: "", },
        { start: 1.0, end: 2.0, label: "last", },
      ]),
      Points("事件", 0.0, 1.0, [
        { time: -1.0, label: "前", },
        { time: 6.0, label: "后", },
      ]),
    ]),
  )
}
