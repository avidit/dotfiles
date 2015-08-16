#!/usr/bin/env sh

# Load dotfiles
[ -f ~/dotfiles/shell/env.fish ]; and source $HOME/dotfiles/shell/env.fish
[ -f ~/dotfiles/shell/aliases ]; and source $HOME/dotfiles/shell/aliases

# Load brew formula
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# Load oh-my-fish configuration.
set fish_path $HOME/.oh-my-fish
source $fish_path/oh-my-fish.fish

Theme 'agnoster'

Plugin 'theme'
Plugin 'balias'
Plugin 'sublime'
Plugin 'vi-mode'
Plugin 'tmux'
Plugin 'rvm'
Plugin 'gem'
Plugin 'osx'

