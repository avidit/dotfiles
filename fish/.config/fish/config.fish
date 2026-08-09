#!/usr/bin/env fish

# shared environment (keep in sync with .config/shell/env.sh)

# set EDITOR
set -x EDITOR vim

# set brew prefix
fish_add_path /opt/homebrew/bin
set -x BREW_PREFIX (brew --prefix)

# set PATH
set -x PATH $BREW_PREFIX/bin $PATH
set -x PATH $BREW_PREFIX/sbin $PATH

if test -d $BREW_PREFIX/opt/node@22/bin
    fish_add_path $BREW_PREFIX/opt/node@22/bin
end

if test -f /usr/libexec/java_home
    set -x JAVA_HOME (/usr/libexec/java_home)
    set -x PATH $JAVA_HOME/bin $PATH
end

if test -d $BREW_PREFIX/opt/groovy/libexec
    set -x GROOVY_HOME $BREW_PREFIX/opt/groovy/libexec
    set -x PATH $GROOVY_HOME/bin $PATH
end

if test -f $BREW_PREFIX/bin/go
    set -x GOPATH (go env GOPATH)
    set -x GOBIN (go env GOPATH)/bin
    set -x PATH $GOBIN $PATH
end

set -x DOTNET_ROOT "$BREW_PREFIX/opt/dotnet/libexec"

test -d $HOME/bin ; and set -x PATH $HOME/bin $PATH

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# direnv
test -e $BREW_PREFIX/bin/direnv ; and direnv hook fish | source

# starship
test -e $BREW_PREFIX/bin/starship ; and starship init fish | source

# zoxide
test -e $BREW_PREFIX/bin/zoxide ; and zoxide init fish | source

# aliases
alias c='clear'
