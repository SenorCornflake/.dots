import os
import sys

import json

def e(cmd):
    return os.popen(cmd).read()[:-1]

if len(sys.argv) < 4:
    print("Require file location, key and value")
    sys.exit()

file_name = os.path.expanduser(sys.argv[1])
key = sys.argv[2]
value = sys.argv[3]

json_file = open(file_name, "r")
jsons= json.loads(json_file.read())
json_file.close()

jsons[key] = value

jsons = json.dumps(jsons)

json_file = open(file_name, "w")
json_file.write(jsons)
json_file.close()
