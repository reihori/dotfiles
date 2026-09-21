#!/usr/bin/env bash

set -e

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

print_step() {
    printf "\033[1;36m===> %s\033[0m\n" "$1"
}

print_step "Checking operating system..."
if [ "$(uname)" != "Linux" ]; then
    printf "Error: This script is intended for Linux environments only.\n" >&2
    exit 1
fi

print_step "Checking and installing Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

print_step "Configuring Homebrew path..."
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    printf "Error: Linuxbrew directory not found at /home/linuxbrew/.linuxbrew\n" >&2
    exit 1
fi

print_step "Installing chezmoi..."
brew install -y chezmoi

print_step "Initializing and applying dotfiles with chezmoi..."
chezmoi init --apply reihori

print_step "Installing packages listed in Brewfile..."
if [ -f "$XDG_CONFIG_HOME/homebrew/Brewfile" ]; then
    export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/homebrew/Brewfile"
    brew bundle
else
    printf "Brewfile not found. Skipping.\n"
fi

print_step "Configuring git settings..."
mkdir -p "$XDG_CONFIG_HOME/git"
touch "$XDG_CONFIG_HOME/git/config"
git config --global user.name "reihori"
git config --global user.email "151887312+reihori@users.noreply.github.com"
git config --global init.defaultbranch "main"

print_step "Updating $HOME/.profile to launch Fish..."
PROFILE_PATH="$HOME/.profile"
SNIPPET='
if [ -t 1 ] && [ -x /home/linuxbrew/.linuxbrew/bin/fish ]; then
    exec /home/linuxbrew/.linuxbrew/bin/fish
fi'
if ! grep -q "/home/linuxbrew/.linuxbrew/bin/fish" "$PROFILE_PATH" 2> /dev/null; then
    printf "%s\n" "$SNIPPET" >> "$PROFILE_PATH"
else
    printf "Fish configuration already exists in %s. Skipping.\n" "$PROFILE_PATH"
fi

print_step "Setup completed successfully! Please restart your terminal or launch fish."
