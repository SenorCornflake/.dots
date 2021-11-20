#!/usr/bin/env python
import os
import json
import time as t

file_path = os.path.expandvars("$DOT_ROOT/scripts/storage/objective.json")

if not os.path.exists(file_path):
    file = open(file_path, "w")
    file.write('{"objective": "none", "time": "none"}')
    file.close()

while True:
    file = open(file_path, "r")
    data = file.read()
    data = json.loads(data)
    objective = data["objective"]
    time = data["time"]
    file.close()

    print(objective, time)

    t.sleep(1)
