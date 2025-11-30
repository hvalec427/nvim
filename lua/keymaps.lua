local telescope = require("telescope.builtin")
local keymap_list = require("keymap_list")
local map = vim.keymap.set
local M = {}

-- Telescope pickers
map("n", "<leader>ff", function()
  telescope.find_files({})
end, { desc = "[f]ind [f]iles (ignore .gitignore, skip junk)" })

map("n", "<leader>fF", function()
  telescope.find_files({
    no_ignore = true,
    hidden = true,
  })
end, { desc = "[f]ind [F]ILES (even node_modules)" })

map("n", "<leader>fg", function()
  telescope.live_grep({})
end, { desc = "[f]uzzy [g]rep (ignore .gitignore)" })

map("n", "<leader>fG", function()
  telescope.live_grep({
    additional_args = function(_)
      return { "--no-ignore", "--hidden" }
    end,
  })
end, { desc = "[f]uzzy [G]REP (hit ALL files)" })

-- git
map("n", "<leader>fs", function()
  telescope.git_status({
    initial_mode = "normal",
  })
end, { desc = "[f]ile [s]tatus (Git status picker)" })

-- LazyGit
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "[l]azy [g]it" })

-- lsp
map("n", "gi", vim.lsp.buf.type_definition, { desc = "[g]o to [i]mplementation" })
map("n", "gt", vim.lsp.buf.implementation, { desc = "[g]o to [t]ype definition" })
map("n", "gR", vim.lsp.buf.references, { desc = "LSP references (no Telescope)" })
map("n", "gr", function()
  require("telescope.builtin").lsp_references({
    initial_mode = "normal",
    include_current_file = true,
    include_declaration = false,
    show_line = true,
  })
end)

-- telescope browser
map("n", "<leader>fb", function()
  require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h",
    select_buffer = true,
    initial_mode = "normal",
  })
end, { desc = "[f]ile [b]rowser (buffer dir)" })

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "[e]xpand diagnostic message" })

map("n", "<leader>?", function()
  keymap_list.show()
end, { desc = "[?] show custom keymap list" })

function M.telescope_file_browser_mappings(fb_actions)
  return {
    ["n"] = {
      ["<leader>n"] = fb_actions.create,
      ["<leader>r"] = fb_actions.rename,
      ["<leader>d"] = fb_actions.remove,
      ["<leader>m"] = fb_actions.move,
    },
  }
end

return M
