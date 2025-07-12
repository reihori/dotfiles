if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

export NVM_DIR="$XDG_CONFIG_HOME/nvm"
function nvm() {
    if [[ ! -d "$NVM_DIR" ]]; then
        echo 'nvm is not installed.'
        return 1
    fi
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm "$@"
}

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v lsd &> /dev/null; then
    alias lsd='lsd --group-directories-first --icon=never'
    alias ls='lsd'
    alias lt='lsd --tree'
fi

if command -v bat &> /dev/null; then
    alias b='bat'
fi

if command -v abbr &> /dev/null; then
    abbr import-aliases --session --quiet
    abbr erase --session --quiet ls
fi
