# Shell Setup Script

This script automates the setup of a modern shell environment with the following components:
- zsh (shell)
- starship (prompt)
- atuin (shell history)
- zinit (plugin manager)

## Prerequisites
- A Unix-like operating system (Linux/MacOS)
- curl installed
- git installed

## Installation

Download and run the setup script with these commands:

```bash
curl -O https://raw.githubusercontent.com/keksiqc/scripts/refs/heads/main/setup-shell.sh
chmod +x setup-shell.sh
./setup-shell.sh
```

The script will prompt you for your Atuin key at the start. After completion, log out and log back in for the changes to take effect fully.

## What gets installed
- zsh as the default shell
- starship prompt for a modern command line interface
- atuin for shell history management with search and sync capabilities
- zinit for plugin management
- Essential zsh plugins for autosuggestions, completions, and syntax highlighting
