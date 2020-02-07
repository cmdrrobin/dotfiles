#!/bin/sh

DOTFILES="$HOME/.dotfiles"

if [ $(uname) == "Darwin" ]; then
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

  # Install Laravel Valet
  composer global require laravel/valet
  $HOME/.composer/vendor/bin/valet install

  # Create a Sites directory
  # This is a default directory for macOS user accounts but doesn't comes pre-installed
  mkdir $HOME/Sites

  # Copy settings of Visual Studio Code
  mkdir -p $HOME/.vscode
  cp .vscode/settings.json $HOME/.vscode

  # Pre-download Nord theme for iTerm2
  curl -sL https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors \
    -o $HOME/Downloads/Nord.itermcolors
fi

echo "Setting up your shell environment..."

# Install Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
ln -nfs $DOTFILES/.zshrc $HOME/.zshrc

# Prepare Vim configuration
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -nfs $DOTFILES/vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/plugged

# Prepare Tmux - terminal multiplexer
ln -nfs $DOTFILES/tmux.conf $HOME/.tmux.conf
mkdir -p $HOME/.tmux/plugins

# Set the correct colors for directory listing
ln -nfs $DOTFILES/nord-dircolors/src/dir_colors $HOME/.dir_colors

echo "Done. Happy coding!"

