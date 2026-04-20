DOTFILES := $(HOME)/dotfiles

ifeq ($(OS),Windows_NT)
  HOME := $(USERPROFILE)
endif

STOW_FOLDERS := bash git tmux fish starship vim brewfile

.DEFAULT_GOAL := install-dotfiles

.PHONY: all install-dotfiles help \
        install-homebrew install-homebrew-packages \
        set-fish-as-default-shell install-fisher install-fish-plugins \
        install-winget-packages \
        install-powershell-modules install-powershell-profile

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | \
	    awk 'BEGIN {FS = ":.*##"}; {printf "  %-30s %s\n", $$1, $$2}'

# ── Full setup ────────────────────────────────────────────────────────────────

ifeq ($(OS),Windows_NT)
all: install-winget-packages install-powershell-modules install-dotfiles install-powershell-profile ## Full setup
else
all: install-homebrew-packages set-fish-as-default-shell install-dotfiles ## Full setup
endif

# ── Dotfiles ──────────────────────────────────────────────────────────────────

ifeq ($(OS),Windows_NT)
install-dotfiles: ## Create symlinks with pwsh
	pwsh -Command " \
	  New-Item -Force -ItemType Directory -Path $(HOME)/.config | Out-Null; \
	  $$links = @{ \
	    '$(HOME)/.gitconfig' = '$(DOTFILES)/git/.gitconfig'; \
	    '$(HOME)/.gitignore_global' = '$(DOTFILES)/git/.gitignore_global'; \
	    '$(HOME)/.config/starship.toml' = '$(DOTFILES)/starship/.config/starship.toml' \
	  }; \
	  $$links.GetEnumerator() | ForEach-Object { \
	    New-Item -ItemType SymbolicLink -Path $$_.Key -Target $$_.Value -Force \
	  }"
else
install-dotfiles: ## Create symlinks with stow
	mkdir -p "$(HOME)/.config/fish"
	stow --verbose --target="$(HOME)" --dir="$(DOTFILES)" $(STOW_FOLDERS)
endif

# ── macOS / Linux ─────────────────────────────────────────────────────────────

install-homebrew: ## Install Homebrew
	@if [ "$$(command -v brew)" = "" ]; then \
	    echo "installing homebrew"; \
	    /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; \
	    (echo; echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"') >> "$(HOME)/.zprofile"; \
	    eval "$$(/opt/homebrew/bin/brew shellenv)"; \
	else \
	    echo "homebrew is already installed"; \
	fi

install-homebrew-packages: install-homebrew ## Install Homebrew bundle packages
	brew bundle install --file "$(DOTFILES)/brewfile/.config/brewfile/Brewfile"

set-fish-as-default-shell: ## Set fish as the default shell
	@FISH=$$(command -v fish); \
	if [ -n "$$FISH" ] && ! grep -qF "$$FISH" /etc/shells; then \
	    echo "$$FISH" | sudo tee -a /etc/shells; \
	    chsh -s "$$FISH"; \
	fi

install-fisher: ## Install the Fisher plugin manager for fish
	@fish -c "if not functions -q fisher; \
	    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; \
	    and fisher install jorgebucaran/fisher; \
	end"

install-fish-plugins: install-fisher ## Install fish plugins from fish_plugins
	fish -c "fisher update"

# ── Windows ───────────────────────────────────────────────────────────────────

install-winget-packages: ## Install packages via winget
	winget import --import-file "$(DOTFILES)/winget/packages.json"

install-powershell-modules: ## Install PowerShell modules (posh-git, PowerShellGet)
	pwsh -Command " \
	  Install-PackageProvider NuGet -Force; \
	  Install-Module -Name PowerShellGet -Force; \
	  Set-PSRepository PSGallery -InstallationPolicy Trusted; \
	  Install-Module -Name posh-git -Scope CurrentUser"

install-powershell-profile: ## Symlink PowerShell profile
	pwsh -Command " \
	  New-Item -ItemType SymbolicLink \
	    -Path $$PROFILE.CurrentUserAllHosts \
	    -Target '$(DOTFILES)/powershell/profile.ps1' -Force"
