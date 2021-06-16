#!/usr/bin/env bash

# set Editor
export EDITOR=vim

# set PATH
export JAVA_HOME=$(/usr/libexec/java_home)
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export ANDROID_HOME=/usr/local/opt/android-sdk
export NODE_PATH=$(npm -g root)
export GOROOT=/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/go

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PATH:$NODE_PATH
export PATH=$PATH:$GOROOT
export PATH=$PATH:$(go env GOPATH)/bin

# load brew formula
[[ -f $(brew --prefix)/etc/profile.d/autojump.sh ]] && source $(brew --prefix)/etc/profile.d/autojump.sh
[[ -f $(brew --prefix)/etc/bash_completion ]] && source $(brew --prefix)/etc/bash_completion
[[ -f $(brew --prefix)/bin/direnv ]] && eval "$(direnv hook bash)"

# load fzf
[[ -f $HOME/.fzf.bash ]] && source $HOME/.fzf.bash

# aliases
alias c='clear'
