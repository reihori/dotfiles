function chpwd() {
    ls --color=auto
}

function chezmoi-readd-all() {
    if ! command -v chezmoi &> /dev/null; then
        echo 'chezmoi is not installed.'
        return 1
    fi
    chezmoi managed --include=files | xargs -I{} chezmoi add {}
}

function dot() {
    if ! command -v chezmoi &> /dev/null; then
        echo 'chezmoi is not installed.'
        return 1
    fi
    if [[ -n "$(chezmoi status)" ]]; then
        echo 'Files differ from chezmoi.'
        return 1
    fi
    local file="$(chezmoi managed --include=files | fzf --height=40% --reverse)"
    if [[ -z "$file" ]]; then
        echo "Cancelled."
        return 1
    fi
    local filepath="$HOME/$file"
    if [[ ! -f $filepath ]]; then
        echo "$filepath does not exist."
        return 1
    fi
    ${EDITOR:-vim} $filepath
    chezmoi-readd-all
}

function append-pipe-less() {
    if [[ "$LBUFFER" != *"| less"* ]]; then
        LBUFFER="$LBUFFER | less"
    fi
}
zle -N append-pipe-less
