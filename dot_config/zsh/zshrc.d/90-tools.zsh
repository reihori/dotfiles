export NVM_DIR="$XDG_CONFIG_HOME/nvm"
if [[ -d "$NVM_DIR" ]]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v lsd &> /dev/null; then
    alias lsd='lsd --group-directories-first --icon=never'
    alias ls='lsd'
    alias lt='lsd --tree'
fi

if command -v abbr &> /dev/null; then
    abbr import-aliases --session --quiet
    abbr erase --session --quiet ls
fi
