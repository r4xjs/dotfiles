"""
Zaproxy Encoder/Decoder Script
"""
from org.zaproxy.addon.encoder.processors import EncodeDecodeResult
from base64 import b64decode
import json
import urllib
import re

debug=False

def log(v):
    global debug
    if debug:
        print(v)

def try_urldecode(value):
    log("try_urldecode in: %s"%(value))

    res = value
    try:
        res = urllib.unquote(res).decode('utf8')
    except:
        pass
    return res

def try_b64decode(value):
    log("try_b64decode in: %s"%(value))
    #m = re.search("([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)", value)
    m = re.search("([A-Za-z0-9+/]{4,}={0,2})", value)
    if not m:
        return value

    pos1 = max(0, m.span()[0])
    pos2 = min(len(value)-1, m.span()[1])
    prefix = ""
    postfix = ""
    if pos1 != 0:
        prefix = value[0:pos1]
    if pos2 != len(value)-1:
        postfix = value[pos2:]


    res = prefix
    try:
        enc = m.group(0)
        res += b64decode(enc + '=' * (-len(enc) % 4))
    except:
        pass
    return res + postfix

def try_json_indent(value):
    log("try_json_indent in: %s"%(value))

    res = value
    try:
        p1 = value.find('[')
        p2 = value.find('{')
        p = 0
        if p1 == -1:
            if p2 == -1:
                # there is no [ or {
                return value
            # found {
            p = p2
        elif p2 == -1:
            # found [
            p = p1
        else:
            # found both
            p = min(p1, p2)
        res = json.dumps(json.loads(value[p:]), indent=4)
    except Exception as e:
        log(e)
    return res

def process(value):

    value = try_urldecode(value)
    res = []
    for line in value.split('\n'):
        # try to split by point because
        # point is often used in jwt
        for r in line.split('.'):
            try:
                res.append(try_json_indent(try_b64decode(r)).decode('utf-8'))
            except:
                pass

    return EncodeDecodeResult("\n".join(res))

