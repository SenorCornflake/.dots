
# Remove configs from home directory
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME=~/.config/
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export ZDOTDIR=$HOME/.config/zsh/
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export LESSHISTFILE=-
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# Other
export QT_QPA_PLATFORMTHEME="qt5ct"
export BAT_THEME="base16" # Set bat theme to base16, this is the program FZF in vim uses to highlight code previews
export TODO_DIR="~/.config/todotxt"

# Pfetch
export PF_INFO="ascii title os host kernel uptime pkgs memory shell editor wm de palette"

# Path related
export PATH=~/.local/bin:$PATH

# Default applications
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=alacritty
export BROWSER=firefox
export VIDEO=vlc

# highlight (for ranger previews)
export HIGHLIGHT_STYLE=base16

# Man pages highlight
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

if [ -e /home/a/.nix-profile/etc/profile.d/nix.sh ]; then . /home/a/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
