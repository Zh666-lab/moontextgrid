"""Run the actual Praat engine (Parselmouth 0.4.6 / Praat 6.1.38).
Original synthetic vectors cover valid weak domain invariants, multiline labels,
Chinese, quotes and empty labels. No upstream code/corpus is copied.
--generate refreshes committed independent writer fixtures; normal runs verify
the committed fixtures by executing them. No source edits in normal mode.
"""
import argparse
import json
import pathlib
import re
import subprocess
import tempfile
import parselmouth

ROOT = pathlib.Path(__file__).resolve().parents[1]


def read_text(path):
    data = path.read_bytes()
    # Praat Windows writes CRLF throughout, including multiline strings.
    # Normalize the reference writer's platform line endings for portable fixtures.
    return data.decode('utf-16' if data.startswith((b'\xff\xfe', b'\xfe\xff')) else 'utf-8-sig').replace('\r\n', '\n')


def short_model(text):
    # Independent scanner used ONLY on Praat's canonical short writer output.
    body = '\n'.join(text.splitlines()[2:])
    tokens = re.findall(r'"(?:[^"]|"")*"|<[^>]+>|[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?', body)
    values = iter(tokens)
    def string():
        s = next(values)
        assert s.startswith('"') and s.endswith('"')
        return s[1:-1].replace('""', '"')
    def number():
        return float(next(values))
    a, b = number(), number()
    assert next(values) == '<exists>'
    tiers = []
    for _ in range(int(next(values))):
        kind, name, lo, hi = string(), string(), number(), number()
        entries = []
        for _ in range(int(next(values))):
            if kind == 'IntervalTier':
                entries.append([number(), number(), string()])
            else:
                assert kind == 'TextTier'
                entries.append([number(), string()])
        tiers.append([kind, name, lo, hi, entries])
    assert next(values, None) is None
    return [a, b, tiers]


def expected(k, aligned=False):
    label = ['中文', 'quote"ok', 'two\nlines', ''][k % 4]
    left, right = float(k % 4 - 2), float(k % 3 + 4)
    xs = [[0.0, 1.0, label], [1.0, 2.0, 'last']]
    points = [[-1.0, '前'], [6.0, '后']]
    if aligned:
        a, b = min(0.0, left, -1.0), max(5.0, right, 6.0)
        return [a, b, [['IntervalTier', '词', a, b, [[a, 0.0, '']] + xs + [[2.0, b, '']]], ['TextTier', '事件', a, b, points]]]
    return [0.0, 5.0, [['IntervalTier', '词', left, right, xs], ['TextTier', '事件', 0.0, 1.0, points]]]


def moon_literal(model):
    a, b, tiers = model
    lit = lambda s: json.dumps(s, ensure_ascii=False)
    out = []
    for kind, name, lo, hi, entries in tiers:
        if kind == 'IntervalTier':
            xs = ', '.join('{ start: %s, end: %s, label: %s }' % (x, y, lit(label)) for x, y, label in entries)
            out.append('Intervals(%s, %s, %s, [%s])' % (lit(name), lo, hi, xs))
        else:
            xs = ', '.join('{ time: %s, label: %s }' % (x, lit(label)) for x, label in entries)
            out.append('Points(%s, %s, %s, [%s])' % (lit(name), lo, hi, xs))
    return 'document(%s, %s, [%s])' % (a, b, ', '.join(out))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--generate', action='store_true')
    args = parser.parse_args()
    assert parselmouth.__version__ == '0.4.6'
    assert parselmouth.PRAAT_VERSION == '6.1.38'
    result = subprocess.run(['moon', 'run', 'examples/document_vectors'], cwd=ROOT, check=True, capture_output=True, text=True, encoding='utf8')
    generated = ['// Original synthetic vectors written by Praat 6.1.38; regenerate with tools/praat_differential.py --generate.']
    count = 0
    reference_inputs = []
    with tempfile.TemporaryDirectory(prefix='moontextgrid-praat-') as td:
        folder = pathlib.Path(td)
        for line in result.stdout.splitlines():
            row = json.loads(line)
            k = int(row['id'])
            for style in ['long', 'short', 'edited_long', 'edited_short']:
                source = folder / 'input.TextGrid'
                source.write_text(row[style], encoding='utf8')
                reference = parselmouth.read(str(source))
                short = folder / 'short.TextGrid'
                reference.save_as_short_text_file(str(short))
                model = expected(k, aligned=style.startswith('edited_'))
                assert short_model(read_text(short)) == model, (k, style, short_model(read_text(short)), model)
                count += 1
                if style in ['long', 'short']:
                    target = folder / 'reference.TextGrid'
                    if style == 'long':
                        reference.save_as_text_file(str(target))
                    else:
                        reference.save_as_short_text_file(str(target))
                    text = read_text(target)
                    reference_inputs.append(text)
                    generated.append('test "Praat independent weak %s %s" {\n  assert_eq(parse_document(%s), %s)\n}' % (k, style, json.dumps(text, ensure_ascii=False), moon_literal(model)))
    target = ROOT / 'praat_oracle_wbtest.mbt'
    source = '\n\n'.join(generated) + '\n'
    if args.generate:
        target.write_text(source, encoding='utf8')
    assert target.is_file(), 'run once with --generate and commit fixtures'
    committed = re.findall(r'parse_document\(\s*("(?:\\.|[^"\\])*")', target.read_text(encoding='utf8'))
    assert [json.loads(text) for text in committed] == reference_inputs, 'independent fixtures stale; regenerate explicitly'
    check = subprocess.run(['moon', 'test', '--deny-warn', '--filter', 'Praat independent weak*'], cwd=ROOT, check=True, capture_output=True, text=True, encoding='utf8')
    assert 'Total tests: 32, passed: 32, failed: 0.' in check.stdout, check.stdout + check.stderr
    print(check.stdout.strip())
    assert len(generated) - 1 == 32
    print(json.dumps({'oracle': 'actual Praat engine', 'parselmouth': parselmouth.__version__, 'praat': parselmouth.PRAAT_VERSION, 'moonbit_to_praat': count, 'praat_to_moonbit': 32, 'status': 'PASS'}))


if __name__ == '__main__':
    main()
