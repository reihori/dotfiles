function chpwd() {
    ls --color=auto
}

function dot() {
    for cmd in chezmoi fzf; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "$cmd is not installed."
            return 1
        fi
    done
    if [[ -n "$(chezmoi status)" ]]; then
        echo 'Files differ from chezmoi.'
        return 1
    fi
    local file="$(chezmoi managed --include=files | fzf --height=40% --reverse)"
    if [[ -z "$file" ]]; then
        echo 'Cancelled.'
        return 1
    fi
    local filepath="$HOME/$file"
    if [[ ! -f $filepath ]]; then
        echo "$filepath does not exist."
        return 1
    fi
    "${EDITOR:-vim}" "$filepath"
    chezmoi re-add
}

function append-pipe-less() {
    if [[ "$LBUFFER" != *"| less"* ]]; then
        LBUFFER="$LBUFFER | less"
    fi
}
zle -N append-pipe-less
