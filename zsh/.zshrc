#!/usr/bin/env zsh

# shared environment (keep in sync with fish/config.fish)
[[ -f "$HOME/.config/shell/env.sh" ]] && source "$HOME/.config/shell/env.sh"

# completion
fpath=("$BREW_PREFIX/share/zsh/site-functions" $fpath)
autoload -Uz compinit
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# direnv
test -f "$BREW_PREFIX/bin/direnv" && eval "$(direnv hook zsh)"

# starship
test -f "$BREW_PREFIX/bin/starship" && eval "$(starship init zsh)"

# zoxide
test -f "$BREW_PREFIX/bin/zoxide" && eval "$(zoxide init zsh)"

# load cargo env
test -f "$HOME/.cargo/env" && source "$HOME/.cargo/env"

# aliases
alias c='clear'
