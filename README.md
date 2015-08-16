Dotfiles
========
My .dotfiles

I keep this repository in `$HOME/dotfiles`
and symlink the necessary config files from the repository into `$HOME`

e.g
```bash
ln -s ~/dotfiles/shell/bashrc .bashrc
```

Many files included in this repository have their own copyright and license headers.
For everything else feel free to take whatever you think will be useful to you.

## Copying

Clone the repository and initiate all submodules.
This will add bash-it, oh-my-fish and oh-my-zsh as submodules.

```bash
git clone --recursive https://github.com/avidit/dotfiles ~/dotfiles
cd ~/dotfiles
git submodule update --init --recursive
```

But I recommend to clone the repository and
edit the `.gitmodules` according to your need. 
i.e. keep either of the three (bash-it, oh-my-fish and oh-my-zsh) 
as per the shell of your preference and `init` the submodules

## Index
* [_bash-it_] (https://github.com/revans/bash-it)
* [_oh-my-fish_] (https://github.com/oh-my-fish/oh-my-fish)
* [_oh-my-zsh_] (https://github.com/robbyrussell/oh-my-zsh)
	* _custom/plugins_
		* Recomended plugins:
		* [_k_](https://github.com/rimraf/k)
		* [_zsh_completions_] (https://github.com/zsh-users/zsh-completions)
		* [_zsh-autosuggestions_] (https://github.com/tarruda/zsh-autosuggestions)
		* [_zsh-syntax_highlighting_] (https://github.com/zsh-users/zsh-syntax-highlighting)
		* [_zsh-history-substring-search_] (https://github.com/zsh-users/zsh-history-substring-search)
* _shell_ - shell configuration files
	* `bashrc`        			[bash] (http://www.gnu.org/software/bash/) configuration file.
	* `config.fish`					[fish] (http://fishshell.com) configuration file
	* `zshrc`   	   				[zsh] (http://www.zsh.org) configuration file.
	* `aliases`							Shell aliases.
	* `functions`						Shell functions.
	* `env`									environment variables for bash and zsh shell.
	* `env.fish`						environment variables for fish shell.
	* `git-completion.bash`	bash/zsh completion support for core Git.
	* `git-prompt.bash`			bash/zsh git prompt support.
* _vim_
	* _bundle_
		* [Vundle.vim] (https://github.com/VundleVim/Vundle.vim)
		* Recommended plugins:
		* [nerdtree] (https://github.com/scrooloose/nerdtree)
		* [syntastic] (https://github.com/scrooloose/syntastic)
		* [vim-airline] (https://github.com/bling/vim-airline)
		* [vim-fugitive] (https://github.com/scrooloose/vim-fugitive)
* `osx`							Defaults for setting up a new mac by [Mathias Bynens] (https://mths.be/dotfiles).
* `irbrc`						irb configuration.
* `pryrc`						pry configuration.
* `tmux.conf`				tmux configuration.
* `vimrc`		    		vim configuration.
* `vimrc-sensible`  Defaults everyone can agree on by [Tim Pope](http://tpo.pe/).

--
* `setup.sh`				setup script (too lazy to update !!).
* `README.md`				This file.