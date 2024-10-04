#!/bin/sh

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

ln -s $script_dir/zshrc $HOME/.zshrc
mkdir -p $HOME/.config && ln -s $script_dir/starship.toml $HOME/.config
