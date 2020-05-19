export XDG_DATA_HOME=~/.local/share/
export XDG_CONFIG_HOME=~/.config/
export ZDOTDIR=$HOME/.config/zsh/
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

# Nord
export color_normal_w="#4c566a"
export color_normal="#2e3440"
export color_focused="#8fbcbb"
export color_active="#ebcb8b"
export color_urgent="#bf616a"

export QT_QPA_PLATFORMTHEME="qt5ct" 
export LESSHISTSIZE=0
export EDITOR=nvim

alias startx="startx "$XDG_CONFIG_HOME"/X11/xinitrc"

export PATH=~/.local/bin:$PATH
