import os
import subprocess

from libqtile import bar, layout, widget, hook
from libqtile.config import EzClick as Click, EzDrag as Drag, Group, Key, EzKey, Match, Screen
from libqtile.lazy import lazy

mouse = [
    Drag("M-1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag("M-3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click("M-2", lazy.window.bring_to_front())
]

def commander(qtile):
    os.system("python $DOT_ROOT/scripts/gui/commander.py")

keys = [
    Key(["mod4"], "h", lazy.layout.left()),
    Key(["mod4"], "j", lazy.layout.down()),
    Key(["mod4"], "k", lazy.layout.up()),
    Key(["mod4"], "l", lazy.layout.right()),

    Key(["mod4", "shift"], "h", lazy.layout.shuffle_left()),
    Key(["mod4", "shift"], "j", lazy.layout.shuffle_down()),
    Key(["mod4", "shift"], "k", lazy.layout.shuffle_up()),
    Key(["mod4", "shift"], "l", lazy.layout.shuffle_right()),

    Key(["mod4", "control"], "h", lazy.layout.grow_left()),
    Key(["mod4", "control"], "j", lazy.layout.grow_down()),
    Key(["mod4", "control"], "k", lazy.layout.grow_up()),
    Key(["mod4", "control"], "l", lazy.layout.grow_right()),

    Key(["mod4"], "w", lazy.window.kill()),
    Key(["mod4"], "Return", lazy.spawn("kitty")),
    Key(["mod4"], "space", lazy.layout.next()),
    Key(["mod4"], "d", lazy.next_screen()),
    Key(["mod4"], "a", lazy.spawn("rofi -modi drun -show drun")),
    Key(["mod4"], "c", lazy.function(commander)),
    Key(["mod4", "shift"], "f", lazy.window.toggle_floating()),
    Key(["mod4"], "f", lazy.window.toggle_fullscreen()),

    Key(["mod4", "shift"], "r", lazy.reload_config()),
    Key(["mod4", "shift"], "q", lazy.shutdown()),
]



groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend([
        Key(["mod4"], i.name, lazy.group[i.name].toscreen()),
        Key(["mod4", "shift"], i.name, lazy.window.togroup(i.name, switch_group=False)),
    ])

layouts = [
    layout.Columns(
        margin = 10,
        border_width = 2,
        border_on_single = True,
        num_columns = 2
        )
]

font = "Terminus"
font_size = 10

screens = [
    Screen(
        top = bar.Bar([
            widget.GroupBox(
                borderwidth = 2,
                rounded = False,
                font = font,
                fontsize = font_size,
                foreground = "00ffff",
                highlight_method = "text",
                active = "999999",
                inactive = "333333",

                this_screen_border = "ffff00",
                this_current_screen_border = "00ff00",

                other_screen_border = "00aaaaa",
                other_current_screen_border = "ff0000",
            ),
            widget.WindowName(
                foreground = "ddaa00",
                format = "{name}",
                max_chars = 30,
                font = font,
                fontsize = font_size
                ),
            widget.Spacer(
                length = bar.STRETCH
            ),
            widget.Clock(
                font = font,
                fontsize = font_size,
                foreground = "bbbbbb",
                format = "%H:%M:%S %a, %d %b %Y",
                )
        ], 
        30,
        background = "#000000"
        )
    ) for _ in range(0,2)
]

dgroups_key_binder = None
dgroups_apps_rules = []
follow_mouse_focus = False
cursor_warp = False
auto_fullscreen = True
auto_minimize = True
wmname = "LG3D"

@hook.subscribe.startup
def startup():
    script = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([script])
