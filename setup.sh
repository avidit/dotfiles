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

fish_config_file="$HOME/.config/fish/config.fish"
if [ -f "$fish_config_file" ]
then
    echo "backing up existing file $fish_config_file"
    mv "$fish_config_file" "${fish_config_file}.bak"
fi
ln -fs "$DOTFILES/config.fish" "$fish_config_file"
