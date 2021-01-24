import os

base16_themes_dir = os.path.expanduser("~/environment/base16/schemes")

theme_names = []
theme_paths = []

for folder in os.listdir(base16_themes_dir):
    for f in os.listdir(base16_themes_dir + '/' + folder):
        extension = os.path.splitext(f)[1]

        if extension == ".yaml" or extension == ".yml":
            theme_name = os.path.splitext(f)[0].split("-")

            for i, word in enumerate(theme_name):
                word = word[0].upper() + word[1:]
                theme_name[i] = word
            
            theme_name = " ".join(theme_name)

            theme_paths.append(base16_themes_dir + "/" + folder + "/" + f)
            theme_names.append(theme_name)

cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Base16 Theme:"'.format("\n".join(theme_names))

index = os.popen(cmd).read()[:-1]

if index != "":
    index = int(index)
    os.system('python ~/environment/scripts/setup_base16_theme.py "{}"'.format(theme_paths[index]))
