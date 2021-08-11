import os
import sys

cache_file = os.path.expandvars("$DOTFILES_BRAIN_ROOT/tmp/nightmode_enabled.txt")

if not os.path.exists(cache_file):
    open(cache_file, "w").write("false")

enabled = open(cache_file, "r").read()

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

open(cache_file, "w").write(enabled)
