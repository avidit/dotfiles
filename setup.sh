#!/usr/bin/env sh

DOTFILES=$HOME/dotfiles

# install homebrew and formula
sh "$DOTFILES/brew.sh"

# configure mac
sh "$DOTFILES/macos"

# change shell to fish
if ! grep -F -q "/usr/local/bin/fish" /etc/shells; then
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/fish
fi

# dotfiles
files="bashrc gitconfig gitignore_global tmux.conf"
for file in $files; do
if [ -f "$HOME/.$file" ]
then
    echo "backing up existing file $file"
    mv "$HOME/.$file" "$HOME/.$file.bak"
fi
ln -fs "$DOTFILES/$file" "$HOME/.$file"
done

# oh my fish config
if [ -d "$OMF_CONFIG" ]
then
    echo "backing up existing folder $OMF_CONFIG"
    mv "$OMF_CONFIG" "${OMF_CONFIG}.bak"
fi
ln -fs "$DOTFILES/omf" "$HOME/.config/omf"
