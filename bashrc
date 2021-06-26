#!/usr/bin/env bash

# set Editor
export EDITOR=vim

# set PATH
if test -L /usr/libexec/java_home
then
    JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA_HOME
    export PATH=$PATH:$JAVA_HOME/bin
fi

if command -v /usr/local/bin/npm >/dev/null
then
    NODE_PATH=$(npm -g root)
    export NODE_PATH
    export PATH=$PATH:$NODE_PATH
fi

if test -d /usr/local/opt/go
then
    export GOROOT=/usr/local/opt/go/libexec/bin
    export PATH=$PATH:$GOROOT
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH
    GOBIN=$(go env GOPATH)/bin
    export GOBIN
    export PATH=$PATH:$GOBIN
fi

test -d "$HOME/bin" && export PATH=$PATH:$HOME/bin

# load brew formula
BREW_PREFIX=$(brew --prefix)
test -f "$BREW_PREFIX/etc/profile.d/autojump.sh" && source "$BREW_PREFIX/etc/profile.d/autojump.sh"
test -f "$BREW_PREFIX/etc/bash_completion" && source "$BREW_PREFIX/etc/bash_completion"
test -f "$BREW_PREFIX/bin/direnv" && eval "$(direnv hook bash)"

# load fzf
test -f "$HOME/.fzf.bash" && source "$HOME/.fzf.bash"

# aliases
alias c='clear'
