# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal dotfiles repository for configuring a macOS development environment, optimized for Go/Cloud/Kubernetes development with interactive command-line productivity tools so that it will be easier to setup new Mac machine.

## Installation Commands

The repository uses shell scripts for setup rather than traditional build tools:

```bash
# Install Homebrew packages (formulas and casks)
./script/install-homebrew.sh
./script/install-homebrew.sh --formula    # Development tools only
./script/install-homebrew.sh --cask       # Applications only

# Create symbolic links for config files
./script/install-config.sh

# Install Go development tools
./script/install-go.sh

# Install additional utilities
./script/install-else.sh
```

## Configuration Architecture

### Core Files
- **`config/zshrc`**: Main shell configuration that auto-loads all functions from `config/zsh/function/`
- **`config/gitconfig`**: Git configuration with GPG signing and SSH URL rewriting
- **`config/tmux.conf`**: Tmux with custom prefix (`Ctrl+T`) and vim-like navigation
- **`config/peco-config.json`**: Interactive filtering tool configuration

### Zsh Function System
All `.zsh` files in `config/zsh/function/` are automatically loaded. Key interactive functions:
- **Productivity**: `peco-select-command-history`, `peco-ghq-change-directory`, `peco-git-checkout-branch`
- **Kubernetes**: `peco-k8s-change-context`, `peco-k8s-change-namespace`, `peco-k8s-view-pod-logs`
- **Navigation**: `peco-cdr-change-directory`, `enter-list-files`

### Key Bindings (defined in zshrc)
- `Ctrl+R`: Command history search
- `Ctrl+J`: Repository directory change (ghq)
- `Ctrl+H`: Recent directory change
- `Ctrl+B`: Git branch checkout
- `Ctrl+X`: Kubernetes context switching
- `Ctrl+]`: Kubernetes namespace switching

## Development Workflow

### Testing Configuration Changes
```bash
sss  # Alias for 'source ~/.zshrc' - reload shell configuration
```

### Repository Management
Uses `ghq` for centralized repository cloning to `~/src/github.com/`. The `peco-ghq-change-directory` function provides quick navigation between projects.

### Editor Integration
- Primary editor: Cursor (aliases: `c`, `v`, `e`)
- Opens in reuse mode with `-r` flag

## Dependencies
- **Homebrew**: Package manager for all tools
- **Peco**: Interactive filtering tool (core dependency for most functions)
- **ghq**: Repository management tool
- **kubectl**: Kubernetes CLI (for k8s functions)

## Common Development Patterns

When adding new tool and package:
1. Create new a git branch 
2. Open install-homebrew.sh 
3. Edit the list of cask or formula (depending on availability) and inject the item 
4. Execut the script with the flag --cask or --formula depending on which you modify
5. If it's successfully installed, commit it and send pull request 

When adding new zsh functions:
1. Create `.zsh` file in `config/zsh/function/`
2. Follow naming pattern: `peco-*` for interactive functions
3. Use `peco --query "$LBUFFER"` for search integration
4. Add `print -s` for command history

When modifying configurations:
1. Edit files in `config/` directory (not the symlinked versions in `~`)
2. Test with `sss` alias to reload zsh configuration
3. Use `install-config.sh` to create/update symlinks