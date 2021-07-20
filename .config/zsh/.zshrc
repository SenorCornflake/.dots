HISTSIZE=10000
SAVEHIST=100000
HISTFILE="$XDG_DATA_HOME"/zsh/history

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh || paru --skipreview -S zsh-autosuggestions-git
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh || paru --skipreview -S zsh-history-substring-search 
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh || paru --skipreview -S zsh-fast-syntax-highlighting
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh || paru --skipreview -S zsh-you-should-use


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # match all case
_comp_options+=(globdots) # complete hidden files
bindkey '^[[Z' reverse-menu-complete

PROMPT=' %F{blue}%~%f > '

alias ls='exa'
alias v='nvim'
alias vs='sudoedit'
alias nnn='nnn -dCHeQ'
alias r='ranger'
alias t='todo.sh -c -d "$HOME/.config/todotxt/conf/config"'
alias hc='herbstclient'
alias f='lfrun'
alias fetch='macchina -p -t Boron --no-box --custom-ascii ~/MAIN/tmp/arch_ascii.txt --custom-ascii-color Blue'

fetch
