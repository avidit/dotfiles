# Dotfiles

My .dotfiles

I keep this repository in `$HOME/dotfiles`
and symlink the necessary config files from the repository into `$HOME`

e.g.

```sh
ln -s $HOME/dotfiles/bashrc .bashrc
```

## Index

* `bashrc` [bash](http://www.gnu.org/software/bash/) configuration file
* `brew.sh` [homebrew](https://brew.sh/) homebrew setup script
* `Brewfile` [homebrew](https://docs.brew.sh/Manpage#bundle-subcommand) bundle file
* `config.fish` [fish](https://fishshell.com/) configuration file
* `functions.ps1` [PowerShell](https://docs.microsoft.com/en-us/powershell/) functions
* `gitconfig` [git](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration) configuration file
* `gitignore_global` global [gitignore](https://git-scm.com/docs/gitignore) file
* `macos` Script for setting up a new mac by [Mathias Bynens](https://mths.be/macos)
* `profile.ps1` PowerShell profile [about_Profiles](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles)
* `setup.ps1` setup for windows
* `setup.sh` setup for mac
* `tmux.conf` [tmux](https://tmux.github.io) configuration file
* `vim.sh` vim plugins setup script
* `vimrc` [vim](https://vim.sourceforge.io/) vim configuration file
* `windows.ps1` Script for setting up a new windows by [jayharris](https://github.com/jayharris/dotfiles-windows)

---

* `setup` setup script

## Setup

* Clone repo

    ```sh
    cd $HOME
    git clone "https://github.com/avidit/dotfiles.git"
    ```

* Run the setup script

    ```sh
    cd $HOME/dotfiles
    ./setup.sh
    ```

    ```powershell
    cd $HOME\dotfiles
    .\setup.ps1
    ```

Or,

* backup existing files and folders

    ```sh
    mv "$HOME/$file" "$HOME/$file.bak"
    mv "$HOME/$folder" "$HOME/$folder.bak"
    ```

    ```powershell
    Rename-Item -Path "$HOME\$file" -NewName "$HOME\$file.bak"
    Rename-Item -Path "$HOME\$folder" -NewName "$HOME\$folder.bak"
    ```

* run desired script(s)

    ```sh
    sh "$HOME/dotfiles/brew.sh"
    ```

* create symlinks for required file(s) and folder(s)

    ```sh
    ln -s "$HOME/dotfiles/bashrc" "$HOME/.bashrc"
    ln -s "$HOME/dotfiles/config.fish" "$HOME/.config/fish/config.fish"
    ```

    ```powershell
    New-Item -ItemType SymbolicLink -Path $PROFILE.CurrentUserAllHosts -Target "$HOME\dotfiles\profile.ps1"
    ```
