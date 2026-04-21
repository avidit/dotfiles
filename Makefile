ifeq ($(OS),Windows_NT)
  HOME := $(USERPROFILE)
endif

DOTFILES := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

STOW_FOLDERS := bash git tmux fish starship vim brewfile

.DEFAULT_GOAL := install-dotfiles

.PHONY: all install-dotfiles uninstall-dotfiles help \
        install-homebrew install-homebrew-packages \
        set-fish-as-default-shell install-fisher install-fish-plugins \
        install-winget-packages \
        install-powershell-modules install-powershell-profile

ifeq ($(OS),Windows_NT)
help: ## Show this help (Windows)
	@pwsh -Command "Select-String -Path '$(firstword $(MAKEFILE_LIST))' -Pattern '^[a-zA-Z_-]+:.*##' | ForEach-Object { if ($$_.Line -match '^([a-zA-Z_-]+):.*##(.*)$$') { '  {0,-30} {1}' -f $$Matches[1], $$Matches[2].Trim() } }"
else
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | \
	    awk 'BEGIN {FS = ":.*##"}; {printf "  %-30s %s\n", $$1, $$2}'
endif

# ── Full setup ───────────────────────────────────────────────────────────────

ifeq ($(OS),Windows_NT)
all: install-winget-packages install-powershell-modules install-dotfiles install-powershell-profile ## Full setup (Windows)
else
all: install-homebrew-packages set-fish-as-default-shell install-dotfiles ## Full setup
endif

# ── Dotfiles ─────────────────────────────────────────────────────────────────

ifeq ($(OS),Windows_NT)
install-dotfiles: ## Create symlinks with pwsh (Windows)
	@echo "==> Creating symlinks..."
	@pwsh -NoProfile -Command ". '$(DOTFILES)/powershell/functions.ps1'; Invoke-Elevated { \
	  New-Item -Force -ItemType Directory -Path '$(HOME)/.config' | Out-Null; \
	  $$links = @{ \
	    '$(HOME)/.gitconfig'            = '$(DOTFILES)/git/.gitconfig'; \
	    '$(HOME)/.gitignore_global'     = '$(DOTFILES)/git/.gitignore_global'; \
	    '$(HOME)/.config/starship.toml' = '$(DOTFILES)/starship/.config/starship.toml' \
	  }; \
	  $$links.GetEnumerator() | ForEach-Object { \
	    New-Item -ItemType SymbolicLink -Path $$_.Key -Target $$_.Value -Force \
	  } \
	}"
else
install-dotfiles: ## Create symlinks with stow
	@echo "==> Creating symlinks..."
	mkdir -p "$(HOME)/.config/fish"
	stow --target="$(HOME)" --dir="$(DOTFILES)" $(STOW_FOLDERS)
endif

ifeq ($(OS),Windows_NT)
uninstall-dotfiles: ## Remove all symlinks (Windows)
	@echo "==> Removing symlinks..."
	@pwsh -NoProfile -Command " \
	  '$(HOME)/.gitconfig', \
	  '$(HOME)/.gitignore_global', \
	  '$(HOME)/.config/starship.toml', \
	  '$$PROFILE.CurrentUserAllHosts' | ForEach-Object { \
	    if (Test-Path $$_) { Remove-Item $$_ -Force; Write-Host \"Removed $$_\" } \
	  }"
else
uninstall-dotfiles: ## Remove all symlinks
	@echo "==> Removing symlinks..."
	stow --delete --target="$(HOME)" --dir="$(DOTFILES)" $(STOW_FOLDERS)
endif

# ── macOS / Linux ────────────────────────────────────────────────────────────

install-homebrew: ## Install Homebrew
	@echo "==> Installing Homebrew..."
	@if [ "$$(command -v brew)" = "" ]; then \
	    /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; \
	    (echo; echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"') >> "$(HOME)/.zprofile"; \
	    eval "$$(/opt/homebrew/bin/brew shellenv)"; \
	else \
	    echo "Homebrew is already installed"; \
	fi

install-homebrew-packages: install-homebrew ## Install Homebrew bundle packages
	@echo "==> Installing Homebrew packages..."
	brew bundle install --file "$(DOTFILES)/brewfile/.config/brewfile/Brewfile"

set-fish-as-default-shell: ## Set fish as the default shell
	@echo "==> Setting fish as default shell..."
	@FISH=$$(command -v fish); \
	if [ -n "$$FISH" ] && ! grep -qF "$$FISH" /etc/shells; then \
	    echo "$$FISH" | sudo tee -a /etc/shells; \
	    chsh -s "$$FISH"; \
	elif [ "$$SHELL" = "$$FISH" ]; then \
	    echo "Fish is already the default shell"; \
	fi

install-fisher: ## Install the Fisher plugin manager for fish
	@echo "==> Installing Fisher..."
	@fish -c "if not functions -q fisher; \
	    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; \
	    and fisher install jorgebucaran/fisher; \
	end"

install-fish-plugins: install-fisher ## Install fish plugins from fish_plugins
	@echo "==> Installing fish plugins..."
	fish -c "fisher update"

# ── Windows ──────────────────────────────────────────────────────────────────

install-winget-packages: ## Install packages via winget
	@echo "==> Installing winget packages..."
	winget import --import-file "$(DOTFILES)/winget/packages.json"

install-powershell-modules: ## Install PowerShell modules (posh-git, PowerShellGet)
	@echo "==> Installing PowerShell modules..."
	@pwsh -NoProfile -Command ". '$(DOTFILES)/powershell/functions.ps1'; Invoke-Elevated { \
	  Install-PackageProvider NuGet -Force; \
	  Install-Module -Name PowerShellGet -Force; \
	  Set-PSRepository PSGallery -InstallationPolicy Trusted; \
	  Install-Module -Name posh-git -Scope CurrentUser \
	}"

install-powershell-profile: ## Symlink PowerShell profile (auto-elevates if needed)
	@echo "==> Linking PowerShell profile..."
	@pwsh -NoProfile -Command ". '$(DOTFILES)/powershell/functions.ps1'; Invoke-Elevated { \
	  New-Item -ItemType SymbolicLink \
	    -Path $$PROFILE.CurrentUserAllHosts \
	    -Target '$(DOTFILES)/powershell/profile.ps1' -Force \
	}"
