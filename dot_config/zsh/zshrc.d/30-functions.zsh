function chpwd() {
    ls --color=auto
}

function chezmoi-edit-apply() {
    [[ -n "$(chezmoi status)" ]] && return
    local file="$(chezmoi managed --include=files | fzf --height=30 --reverse)"
    local filepath="$HOME/$file"
    [[ ! -f $filepath ]] && return
    vim $filepath
    chezmoi add $filepath
}
