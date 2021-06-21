
from ranger.colorschemes.default import Default
from ranger.gui.color import (
    black, blue, cyan, green, magenta, red, white, yellow, default,
    normal, bold, reverse, dim, BRIGHT,
    default_colors,
)

class Scheme(Default):

    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.executable and not \
                any((context.media, context.container,
                     context.fifo, context.socket)):
            attr |= bold
            fg = green

        return fg, bg, attr
