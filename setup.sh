#!/usr/bin/env sh

DOTFILES=$HOME/dotfiles

# configure mac
# sh "$DOTFILES/macos"

# install homebrew and formula
sh "$DOTFILES/brew.sh"

# change shell to fish
if command -v fish &> /dev/null; then
    echo "changing shell to fish"
    FISH=$(which fish)
    if ! grep -F -q "$FISH" /etc/shells; then
        echo "$FISH" | sudo tee -a /etc/shells
        chsh -s "$FISH"
    fi
fi

# dotfiles
files="bashrc gitconfig gitignore_global tmux.conf"
for file in $files; do
if [ -f "$HOME/.$file" ]
then
    echo "backing up existing file $file"
    mv "$HOME/.$file" "$HOME/.$file.bak"
fi
echo "creating symlink $DOTFILES/$file -> $HOME/.$file"
ln -fs "$DOTFILES/$file" "$HOME/.$file"
done

fish_config_file="$HOME/.config/fish/config.fish"
touch $fish_config_file
if [ -f "$fish_config_file" ]
then
    echo "backing up existing file $fish_config_file"
    mv "$fish_config_file" "${fish_config_file}.bak"
fi
echo "creating symlink $DOTFILES/config.fish -> $fish_config_file"
ln -fs "$DOTFILES/config.fish" "$fish_config_file"
