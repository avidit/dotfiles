# Dotfiles

My dotfiles, managed with [GNU Stow](http://www.gnu.org/software/stow/) on macOS/Linux and symlinks on Windows.

## macOS / Linux

### Packages

Managed with stow — each subdirectory mirrors the desired layout under `$HOME`.

| Package | Config | Repo path | System path |
| --- | --- | --- | --- |
| `bash/` | [bash](http://www.gnu.org/software/bash/) | [`bash/.bashrc`](bash/.bashrc) | [`~/.bashrc`](bash/.bashrc) |
| `brewfile/` | [Homebrew bundle](https://docs.brew.sh/Manpage#bundle-subcommand) | [`brewfile/.config/brewfile/Brewfile`](brewfile/.config/brewfile/Brewfile) | [`~/.config/brewfile/Brewfile`](brewfile/.config/brewfile/Brewfile) |
| `env/` | Shared shell environment (sourced by bash and zsh) | [`env/.config/shell/env.sh`](env/.config/shell/env.sh) | [`~/.config/shell/env.sh`](env/.config/shell/env.sh) |
| `fish/` | [fish](https://fishshell.com/) | [`fish/.config/fish/config.fish`](fish/.config/fish/config.fish) | [`~/.config/fish/config.fish`](fish/.config/fish/config.fish) |
| `fish/` | [Fisher](https://github.com/jorgebucaran/fisher) plugins | [`fish/.config/fish/fish_plugins`](fish/.config/fish/fish_plugins) | [`~/.config/fish/fish_plugins`](fish/.config/fish/fish_plugins) |
| `ghostty/` | [Ghostty](https://ghostty.org/) | [`ghostty/.config/ghostty/config.ghostty`](ghostty/.config/ghostty/config.ghostty) | [`~/.config/ghostty/config.ghostty`](ghostty/.config/ghostty/config.ghostty) |
| `git/` | [git](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration) | [`git/.gitconfig`](git/.gitconfig) | [`~/.gitconfig`](git/.gitconfig) |
| `git/` | [gitignore](https://git-scm.com/docs/gitignore) (global) | [`git/.gitignore_global`](git/.gitignore_global) | [`~/.gitignore_global`](git/.gitignore_global) |
| `starship/` | [starship](https://starship.rs/) | [`starship/.config/starship.toml`](starship/.config/starship.toml) | [`~/.config/starship.toml`](starship/.config/starship.toml) |
| `tmux/` | [tmux](https://tmux.github.io) | [`tmux/.tmux.conf`](tmux/.tmux.conf) | [`~/.tmux.conf`](tmux/.tmux.conf) |
| `vim/` | [vim](https://vim.sourceforge.io/) | [`vim/.vimrc`](vim/.vimrc) | [`~/.vimrc`](vim/.vimrc) |
| `zsh/` | [zsh](https://www.zsh.org/) | [`zsh/.zshrc`](zsh/.zshrc) | [`~/.zshrc`](zsh/.zshrc) |

Repo path links open the file in this repository. System path links point to the same repo file because stow symlinks each target path to its source file here.

### macOS Setup

```sh
git clone "https://github.com/avidit/dotfiles.git"
cd dotfiles
make all
```

`make all` installs Homebrew packages, sets fish as the default shell, and creates all symlinks via stow.

Individual targets: `make install-homebrew-packages`, `make set-fish-as-default-shell`, `make install-dotfiles`, `make install-fisher`, `make install-fish-plugins`, `make install-powershell-profile`.

To remove all symlinks: `make uninstall-dotfiles`.

Optional: `make install-powershell-profile` links the PowerShell profile (see [PowerShell](#powershell) below). Not included in `make all`.

## PowerShell

Cross-platform [PowerShell 7](https://github.com/PowerShell/PowerShell) (`pwsh`) profile. Linked with `make install-powershell-profile` — not managed by stow.

| File | Description |
| --- | --- |
| [`powershell/profile.ps1`](powershell/profile.ps1) | Profile: [starship](https://starship.rs/), [zoxide](https://github.com/ajeetdsouza/zoxide), PSReadLine, helper functions |
| [`powershell/functions.ps1`](powershell/functions.ps1) | Helper functions (`..`, `touch`, `export`, `Invoke-Elevated`, etc.) |
| [`powershell/install-profile.ps1`](powershell/install-profile.ps1) | Install script (used by Makefile) |

| Platform | System paths |
| --- | --- |
| macOS / Linux | [`~/.config/powershell/profile.ps1`](powershell/profile.ps1), [`~/.config/powershell/functions.ps1`](powershell/functions.ps1) |
| Windows | `%USERPROFILE%\Documents\PowerShell\Profile.ps1`, `%USERPROFILE%\Documents\PowerShell\functions.ps1` |

Requires `pwsh`. Starship and zoxide are loaded when available (via Homebrew on macOS, winget on Windows).

```sh
make install-powershell-profile
```

On Windows, this is included in `make all`. On macOS / Linux, run it separately if you use `pwsh`.

## Windows

### Configs

| File | Description |
| --- | --- |
| `git/.gitconfig` | Git config |
| [`git/.gitignore_global`](git/.gitignore_global) | [gitignore](https://git-scm.com/docs/gitignore) (global, via `core.excludesFile`) |
| `starship/.config/starship.toml` | [starship](https://starship.rs/) prompt |
| `winget/packages.json` | Package list for winget |

PowerShell profile — see [PowerShell](#powershell) above.

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
