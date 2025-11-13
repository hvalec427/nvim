### Neovim Config

This repo contains my Neovim setup with a lean `init.lua` and a handy cheat‑sheet of the key motions and mappings I use most.

## Cheatsheet

Modal Navigation
- h left
- j down
- k up
- l right

- w next word
- b previous word
- e end of word

Insert Lines
- O new line above
- o new line below

Searching in file
- /query
- \c case insensitive
- \C case sensitive
- :%s@search@replace@gc

Selections
- v characterwise
- V linewise
- Ctrl+v blockwise

Copy / Cut / Paste
- y yank
- yy yank line

- d delete
- dd delete line

- P paste before
- p paste after

Swap Lines
- ddp swap with line below
- ddkP swap with line above

Undo / Redo
- u undo
- Ctrl+r redo

Comments
- gcc comment/uncomment
- gc in visual mode

Windows (Splits)
- Ctrl-W + c close window
- Ctrl-W + o close all other windows
- Ctrl-W + s split horizontal
- Ctrl-W + v split vertical
- Ctrl-W + w switch window (up or down)
- Ctrl-W + hjkl switch to left, down, up or right window

Telescope
- <leader>ff find files
- <leader>fg live grep
- <leader>fb file browser

Visual
- "gra" vim.lsp.buf.code_action()
- "an" and "in" outer and inner incremental selections

LSP
- grn Rename
- gra Code Action
- gri Go to Implementation
- grr References
- grt Type Definition
