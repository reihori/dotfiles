function chpwd() {
    ls --color=auto
}

function chezmoi-edit-apply() {
    if ! command -v chezmoi &> /dev/null; then
        echo 'chezmoi is not installed.'
        return 1
    fi
    if [[ -n "$(chezmoi status)" ]]; then
        echo 'Files differ from chezmoi.'
        return 1
    fi
    local file="$(chezmoi managed --include=files | fzf --reverse)"
    local filepath="$HOME/$file"
    if [[ ! -f $filepath ]]; then
        echo "$filepath does not exist."
        return 1
    fi
    ${EDITOR:-vim} $filepath
    chezmoi add $filepath
}
