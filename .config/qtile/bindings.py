from libqtile.config import EzKey as Key, EzDrag as Drag, EzClick as Click
from libqtile.lazy import lazy

def create_keys(keys, groups):
    key_array = []

    for key in keys.keys():
        callback = keys[key]
        key_array.append(Key(key, callback))

    for group in groups:
        key_array.extend([
            Key("M-" + group.name, lazy.group[group.name].toscreen()),
            Key("M-S-" + group.name, lazy.window.togroup(group.name))
        ])
    
    return key_array

def create_mouse(mouse):
    mouse_array = []

    for key in mouse["click"].keys():
        callback = mouse["click"][key]
        mouse_array.append(Click(key, callback))

    for key in mouse["drag"].keys():
        callback = mouse["drag"][key]
        mouse_array.append(Click(key, callback))

    return mouse_array

def commander(qtile):
    subprocess.Popen(["python", os.path.expanduser("~/MAIN/commander/main.py"), os.path.expanduser("~/MAIN/commander/commands.json")])

def keys(groups):
    return create_keys({
        "M-h"        : lazy.layout.left(),
        "M-j"        : lazy.layout.down(),
        "M-k"        : lazy.layout.up(),
        "M-l"        : lazy.layout.right(),
        "M-S-h"      : lazy.layout.shuffle_left(),
        "M-S-j"      : lazy.layout.shuffle_down(),
        "M-S-k"      : lazy.layout.shuffle_up(),
        "M-S-l"      : lazy.layout.shuffle_right(),
        "M-w"        : lazy.window.kill(),
        "M-d"        : lazy.next_screen(),
        "M-<Return>" : lazy.spawn("alacritty"),
        "M-a"        : lazy.spawn("rofi -modi drun -show drun"),
        "M-c"        : lazy.function(commander),
        "M-S-r"      : lazy.restart(),
        "M-S-q"      : lazy.shutdown(),
        "M-<space>"  : lazy.next_layout()
    }, groups)

mouse = create_mouse({
    "drag": {
        "M-1": lazy.window.set_position_floating(),
        "M-3": lazy.window.set_size_floating()
    },
    "click": {
        "M-2": lazy.window.bring_to_front()
    }
})
