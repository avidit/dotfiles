# Dotfiles

My .dotfiles

I keep this repository in `$HOME/dotfiles`
and symlink the necessary config files from the repository into `$HOME`

e.g.

```sh
ln -s $HOME/dotfiles/bashrc .bashrc
```

## Index

* `omf` [omf](https://github.com/oh-my-fish/oh-my-fish) config directory
* `bashrc` [bash](http://www.gnu.org/software/bash/) configuration file
* `brew.sh` [homebrew](https://brew.sh/) homebrew setup script
* `Brewfile` [homebrew](https://docs.brew.sh/Manpage#bundle-subcommand) bundle file
* `gitconfig` [git](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration) configuration file
* `gitignore_global` [gitignore](https://git-scm.com/docs/gitignore) global file
* `macos` Defaults for setting up a new mac by [Mathias Bynens](https://mths.be/macos)
* `profile.ps1` PowerShell profile [about_Profiles](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles)
* `tmux.conf` [tmux](https://tmux.github.io) configuration file
* `vim.sh` vim plugins setup script
* `vimrc` [vim](https://vim.sourceforge.io/) vim configuration file

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
    cd $HOME/dotfiles
    .\setup.ps1
    ```

Or,

* backup existing files and folders

    ```sh
    mv "$HOME/$file" "$HOME/$file.bak"
    mv "$HOME/$folder" "$HOME/$folder.bak"
    ```

    ```powershell
    Rename-Item -Path $PROFILE -NewName $($(Get-Item -Path $PROFILE) + '.bak')
    ```

* run desired script(s)

    ```sh
    sh "$HOME/dotfiles/brew.sh"
    ```

* create symlinks for required file(s) and folder(s)

    ```sh
    ln -s "$HOME/dotfiles/omf" "$HOME/.config/omf"
    ln -s "$HOME/dotfiles/bashrc" "$HOME/.bashrc"
    ```

    ```powershell
    New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$HOME\dotfiles\profile.ps1"
    ```
