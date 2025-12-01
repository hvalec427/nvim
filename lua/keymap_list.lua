local M = {}

local entries = {
  { plugin = "Telescope",     mode = "n",   keys = "<leader>fF",            desc = "[f]uzzy [F]IND (even node_modules)" },
  { plugin = "Telescope",     mode = "n",   keys = "<leader>fG",            desc = "[f]uzzy [G]REP (hit ALL files)" },
  { plugin = "Git",           mode = "n",   keys = "<leader>fs",            desc = "[f]ile [s]tatus (Git status picker)" },
  { plugin = "Git",           mode = "n",   keys = "<leader>gD",            desc = "Diff working directory" },
  { plugin = "Git",           mode = "n",   keys = "<leader>gd",            desc = "Diff current file vs last commit" },
  { plugin = "Git",           mode = "n",   keys = "<leader>gh",            desc = "File history (current file)" },
  { plugin = "Git",           mode = "n",   keys = "<leader>gq",            desc = "Close diff (Diffview or Gitsigns)" },
  { plugin = "LSP",           mode = "n",   keys = "grn",                   desc = "Rename symbol" },
  { plugin = "LSP",           mode = "n/v", keys = "gra",                   desc = "Code action" },
  { plugin = "LSP",           mode = "n",   keys = "grr",                   desc = "References (Telescope)" },
  { plugin = "LSP",           mode = "n",   keys = "grR",                   desc = "References (no Telescope)" },
  { plugin = "LSP",           mode = "n",   keys = "gri",                   desc = "Go to implementation" },
  { plugin = "LSP",           mode = "n",   keys = "grt",                   desc = "Go to type definition" },
  { plugin = "Diagnostics",   mode = "n",   keys = "<leader>e",             desc = "[e]xpand diagnostic message" },
  { plugin = "Keymap Helper", mode = "n",   keys = "<leader>?",             desc = "[?] show custom keymap list" },
  { plugin = "Word Motions",  mode = "n",   keys = "w",                     desc = "[w] next word" },
  { plugin = "Word Motions",  mode = "n",   keys = "b",                     desc = "[b] previous word" },
  { plugin = "Word Motions",  mode = "n",   keys = "e",                     desc = "[e] end of word" },
  { plugin = "Searching",     mode = "n",   keys = "/query",                desc = "Search forward using /query" },
  { plugin = "Searching",     mode = "n",   keys = [=[/\cquery]=],          desc = "Search forward (append \\c for case-insensitive)" },
  { plugin = "Searching",     mode = "n",   keys = [=[/\Cquery]=],          desc = "Search forward (append \\C for case-sensitive)" },
  { plugin = "Searching",     mode = "n",   keys = ":%s@search@replace@gc", desc = ":%s@search@replace@gc replace with confirm" },
  { plugin = "Selections",    mode = "n",   keys = "v",                     desc = "Characterwise select" },
  { plugin = "Selections",    mode = "n",   keys = "V",                     desc = "Linewise select" },
  { plugin = "Selections",    mode = "n",   keys = "<C-v>",                 desc = "Blockwise select" },
  { plugin = "Text Objects",  mode = "n",   keys = "ci( / ca(",             desc = "Change inside/around parentheses" },
  { plugin = "Motions",       mode = "n",   keys = "f<char>",               desc = "Jump to next occurrence of character" },
  { plugin = "Motions",       mode = "n",   keys = "f( + ci(",              desc = "Skip to next ( and edit its contents" },
  { plugin = "Windows",       mode = "n",   keys = "<C-w> c",               desc = "[w]indow [c]lose" },
  { plugin = "Windows",       mode = "n",   keys = "<C-w> o",               desc = "[w]indow close [o]ther" },
  { plugin = "Windows",       mode = "n",   keys = "<C-w> s",               desc = "[w]indow [s]plit horizontal" },
  { plugin = "Windows",       mode = "n",   keys = "<C-w> v",               desc = "[w]inwod [v]ertical" },
  { plugin = "Windows",       mode = "n",   keys = "<C-w> w",               desc = "[w]indow cycle [w]indows" },
  { plugin = "Windows",       mode = "n",   keys = "<C-w> h/j/k/l",         desc = "Move focus" },
}

local function format_lines(entries)
  if #entries == 0 then
    return { "No keymaps match your search" }
  end

  local lines = {}
  local table_header = string.format("%-8s %-18s %-38s", "Mode", "Keys", "Description")
  local separator = string.rep("-", #table_header)
  table.insert(lines, table_header)
  table.insert(lines, separator)
  local current_plugin = nil

  for _, entry in ipairs(entries) do
    if entry.plugin ~= current_plugin then
      if current_plugin ~= nil then
        table.insert(lines, "")
      end
      table.insert(lines, string.format("[%s]", entry.plugin))
      current_plugin = entry.plugin
    end

    local desc = entry.desc ~= "" and entry.desc or "(no description)"
    table.insert(lines, string.format("%-8s %-18s %-38s", entry.mode, entry.keys, desc))
  end

  return lines
end

local function normalize_text(text)
  local lower = text:lower()
  lower = lower:gsub("%[(.-)%]", "%1")
  lower = lower:gsub("[%[%]]", "")
  return lower
end

local function filter_entries(query)
  if not query or query == "" then
    return entries
  end

  local lower_query = query:lower()
  local filtered = {}
  for _, entry in ipairs(entries) do
    if entry.mode:lower():find(lower_query, 1, true)
        or entry.keys:lower():find(lower_query, 1, true)
        or normalize_text(entry.desc):find(lower_query, 1, true)
        or entry.plugin:lower():find(lower_query, 1, true) then
      table.insert(filtered, entry)
    end
  end
  return filtered
end

function M.show()
  local initial_lines = format_lines(entries)

  local width = 0
  for _, line in ipairs(initial_lines) do
    width = math.max(width, #line)
  end

  local popup_width = math.min(width + 2, math.max(40, math.floor(vim.o.columns * 0.9)))
  local popup_height = math.min(#initial_lines + 2, math.max(10, math.floor(vim.o.lines * 0.9)))

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, initial_lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = popup_width,
    height = popup_height,
    row = math.floor((vim.o.lines - popup_height) / 2),
    col = math.floor((vim.o.columns - popup_width) / 2),
    style = "minimal",
    border = "rounded",
  })

  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, silent = true })

  vim.keymap.set("n", "<Esc>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, silent = true })

  local function update_view(data)
    local new_lines = format_lines(data)
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
  end

  vim.keymap.set("n", "/", function()
    local query = vim.fn.input("Search keymaps: ")
    if query == nil then
      return
    end
    local filtered = filter_entries(query)
    update_view(filtered)
  end, { buffer = buf, nowait = true, silent = true })

  vim.api.nvim_win_set_option(win, "cursorline", false)
  vim.api.nvim_win_set_option(win, "wrap", false)
end

pcall(vim.api.nvim_del_user_command, "CustomKeymaps")
vim.api.nvim_create_user_command("CustomKeymaps", function()
  M.show()
end, {})

return M
