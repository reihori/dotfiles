# To enable fwd-i-search
stty stop ^x

export LANG="en_US.UTF-8"
export LESSHISTFILE=-
export LSCOLORS=exfxcxdxbxegedabagacad
export PATH="$HOME/.local/bin:$PATH"

typeset -U path PATH

setopt AUTO_CD
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

chpwd() {
	ls
}

_echo_eval() {
	echo "> $1"
	eval $1
}
sync_plugins() {
	local -A plugins
	plugins=(
		pure https://github.com/sindresorhus/pure.git
		zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
		zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
		zsh-abbr https://github.com/olets/zsh-abbr
	)
	local dir="$HOME/zsh_tmp"
	if [ -d "$dir" ]; then
		_echo_eval "rm -rf $dir"
	fi
	for key in ${(k)plugins}; do
		_echo_eval "git clone --depth 1 $plugins[$key] $dir/$key 2> /dev/null"
	done
}

if [ -d "${HOME}/.zsh/pure" ]; then
	fpath+=(${HOME}/.zsh/pure)
	autoload -U promptinit && promptinit
	prompt pure
fi

if [ -d "${HOME}/.zsh/zsh-autosuggestions" ]; then
	source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -d "${HOME}/.zsh/zsh-syntax-highlighting" ]; then
	source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if command -v mise > /dev/null; then
	eval "$(mise activate zsh)"
fi

if command -v zoxide > /dev/null; then
	export _ZO_DATA_DIR="${HOME}/.local/share"
	eval "$(zoxide init zsh)"
fi

alias_cmd=alias
if [ -d "${HOME}/.zsh/zsh-abbr" ]; then
	source ${HOME}/.zsh/zsh-abbr/zsh-abbr.zsh
	alias_cmd=(abbr --session --quiet)
fi

$alias_cmd c="cd"
$alias_cmd h="history"
$alias_cmd v="vim"

alias ls="ls --color=auto"
$alias_cmd l="ls -1"
$alias_cmd la="ls -A"
$alias_cmd ll="ls -hl"

$alias_cmd g="git"
$alias_cmd ga="git add"
$alias_cmd gaa="git add --all"
$alias_cmd gau="git add --update"
$alias_cmd gb="git branch"
$alias_cmd gc="git commit"
$alias_cmd gd="git diff"
$alias_cmd gds="git diff --staged"
$alias_cmd gl="git log"
$alias_cmd glg="git log --oneline --all --graph"
$alias_cmd glo="git log --oneline"
$alias_cmd glp="git log --patch"
$alias_cmd gs="git status"
$alias_cmd gw="git switch"

$alias_cmd vv="vim ~/.vimrc"
$alias_cmd vz="vim ~/.zshrc"
