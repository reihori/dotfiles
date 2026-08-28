set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

if status is-interactive
    set -g fish_greeting

    bind \eh 'commandline -i "~/"'
    bind \ej 'commandline -i " | "'
    bind \el 'commandline -i " | less"'

    abbr --add c 'cd'
    abbr --add h 'history'

    if test -f "$HOME/.cargo/env.fish"
        source "$HOME/.cargo/env.fish"
    end

    if test -d /home/linuxbrew/.linuxbrew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end

    if type -q mise
        mise activate fish | source
    end

    if type -q starship
        starship init fish | source
    end

    if type -q zoxide
        zoxide init fish | source
    end

    if type -q bat
        abbr --add b 'bat'
    end

    if type -q eza
        function l
            eza --group-directories-first --time-style=long-iso $argv
        end
        function la
            eza -a --group-directories-first --time-style=long-iso $argv
        end
        function ll
            eza -lg --group-directories-first --time-style=long-iso $argv
        end
        function lla
            eza -alg --group-directories-first --time-style=long-iso $argv
        end
        function ls
            eza --group-directories-first --time-style=long-iso $argv
        end
        function lt
            eza --tree --group-directories-first --time-style=long-iso $argv
        end
    end

    if type -q git
        abbr --add g 'git'
        abbr --add ga 'git add'
        abbr --add gaa 'git add --all'
        abbr --add gau 'git add --update'
        abbr --add gb 'git branch'
        abbr --add gc 'git commit'
        abbr --add gd 'git diff'
        abbr --add gds 'git diff --staged'
        abbr --add gl 'git log'
        abbr --add glg 'git log --oneline --all --graph'
        abbr --add glo 'git log --oneline'
        abbr --add glp 'git log --patch'
        abbr --add gr 'git restore'
        abbr --add gs 'git status'
        abbr --add gw 'git switch'
    end

    if type -q tmux
        abbr --add t 'tmux'
    end

    if type -q trash-put
        abbr --add rm 'trash-put -v'
    end

    if type -q nvim
        set -gx EDITOR nvim
        set -gx VISUAL nvim
        abbr --add v 'nvim'
    else if type -q vim
        set -gx EDITOR vim
        set -gx VISUAL vim
        abbr --add v 'vim'
    end

    if type -q wl-copy
        abbr --add wlc 'wl-copy'
    end

    if type -q wl-paste
        abbr --add wlp 'wl-paste'
    end
end
