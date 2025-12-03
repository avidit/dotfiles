#!/usr/bin/env bash

# set Editor
export EDITOR=vim

# set brew prefix
export PATH=/opt/homebrew/bin:$PATH
BREW_PREFIX=$(brew --prefix)

# set PATH
export PATH=$BREW_PREFIX/bin:$PATH
export PATH=$BREW_PREFIX/sbin:$PATH

if test -f /usr/libexec/java_home
then
    JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA_HOME
    export PATH=$PATH:$JAVA_HOME/bin
fi

if test -d $BREW_PREFIX/opt/groovy/libexec
then
    GROOVY_HOME=$BREW_PREFIX/opt/groovy/libexec
    export GROOVY_HOME
    export PATH=$PATH:$GROOVY_HOME/bin
fi

if command -v $BREW_PREFIX/bin/npm >/dev/null
then
    NODE_PATH=$(npm root --location=global)
    export NODE_PATH
    export PATH=$PATH:$NODE_PATH
fi

if test -d $BREW_PREFIX/bin/go
then
    GOPATH=$(go env GOPATH)
    GOBIN=$(go env GOPATH)/bin
    export PATH=$PATH:$GOBIN
fi

export DOTNET_ROOT="$BREW_PREFIXopt/dotnet/libexec"

test -d "$HOME/bin" && export PATH=$PATH:$HOME/bin

# load brew formula
BREW_PREFIX=$(brew --prefix)
test -f "$BREW_PREFIX/etc/profile.d/bash_completion.sh" && source "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
test -f "$BREW_PREFIX/etc/profile.d/autojump.sh" && source "$BREW_PREFIX/etc/profile.d/autojump.sh"
test -f "$BREW_PREFIX/bin/direnv" && eval "$(direnv hook bash)"

# load fzf
test -f "$HOME/.fzf.bash" && source "$HOME/.fzf.bash"

# load cargo env
test -d "$HOME/.cargo/env" && source "$HOME/.cargo/env"

# iterm2 shell integration
test -f $HOME/.iterm2_shell_integration.bash && source $HOME/.iterm2_shell_integration.bash

# starship
eval "$(starship init bash)"

# zoxide
eval "$(zoxide init bash)"

# aliases
alias c='clear'
