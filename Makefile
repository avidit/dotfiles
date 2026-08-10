ifeq ($(OS),Windows_NT)
  HOME := $(USERPROFILE)
endif

DOTFILES := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

STOW_FOLDERS := bash env git tmux fish starship vim brewfile zsh ghostty

.DEFAULT_GOAL := help

.PHONY: all install-dotfiles uninstall-dotfiles help \
        install-homebrew install-homebrew-packages \
        set-fish-as-default-shell install-fisher install-fish-plugins \
        install-winget-packages \
        install-powershell-modules install-powershell-profile

ifeq ($(OS),Windows_NT)
help: ## Show available targets
	@pwsh -NoProfile -Command "Write-Host 'Dotfiles — Windows'; Write-Host ''; Write-Host 'Usage: make [target]'; Write-Host ''; Write-Host 'Targets:'; Write-Host '  help                         Show this help'; Write-Host '  all                          Full setup'; Write-Host '  install-dotfiles             Create config symlinks'; Write-Host '  uninstall-dotfiles           Remove config symlinks'; Write-Host '  install-winget-packages      Install packages via winget'; Write-Host '  install-powershell-modules   Install PowerShell modules'; Write-Host '  install-powershell-profile   Link PowerShell profile'"
else
help: ## Show available targets
	@echo "Dotfiles — macOS / Linux"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help                         Show this help"
	@echo "  all                          Full setup"
	@echo "  install-dotfiles             Create symlinks with stow"
	@echo "  uninstall-dotfiles           Remove symlinks"
	@echo "  install-homebrew             Install Homebrew"
	@echo "  install-homebrew-packages    Install Homebrew bundle packages"
	@echo "  set-fish-as-default-shell    Set fish as the default shell"
	@echo "  install-fisher               Install Fisher plugin manager"
	@echo "  install-fish-plugins         Install fish plugins"
	@echo "  install-powershell-profile   Link PowerShell profile"
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
	@pwsh -NoProfile -Command ". '$(DOTFILES)/powershell/functions.ps1'; \
	  New-Item -Force -ItemType Directory -Path '$(HOME)/.config' | Out-Null; \
	  Install-DotfileLink -Path '$(HOME)/.gitconfig' -Target '$(DOTFILES)/git/.gitconfig'; \
	  Install-DotfileLink -Path '$(HOME)/.gitignore_global' -Target '$(DOTFILES)/git/.gitignore_global'; \
	  Install-DotfileLink -Path '$(HOME)/.config/starship.toml' -Target '$(DOTFILES)/starship/.config/starship.toml' \
	"
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

install-powershell-profile: ## Symlink PowerShell profile
	@echo "==> Linking PowerShell profile..."
	@pwsh -NoProfile -File "$(DOTFILES)/powershell/install-profile.ps1"

# ── Windows ──────────────────────────────────────────────────────────────────

install-winget-packages: ## Install packages via winget
	@echo "==> Installing winget packages..."
	winget import --import-file "$(DOTFILES)/winget/packages.json"

install-powershell-modules: ## Install PowerShell modules (PowerShellGet)
	@echo "==> Installing PowerShell modules..."
	@pwsh -NoProfile -Command " \
	  Install-PackageProvider NuGet -Force; \
	  Install-Module -Name PowerShellGet -Force; \
	  Set-PSRepository PSGallery -InstallationPolicy Trusted \
	"
