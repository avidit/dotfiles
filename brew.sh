#!/usr/bin/env sh

# Install Homebrew
if [[ $(command -v brew) == "" ]]; then 
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install fish
brew install fish
if ! fgrep -q '/usr/local/bin/fish' /etc/shells; then
  echo '/usr/local/bin/fish' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install GNU utilities
brew install coreutils
#brew install moreutils findutils

# Install formula
brew install wget --with-iri
brew install macvim --with-override-system-vim
brew install ack grep rename tree git

# Install fonts
brew tap caskroom/fonts
brew cask install font-hack-nerd-font

# Install Mac apps
brew cask install firefox
brew cask install qlstephen
brew cask install visual-studio-code

# Remove outdated versions from the cellar
brew cleanup
brew doctor
