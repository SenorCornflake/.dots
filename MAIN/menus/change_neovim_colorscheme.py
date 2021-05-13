import os

def colorschemes():
    plugin_dir = os.path.expanduser("~/.local/share/nvim/site/pack/packer/start/")
    plugins = os.listdir(plugin_dir)

    colorschemes = []

    for plugin in plugins:
        plugin_files = os.listdir(plugin_dir + "/" + plugin)
        colors_dir = plugin_dir + "/" + plugin + "/" + "colors"
        if os.path.exists(colors_dir):
            colors = os.listdir(colors_dir)
            for color in colors:
                colorschemes.append(color.replace(".vim", ""))
    return colorschemes

colors = colorschemes()

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Colorscheme"'.format("\n".join(colors))
index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)

    os.system('exconman set neovim.colorscheme {}'.format(colors[index]))
    os.system('python ~/MAIN/scripts/neovim_command.py "colorscheme {}"'.format(colors[index]))
