-- Centralized keymaps for core UX and plugin integrations.
local telescope = require("telescope.builtin")
local map = vim.keymap.set
local M = {}

-- Telescope pickers
map("n", "<leader>ff", function()
  telescope.find_files({})
end, { desc = "Find files (ignore .gitignore, skip junk)" })

map("n", "<leader>fF", function()
  telescope.find_files({
    no_ignore = true,
    hidden = true,
  })
end, { desc = "Find ALL files (even node_modules)" })

map("n", "<leader>fg", function()
  telescope.live_grep({})
end, { desc = "Live grep (ignore .gitignore, skip junk)" })

map("n", "<leader>fG", function()
  telescope.live_grep({
    additional_args = function(_)
      return { "--no-ignore", "--hidden" }
    end,
  })
end, { desc = "Live grep ALL (even node_modules)" })

-- git
map("n", "<leader>fs", function()
  telescope.git_status({
    initial_mode = "normal",
  })
end, { desc = "Git status (normal mode)" })

-- LazyGit
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- lsp
map("n", "gi", vim.lsp.buf.type_definition, { desc = "[g]o to [i]mplementation" })
map("n", "gt", vim.lsp.buf.implementation, { desc = "[g]o to [t]ype definition" })
map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "[g]o to [r]eferences" })

-- telescope browser
map("n", "<leader>fb", function()
  require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h",
    select_buffer = true,
    initial_mode = "normal",
  })
end, { desc = "File browser in current buffer dir" })

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

-- other
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "[E]xpand diagnostic message" })

return M
