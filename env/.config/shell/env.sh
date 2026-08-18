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

# Resolve JAVA_HOME without calling java_home (it prints a macOS error when no JVM is installed)
java_home=""
for candidate in \
    "$BREW_PREFIX/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
do
    if test -d "$candidate"; then
        java_home="$candidate"
        break
    fi
done
if test -z "$java_home"; then
    for jvm in /Library/Java/JavaVirtualMachines/*/Contents/Home; do
        if test -d "$jvm"; then
            java_home="$jvm"
            break
        fi
    done
fi
if test -n "$java_home"; then
    export JAVA_HOME="$java_home"
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
