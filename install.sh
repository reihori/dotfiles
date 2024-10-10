#!/bin/sh

if ! grep -q Ubuntu /etc/os-release; then
	echo 'This script is only compatible with Ubuntu.'
	exit 1
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

ln -si $script_dir/zshrc $HOME/.zshrc
mkdir -p $HOME/.config && ln -si $script_dir/starship.toml $HOME/.config
