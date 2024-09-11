#!/bin/bash


echo
echo "     ____ ____ ____ ____ ____ ____ ____ ____"
echo "     ||D |||O |||T |||F |||I |||L |||E |||S ||"
echo "     ||__|||__|||__|||__|||__|||__|||__|||__||"
echo "     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|"
echo

if [ "$(uname)" == "Darwin" ]; then
    echo "Preparing OSX environment..."
    echo "Initiating Nix environment..."
    curl -L https://nixos.org/nix/install | sh

    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "Initiating Nix Darwin..."
    pushd nix
    nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake '.#'
    popd
fi

echo "Installing nvim config"
git clone https://github.com/rgruyters/nvim.git $HOME/.config/nvim

echo "Installing zap"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
