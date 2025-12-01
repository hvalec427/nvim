# Neovim Config

Personal, Lua-first Neovim configuration that keeps my editing environment identical on every machine. It sets sensible defaults (indentation, search, numbers, clipboard), applies a small set of opinionated keymaps, and wires up the tooling I rely on for coding, writing, and navigating large repositories.

## Project Layout
- `init.lua` is the single entry point. It sets options, defines autocommands, bootstraps all external packages, and then loads the Lua modules that actually power the editor.
- `lua/` contains those modules, grouped by concern (UI polish, completion, diagnostics, formatting, navigation helpers, etc.). Editing or adding modules here is the normal way to extend the setup.
- `lazy-lock.json` pins the versions of every downloaded dependency so all machines stay in sync.

## Requirements
- Neovim 0.9 or newer.

## Installation
1. Clone this repo to `~/.config/nvim`: `git clone <repo-url> ~/.config/nvim`.
2. Start Neovim. The first run installs every required dependency automatically; let it finish and restart once if prompted.
3. To update later, pull the latest changes in this directory and restart Neovim.

