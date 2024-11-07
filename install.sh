#!/bin/bash

echo
echo "     ____ ____ ____ ____ ____ ____ ____ ____"
echo "     ||D |||O |||T |||F |||I |||L |||E |||S ||"
echo "     ||__|||__|||__|||__|||__|||__|||__|||__||"
echo "     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|"
echo

if [ "$(uname)" == "Darwin" ]; then
    echo "Preparing OSX environment...."
    cp Brewfile $HOME/.Brewfile

    if [ ! -f "/opt/homebrew/bin/brew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    # load Brew environment
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Preparing system
    brew bundle install --global

    # Remove stale or outdated downloads
    brew cleanup --prune 0

    echo "Configuring default settings for Mac OS..."
    cat /etc/pam.d/sudo_local.template | sed 's/^#auth/auth/' | sudo tee /etc/pam.d/sudo_local

    # some default settings
    # Disable automatic window animations
    defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
    # Save to local disk by default (disable iCloud save)
    defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false
    # Expand save panel by default
    defaults write -g NSNavPanelExpandedStateForSaveMode -bool false

    # Set default folder for screen captures
    defaults write com.apple.screencapture location "~/Pictures/Screenshots"
    # Add a nice login message
    sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "I use Neovim btw ⌨️"
    # map capslock to escape
    hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":30064771129,"HIDKeyboardModifierMappingDst":30064771113}]}'
    # autohide dock and restart Dock process
    defaults write com.apple.dock autohide -bool "true" && killall Dock
    # remove old items after 30 days
    defaults write com.apple.finder FXRemoveOldTrashItems -bool "true" && killall Finder
fi

echo "Stowing my configuration files"
stow */ -t ~

echo "Installing nvim config"
git clone https://github.com/rgruyters/nvim.git $HOME/.config/nvim
