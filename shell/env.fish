#!/usr/bin/env fish

# set PATH
if test -f /usr/libexec/java_home; set -x JAVA_HOME (/usr/libexec/java_home); end
set -x ANDROID_HOME $HOME/android
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go

set -x PATH $HOME/bin /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin /opt/X11/bin
set -x PATH $ANDROID_HOME/tools $ANDROID_HOME/build-tools $ANDROID_HOME/platform-tools $PATH
set -x PATH $GOROOT/bin $GOPATH/bin $PATH
set -x PATH $HOME/.rvm/bin $PATH

set -x EDITOR vim

# colorful man page
set -xU LESS_TERMCAP_mb (printf "\e[01;31m")      # begin blinking
set -xU LESS_TERMCAP_md (printf "\e[01;31m")      # begin bold
set -xU LESS_TERMCAP_me (printf "\e[0m")          # end mode
set -xU LESS_TERMCAP_se (printf "\e[0m")          # end standout-mode
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")   # begin standout-mode - info box
set -xU LESS_TERMCAP_ue (printf "\e[0m")          # end underline
set -xU LESS_TERMCAP_us (printf "\e[01;32m")      # begin underline