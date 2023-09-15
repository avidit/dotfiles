#!/usr/bin/env fish

# set EDITOR
set -x EDITOR vim

# set PATH
if test -L /usr/libexec/java_home
    set -x JAVA_HOME (/usr/libexec/java_home)
    set -x PATH $JAVA_HOME/bin $PATH
end

if test -L /usr/local/opt/groovy/libexec
    set -x GROOVY_HOME (/usr/local/opt/groovy/libexec)
    set -x PATH $GROOVY_HOME/bin $PATH
end

if type -q /usr/local/bin/npm
    set -x NODE_PATH (npm root --location=global)
    set -x PATH $NODE_PATH $PATH
end

if test -d /usr/local/opt/go
    set -x GOPATH $(go env GOPATH)
    set -x GOBIN $(go env GOPATH)/bin
    set -x PATH $GOBIN $PATH
end

test -d $HOME/bin ; and set -x PATH $HOME/bin $PATH

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# Load brew formula
set BREW_PREFIX (brew --prefix)
test -e {$BREW_PREFIX}/share/autojump/autojump.fish ; and source {$BREW_PREFIX}/share/autojump/autojump.fish
test -e {$BREW_PREFIX}/bin/direnv ; and direnv hook fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# aliases
alias c='clear'
