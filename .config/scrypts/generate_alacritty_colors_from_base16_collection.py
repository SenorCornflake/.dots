import os
import yaml

base16_folder = '~/Projects/base16-themes'
output_folder = '~/.config/scrypts/themes/alacritty'

themes = os.listdir(os.path.expanduser(base16_folder))

alacritty_template = """
# {} - alacritty color config
# {}
colors:
  # Default colors
  primary:
    background: '0x{}'
    foreground: '0x{}'

  # Colors the cursor will use if `custom_cursor_colors` is true
  cursor:
    text: '0x{}'
    cursor: '0x{}'

  # Normal colors
  normal:
    black:   '0x{}'
    red:     '0x{}'
    green:   '0x{}'
    yellow:  '0x{}'
    blue:    '0x{}'
    magenta: '0x{}'
    cyan:    '0x{}'
    white:   '0x{}'

  # Bright colors
  bright:
    black:   '0x{}'
    red:     '0x{}'
    green:   '0x{}'
    yellow:  '0x{}'
    blue:    '0x{}'
    magenta: '0x{}'
    cyan:    '0x{}'
    white:   '0x{}'

draw_bold_text_with_bright_colors: false
"""

for theme in themes:
    file_name = theme
    theme = open(os.path.expanduser(base16_folder + '/' + file_name), 'r').read()
    theme = yaml.load(theme, Loader=yaml.BaseLoader)

    contents = alacritty_template.format(
        'Base16 {}'.format(theme['scheme']),
        theme['author'],
        theme['base00'], # background
        theme['base05'], # foreground
        theme['base00'], # cursor text
        theme['base05'], # cursor
        theme['base00'], # normal black
        theme['base08'], # normal red
        theme['base0B'], # normal green
        theme['base0A'], # normal yellow
        theme['base0D'], # normal blue
        theme['base0E'], # normal magenta
        theme['base0C'], # normal cyan
        
        theme['base05'], # normal white
        theme['base03'], # bright black
        theme['base09'], # bright red
        theme['base01'], # bright green
        theme['base02'], # bright yellow
        theme['base04'], # bright blue
        theme['base06'], # bright magenta
        theme['base0F'], # bright cyan
        theme['base07'], # bright white
    )
    open(os.path.expanduser(output_folder + '/' + file_name), 'w').write(contents)
