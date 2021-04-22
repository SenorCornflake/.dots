import os
import sys

cache_file = os.path.expanduser("~/environment/cache/nightmode_enabled")

if not os.path.exists(cache_file):
    open(cache_file, "w").write("false")

enabled = open(cache_file, "r").read()[:-1]

if "toggle" in sys.argv:
    if enabled == "true":
        enabled = "false"
    elif enabled == "false":
        enabled = "true"

if enabled == "true":
    os.system("redshift -x")
    os.system("redshift -O 4500")
else:
    os.system("redshift -x")

open(cache_file, "w").write(enabled + "\n")
