#!/usr/bin/env fish

# install fisher
# https://github.com/jorgebucaran/fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
    fish -c fisher
end

ln -fs "$HOME/dotfiles/fish_plugins" "$HOME/.config/fish/fish_plugins"
fisher update
