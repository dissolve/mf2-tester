import mf2py
import sys
import json
if len(sys.argv) < 2:
    print('usage: '+ sys.argv[0]+ ' <inputfile> <outputfile>')
    sys.exit(1)


with open(sys.argv[1],'r') as file:
    p = mf2py.Parser(doc=file, url='http://example.com/')
    res = json.loads(p.to_json())
    del res['debug']
    print(json.dumps(res))

