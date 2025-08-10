if command -v starship &> /dev/null; then
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
    eval "$(starship init zsh)"
fi
