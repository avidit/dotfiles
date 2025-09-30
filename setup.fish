#!/usr/bin/env fish

# install fisher
# https://github.com/jorgebucaran/fisher
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

echo "creating symlink $HOME/dotfiles/fish_plugins -> $HOME/.config/fish/fish_plugins"
ln -fs "$HOME/dotfiles/fish_plugins" "$HOME/.config/fish/fish_plugins"
fisher update
