#!/usr/bin/env sh

# Install Homebrew
if [ "$(command -v brew)" = "" ]; then 
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Fetch the newest version of Homebrew and all formulae from GitHub
brew update

# Upgrade outdated casks and outdated, unpinned formulae
brew upgrade

# Install and upgrade (by default) all dependencies from the Brewfile
brew bundle install --file "$HOME/dotfiles/Brewfile"

# Remove stale lock files and outdated downloads for all formulae and casks
brew cleanup

# Check system for potential problems
brew doctor
