''
# vim:fileencoding=utf-8:ft=conf:foldmethod=marker

# Selenized white color scheme for Kitty

#: Color scheme {{{

#: The foreground and background colors
foreground #474747
background #ffffff

#: The opacity of the background. A number between 0 and 1, where 1 is
#: opaque and 0 is fully transparent.  This will only work if
#: supported by the OS (for instance, when using a compositor under
#: X11). Note that it only sets the default background color's
#: opacity. This is so that things like the status bar in vim,
#: powerline prompts, etc. still look good.  But it means that if you
#: use a color theme with a background color in your editor, it will
#: not be rendered as transparent.  Instead you should change the
#: default background color in your kitty config and not use a
#: background color in the editor color scheme. Or use the escape
#: codes to set the terminals default colors in a shell script to
#: launch your editor.  Be aware that using a value less than 1.0 is a
#: (possibly significant) performance hit.  If you want to dynamically
#: change transparency of windows set dynamic_background_opacity to
#: yes (this is off by default as it has a performance cost)
background_opacity 1.0

#: Allow changing of the background_opacity dynamically, using either
#: keyboard shortcuts (increase_background_opacity and
#: decrease_background_opacity) or the remote control facility.
dynamic_background_opacity no

#: How much to dim text that has the DIM/FAINT attribute set. One
#: means no dimming and zero means fully dimmed (i.e. invisible).
dim_opacity 0.625

#: The foreground for text selected with the mouse. A value of none
#: means to leave the color unchanged.
selection_foreground none

#: The background for text selected with the mouse.
selection_background #cdcdcd

#: Tab bar colors
active_tab_foreground   #282828
active_tab_background   #cdcdcd
inactive_tab_foreground #878787
inactive_tab_background #ffffff
tab_bar_background      #ffffff

#: The 16 terminal colors. There are 8 basic colors, each color has a
#: dull and bright version. You can also set the remaining colors from
#: the 256 color table as color16 to color255.

#: black
color0 #ebebeb
color8 #cdcdcd

#: red
color1 #d6000c
color9 #bf0000

#: green
color2  #1d9700
color10 #008400

#: yellow
color3  #c49700
color11 #af8500

#: blue
color4  #0064e4
color12 #0054cf

#: magenta
color5  #dd0f9d
color13 #c7008b

#: cyan
color6  #00ad9c
color14 #009a8a

#: white
color7  #878787
color15 #282828

#: }}}''
