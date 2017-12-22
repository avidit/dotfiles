#!/usr/bin/env sh

# Create new folder in $HOME/.vim/pack
# create a start folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group language
#
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group/start"
  mkdir -p "$path"
  cd "$path" || exit
}

# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url=$1
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
}

(
set_group language
package https://github.com/scrooloose/syntastic.git &
package https://github.com/elzr/vim-json.git &
package https://github.com/tpope/vim-markdown.git &
wait
) &

(
set_group completion
package https://github.com/shougo/neocomplete.vim.git &
wait
) &

(
set_group colorschemes
package https://github.com/altercation/vim-colors-solarized.git &
wait
) &

(
set_group integrations
package https://github.com/tpope/vim-fugitive.git &
wait
) &

(
set_group interface
package https://github.com/vim-airline/vim-airline.git &
package https://github.com/vim-airline/vim-airline-themes.git &
wait
) &

(
set_group commands
package https://github.com/tpope/vim-surround.git &
wait
) &

(
set_group other
package https://github.com/tpope/vim-sensible.git &
package https://github.com/editorconfig/editorconfig-vim.git &
wait
) &

wait
