return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({ defaults = {} })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope = require("telescope")
      local fb_actions = require("telescope").extensions.file_browser.actions

      telescope.setup({
        extensions = {
          file_browser = {
            mappings = {
              ["n"] = {
                -- Normal mode
                ["<leader>n"] = fb_actions.create,
                ["<leader>r"] = fb_actions.rename,
                ["<leader>d"] = fb_actions.remove,
                ["<leader>m"] = fb_actions.move,
              },
            },
          },
        },
      })

      telescope.load_extension("file_browser")
    end,
  },
}
