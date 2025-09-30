-- =========================
-- Basic Options
-- =========================

vim.g.mapleader = " "             -- Space as leader
vim.opt.clipboard = "unnamedplus" -- System clipboard
vim.opt.tabstop = 2               -- Tab = 2 spaces
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true         -- show absolute line number for current line
vim.opt.relativenumber = true -- show relative numbers for all other lines
vim.opt.ignorecase = true     -- ignore case when searching
vim.opt.smartcase = true      -- but be case-sensitive if uppercase is used

-- =========================
-- Bootstrap lazy.nvim
-- =========================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================
-- Plugins
-- =========================
-- Plugins are split into module files under lua/plugins
-- Each module returns a list or a single plugin spec.

require("lazy").setup({
  require("plugins.theme"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.lualine"),
  require("plugins.cmp"),
  require("plugins.lsp"),
  require("plugins.conform"),
  require("plugins.lazygit"),
  { "nvim-tree/nvim-web-devicons", lazy = true },
})

-- =========================
-- Keymaps
-- =========================

-- Telescope
local telescope = require("telescope.builtin")

-- Clean search (ignore junk, ignore .gitignore)
vim.keymap.set("n", "<leader>ff", function()
  telescope.find_files({
    no_ignore = true, -- don't respect .gitignore
    hidden = true,    -- include dotfiles
    file_ignore_patterns = { "node_modules", "%.git/", "dist", "build", "Pods", "ios/build", "android/.idea" },
  })
end, { desc = "Find files (ignore .gitignore, skip junk)" })

-- Raw search (include EVERYTHING)
vim.keymap.set("n", "<leader>fF", function()
  telescope.find_files({
    no_ignore = true,
    hidden = true,
  })
end, { desc = "Find ALL files (even node_modules)" })

-- Clean grep (ignore junk)
vim.keymap.set("n", "<leader>fg", function()
  telescope.live_grep({
    additional_args = function(_)
      return {
        "--no-ignore",
        "--hidden",
        "--glob=!node_modules/*",
        "--glob=!dist/*",
        "--glob=!.git/*",
        "--glob=!build/*",
      }
    end,
  })
end, { desc = "Live grep (ignore .gitignore, skip junk)" })

-- Raw grep (everything, even node_modules)
vim.keymap.set("n", "<leader>fG", function()
  telescope.live_grep({
    additional_args = function(_)
      return { "--no-ignore", "--hidden" }
    end,
  })
end, { desc = "Live grep ALL (even node_modules)" })

vim.keymap.set("n", "<leader>fb", function()
  require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h",         -- start in the current buffer's directory
    select_buffer = true,   -- open with buffer's path selected
    initial_mode = "normal" -- start in normal mode instead of insert
  })
end, { desc = "File browser in current buffer dir" })
