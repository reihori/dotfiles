if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v lsd &> /dev/null; then
    alias ls='lsd --group-directories-first'
    alias lt='lsd --tree'
fi

if command -v abbr &> /dev/null; then
    abbr import-aliases --session --quiet
    abbr erase --session --quiet ls
fi
