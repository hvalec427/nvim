return {{
  "kkrampis/codex.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("codex").setup({
      defaults = {
        initial_mode = "insert",
      },
      keymaps = {
        close = "<Esc>",
      },
    })

    local api = vim.api
    pcall(api.nvim_del_user_command, "Codex")
    api.nvim_create_user_command("Codex", function()
      vim.cmd("CodexToggle")
      vim.cmd("startinsert")
    end, {})
  end,
}}
