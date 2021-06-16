# set EDITOR
set -x EDITOR vim

# set PATH
set -x JAVA_HOME (/usr/libexec/java_home)
set -x GROOVY_HOME /usr/local/opt/groovy/libexec/
set -x ANDROID_HOME /usr/local/opt/android-sdk
set -x NODE_PATH (npm -g root)
set -x GOROOT /usr/local/opt/go/libexec/bin
set -x GOPATH $HOME/go

set -x PATH $HOME/bin $PATH
set -x PATH $JAVA_HOME/bin $PATH
set -x PATH $NODE_PATH $PATH
set -x PATH $GOROOT $PATH
set -x PATH (go env GOPATH)/bin $PATH

# Load brew formula
[ -f (brew --prefix)/share/autojump/autojump.fish ]; and source (brew --prefix)/share/autojump/autojump.fish
[ -f (brew --prefix)/bin/direnv ]; and eval (direnv hook fish)

# aliases
alias c='clear'
