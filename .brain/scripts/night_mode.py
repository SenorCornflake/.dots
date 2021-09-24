import os
import sys

storage_file = os.path.expandvars("$DOTFILES_BRAIN_ROOT/storage/night_mode.txt")

if not os.path.exists(storage_file):
    open(storage_file, "w").write("false")

enabled = open(storage_file, "r").read()

if "toggle" in sys.argv:
    if enabled == "true":
        enabled = "false"
    else:
        enabled = "true"

if enabled == "true":
    os.system("redshift -x")
    os.system("redshift -O 4500")
else:
    os.system("redshift -x")

open(storage_file, "w").write(enabled)
