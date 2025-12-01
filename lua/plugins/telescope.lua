return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope = require("telescope")
      local fb_actions = require("telescope").extensions.file_browser.actions
      local keymaps = require("keymaps")

      telescope.setup({
        extensions = {
          file_browser = {
            grouped = true,
            respect_gitignore = true,
            hidden = false,
            initial_mode = "normal",
            hijack_netrw = true,
            mappings = keymaps.telescope_file_browser_mappings(fb_actions),
          },
        },
      })

      telescope.load_extension("file_browser")
    end,
  },
}
