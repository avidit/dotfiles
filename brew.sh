#!/usr/bin/env sh

# Install Homebrew
if [ "$(command -v brew)" = "" ]; then 
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install fish
brew install fish
if ! grep -F -q '/usr/local/bin/fish' /etc/shells; then
  echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/fish
fi

# Install GNU utilities
brew install coreutils moreutils findutils

# Install formula
brew install ack grep rename tree git wget jq macvim direnv node docker docker-compose

# Install fonts
brew tap homebrew/cask-fonts
brew install font-fira-code

# Install Mac apps
brew install browserosaurus brave-browser fork keepassxc iterm2 openinterminal vscodium dropbox
brew install --cask docker

# Remove outdated versions from the cellar
brew cleanup
brew doctor
