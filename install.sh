#!/bin/sh

DOTFILES="$HOME/.dotfiles"

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
ln -nfs $DOTFILES/.zshrc $HOME/.zshrc

# Prepare Vim configuration
ln -nfs $DOTFILES/.vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/plugged

# Prepare Tmux - terminal multiplexer
ln -nfs $DOTFILES/.tmux.conf $HOME/.tmux.conf
mkdir -p $HOME/.tmux/plugins

