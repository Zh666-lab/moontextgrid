"""Independent TextGridTools 1.5 interop on original synthetic fixtures.
Install tools/oracle-requirements.txt, then python tools/differential.py.
--generate refreshes oracle_wbtest.mbt from the pinned independent writer.
The common subset excludes multiline labels (tgt's reader is line based).
No upstream source code or upstream corpus fixtures are copied.
"""
import argparse,json,pathlib,subprocess,tempfile
import tgt
ROOT=pathlib.Path(__file__).resolve().parents[1]
def literal(s):return json.dumps(s,ensure_ascii=False)
def original(k):
    g=tgt.TextGrid()
    end=k*0.25
    t=tgt.IntervalTier(0,end,'words')
    labels=['词语','','quote"ok','café']
    for i in range(k):t.add_interval(tgt.Interval(i*0.25,(i+1)*0.25,labels[i%4]))
    p=tgt.PointTier(0,end,'events')
    p.add_point(tgt.Point(0,'start'));p.add_point(tgt.Point(end,'end'))
    g.add_tiers([t,p]);return g

def canonical(g):
    tiers=[]
    for t in g.tiers:
        interval=isinstance(t,tgt.IntervalTier)
        entries=[[x.start_time,x.end_time,x.text] if interval else [x.time,x.text] for x in t.annotations]
        tiers.append(dict(kind='interval' if interval else 'point',name=t.name,start=t.start_time,end=t.end_time,entries=entries))
    return dict(schema='moontextgrid/1',start=g.start_time,end=g.end_time,tiers=tiers)

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--generate',action='store_true');args=parser.parse_args()
    generated=['// Generated ORIGINAL synthetic vectors by tools/differential.py using tgt 1.5.']
    for k in range(1,13):
        g=original(k)
        for style,export in [('long',tgt.io.export_to_long_textgrid),('short',tgt.io.export_to_short_textgrid)]:
            text=export(g)
            # Expected schema is computed from the independent in-memory model.
            expected=json.dumps(canonical(g),ensure_ascii=False,separators=(',',':'))
            generated.append('test "tgt independent '+style+' fixture '+str(k)+'" {\n  assert_eq(write_json(parse_text('+literal(text)+')), write_json(parse_json('+literal(expected)+')))\n}')
    target=ROOT/'oracle_wbtest.mbt'
    if args.generate:target.write_text('\n\n'.join(generated)+'\n',encoding='utf-8')
    output=subprocess.run(['moon','run','examples/interop'],cwd=ROOT,check=True,capture_output=True,text=True,encoding='utf-8').stdout
    count=0
    with tempfile.TemporaryDirectory(prefix='moontextgrid-oracle-') as td:
        for line in output.splitlines():
            item=json.loads(line)
            for style in ['long','short']:
                p=pathlib.Path(td)/(str(count)+'.TextGrid');p.write_text(item[style],encoding='utf-8')
                got=canonical(tgt.io.read_textgrid(str(p),include_empty_intervals=True))
                assert got==item['expected'],(count,style,got,item['expected'])
                count+=1
    print(json.dumps({'oracle':'TextGridTools','version':'1.5','moonbit_to_tgt':count,'tgt_to_moonbit_fixtures':24,'status':'PASS'}))
if __name__=='__main__':main()
