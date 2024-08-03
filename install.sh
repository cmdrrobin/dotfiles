#!/bin/bash

echo "Installing dotfiles"

if [ "$(uname)" == "Darwin" ]; then
    echo "Preparing OSX environment...."
    curl -L https://nixos.org/nix/install | sh

    cp Brewfile $HOME/.Brewfile

    if [ ! -f "/usr/local/bin/brew" ] && [ ! -f "/opt/homebrew/bin/brew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    # Preparing system
    brew bundle install --global

    # Remove stale or outdated downloads
    brew cleanup --prune 0
fi

echo "Stowing my configuration files"
stow */

echo "Installing nvim config"
git clone git@github.com:rgruyters/nvim.git $HOME/.config/nvim

echo "Installing zap"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
