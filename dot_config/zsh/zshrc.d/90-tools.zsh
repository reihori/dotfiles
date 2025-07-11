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
