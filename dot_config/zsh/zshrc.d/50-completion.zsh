fpath=("$XDG_DATA_HOME/zsh/site-functions" $fpath)
typeset -U fpath FPATH

if ! typeset -f _comp_init &> /dev/null; then
  autoload -Uz compinit
  compinit
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
