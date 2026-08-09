#!/usr/bin/env bash

# shared environment (keep in sync with fish/config.fish)
test -f "$HOME/.config/shell/env.sh" && source "$HOME/.config/shell/env.sh"

# bash completion
test -f "$BREW_PREFIX/etc/profile.d/bash_completion.sh" && source "$BREW_PREFIX/etc/profile.d/bash_completion.sh"

# direnv
test -f "$BREW_PREFIX/bin/direnv" && eval "$(direnv hook bash)"

# starship
test -f "$BREW_PREFIX/bin/starship" && eval "$(starship init bash)"

# zoxide
test -f "$BREW_PREFIX/bin/zoxide" && eval "$(zoxide init bash)"

# load cargo env
test -f "$HOME/.cargo/env" && source "$HOME/.cargo/env"

# aliases
alias c='clear'
