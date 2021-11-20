import os
import sys

storage_file = os.path.expandvars("$DOT_ROOT/scripts/storage/night_mode.txt")

if not os.path.exists(storage_file):
    open(storage_file, "w").write("false")

enabled = open(storage_file, "r").read()

if "toggle" in sys.argv:
    if enabled == "true":
        enabled = "false"
    else:
        enabled = "true"

os.system("redshift -x")

if enabled == "true":
    os.system("redshift -O 4500")

open(storage_file, "w").write(enabled)
