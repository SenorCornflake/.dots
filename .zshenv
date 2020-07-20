export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CONFIG_HOME=~/.config/
export ZDOTDIR=$HOME/.config/zsh/
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export LESSHISTFILE=-
export QT_QPA_PLATFORMTHEME="qt5ct"

export PATH=~/.local/bin:$PATH

# Default applications
export EDITOR=nvim
export TERMINAL=alacritty
export BROWSER=firefox
export VIDEO=vlc

# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
# Start stand out
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # red
# End Underline
export LESS_TERMCAP_ue=$(tput sgr0)
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)
