typeset -A aliases
aliases=(
    c 'cd'
    g 'git'
    ga 'git add'
    gaa 'git add --all'
    gau 'git add --update'
    gb 'git branch'
    gc 'git commit'
    gd 'git diff'
    gds 'git diff --staged'
    gl 'git log'
    glg 'git log --oneline --all --graph'
    glo 'git log --oneline'
    glp 'git log --patch'
    gr 'git restore'
    gs 'git status'
    gw 'git switch'
    h 'history'
    l 'ls'
    la 'ls -A'
    ll 'ls -lh'
    lla 'ls -lhA'
    ls 'ls --color=auto --group-directories-first'
    v 'vim'
)

for key val in ${(kv)aliases}; do
    alias "$key"="$val"
done
