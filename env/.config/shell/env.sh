# Shared environment for bash and zsh. Keep fish/config.fish in sync manually.

export EDITOR=vim

export PATH=/opt/homebrew/bin:$PATH
BREW_PREFIX=$(brew --prefix)
export BREW_PREFIX
export PATH=$BREW_PREFIX/bin:$PATH
export PATH=$BREW_PREFIX/sbin:$PATH

if test -d "$BREW_PREFIX/opt/node@22/bin"; then
    export PATH="$BREW_PREFIX/opt/node@22/bin:$PATH"
fi

if test -f /usr/libexec/java_home; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=$PATH:$JAVA_HOME/bin
fi

if test -d "$BREW_PREFIX/opt/groovy/libexec"; then
    export GROOVY_HOME=$BREW_PREFIX/opt/groovy/libexec
    export PATH=$PATH:$GROOVY_HOME/bin
fi

if test -f "$BREW_PREFIX/bin/go"; then
    export GOPATH=$(go env GOPATH)
    export GOBIN=$(go env GOPATH)/bin
    export PATH=$PATH:$GOBIN
fi

export DOTNET_ROOT="$BREW_PREFIX/opt/dotnet/libexec"

test -d "$HOME/bin" && export PATH=$PATH:$HOME/bin
export PATH=/usr/local/sbin:$PATH
