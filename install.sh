#!/bin/sh

if ! grep -q Ubuntu /etc/os-release; then
	echo 'This script is only compatible with Ubuntu. (exit 1)'
	exit 1
fi

if ! command -v git > /dev/null; then
	echo 'git is required. (exit 1)'
	exit 1
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

echo_eval() {
	echo "> $1"
	eval $1
}

# zsh
echo_eval "ln -fs $script_dir/zshrc $HOME/.zshrc"
dotzshdir="$HOME/.zsh"
plugindir="$dotzshdir/plugins"
echo_eval "rm -rf $plugindir"
echo_eval "git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions $plugindir/zsh-autosuggestions 2> /dev/null"
echo_eval "git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting $plugindir/zsh-syntax-highlighting 2> /dev/null"
echo_eval "git clone --depth 1 https://github.com/olets/zsh-abbr $plugindir/zsh-abbr 2> /dev/null"

# vim
echo_eval "ln -fs $script_dir/vimrc $HOME/.vimrc"

# starship
echo_eval "mkdir -p $HOME/.config && ln -fs $script_dir/starship.toml $HOME/.config"
