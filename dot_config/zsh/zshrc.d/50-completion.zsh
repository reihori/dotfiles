fpath=("$XDG_DATA_HOME/zsh/site-functions" $fpath)
typeset -U fpath FPATH

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit
