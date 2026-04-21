# Dotfiles

My dotfiles, managed with [GNU Stow](http://www.gnu.org/software/stow/) on macOS/Linux and symlinks on Windows.

## macOS / Linux

### Packages

Managed with stow — each subdirectory mirrors the desired layout under `$HOME`.

| Package | Config |
| --- | --- |
| `bash/` | [bash](http://www.gnu.org/software/bash/) — `.bashrc` |
| `brewfile/` | [Homebrew bundle](https://docs.brew.sh/Manpage#bundle-subcommand) — `Brewfile` |
| `fish/` | [fish](https://fishshell.com/) — `config.fish`, `fish_plugins` |
| `git/` | [git](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration) — `.gitconfig`, `.gitignore_global` |
| `starship/` | [starship](https://starship.rs/) — `starship.toml` |
| `tmux/` | [tmux](https://tmux.github.io) — `.tmux.conf` |
| `vim/` | [vim](https://vim.sourceforge.io/) — `.vimrc` |

### macOS Setup

```sh
git clone "https://github.com/avidit/dotfiles.git"
cd dotfiles
make all
```

`make all` installs Homebrew packages, sets fish as the default shell, and creates all symlinks via stow.

Individual targets: `make install-homebrew-packages`, `make set-fish-as-default-shell`, `make install-dotfiles`, `make install-fisher`, `make install-fish-plugins`.

To remove all symlinks: `make uninstall-dotfiles`.

## Windows

### Configs

| File | Description |
| --- | --- |
| `git/.gitconfig` | Git config |
| `git/.gitignore_global` | Global gitignore |
| `starship/.config/starship.toml` | [starship](https://starship.rs/) prompt |
| `powershell/profile.ps1` | PowerShell profile |
| `powershell/functions.ps1` | PowerShell helper functions |
| `winget/packages.json` | Package list for winget |

### Windows Setup

Install [GNU Make](https://gnuwin32.sourceforge.net/packages/make.htm) first (one-time):

```powershell
winget install GnuWin32.Make
```

Then run:

```powershell
git clone "https://github.com/avidit/dotfiles.git"
cd dotfiles
make all
```

`make all` installs packages via winget, PowerShell modules, creates symlinks, and links the PowerShell profile.

Individual targets: `make install-winget-packages`, `make install-powershell-modules`, `make install-dotfiles`, `make install-powershell-profile`.

To remove all symlinks: `make uninstall-dotfiles`.

---

For macOS system defaults, see [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles/blob/main/.macos).
For Windows system defaults, see [jayharris/dotfiles-windows](https://github.com/jayharris/dotfiles-windows/blob/master/windows.ps1).
