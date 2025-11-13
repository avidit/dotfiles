#!/usr/bin/env fish

# set EDITOR
set -x EDITOR vim

# set brew prefix
fish_add_path /opt/homebrew/bin
set -x BREW_PREFIX (brew --prefix)

# set PATH
set -x PATH $BREW_PREFIX/bin $PATH
set -x PATH $BREW_PREFIX/sbin $PATH

if test -L /Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home
    set -x JAVA_HOME "/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"
    set -x PATH $JAVA_HOME/bin $PATH
end

if test -L $BREW_PREFIX/opt/groovy/libexec
    set -x GROOVY_HOME ($BREW_PREFIX/opt/groovy/libexec)
    set -x PATH $GROOVY_HOME/bin $PATH
end

if type -q $BREW_PREFIX/bin/npm
    set -x NODE_PATH (npm root --location=global)
    set -x PATH $NODE_PATH $PATH
end

if test -d $BREW_PREFIX/bin/go
    set -x GOPATH $(go env GOPATH)
    set -x GOBIN $(go env GOPATH)/bin
    set -x PATH $GOBIN $PATH
end

set -x DOTNET_ROOT "$BREW_PREFIX/opt/dotnet/libexec"

test -d $HOME/bin ; and set -x PATH $HOME/bin $PATH

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# Load brew formula
test -e $BREW_PREFIX/share/autojump/autojump.fish ; and source $BREW_PREFIX/share/autojump/autojump.fish
test -e $BREW_PREFIX/bin/direnv ; and direnv hook fish | source

# iterm2 shell integration
test -e $HOME/.iterm2_shell_integration.fish ; and source $HOME/.iterm2_shell_integration.fish

# starship
starship init fish | source

# zoxide
zoxide init fish | source

# aliases
alias c='clear'
