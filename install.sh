#!/bin/bash


echo "     ____ ____ ____ ____ ____ ____ ____ ____"
echo "     ||D |||O |||T |||F |||I |||L |||E |||S ||"
echo "     ||__|||__|||__|||__|||__|||__|||__|||__||"
echo "     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|"

if [ "$(uname)" == "Darwin" ]; then
    echo "Preparing OSX environment...."
    curl -L https://nixos.org/nix/install | sh

    pushd nix
    nix build --extra-experimental-features "nix-command flakes" '.#darwin.Configurations.Robins-MacBook-Pro.system'
    ./result/sw/bin/darwin-rebuild switch --flake '.#'
    popd
fi

echo "Installing nvim config"
git clone git@github.com:rgruyters/nvim.git $HOME/.config/nvim

echo "Installing zap"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
