local function get_visual_selection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})
  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<M-j>"] = { "list_down", mode = { "i", "n" } },
            ["<M-k>"] = { "list_up", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["p"] = "toggle_preview",
            ["<Space>"] = "toggle_preview",
          },
        },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    -- Smart / general
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>N", function() Snacks.picker.notifications { focus = "list" } end, desc = "Notification History" },
    -- File picker
    {
      "<leader>o",
      function() Snacks.picker.files { hidden = false, follow = true } end,
      desc = "Find Files",
    },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end, desc = "Find Config File" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- Buffer picker (ivy layout, no preview)
    {
      "<leader>p",
      function() Snacks.picker.buffers { layout = { preset = "ivy" }, preview = false } end,
      desc = "Buffers",
      silent = true,
      nowait = true,
    },
    -- Grep (global)
    { "<C-f>", function() Snacks.picker.grep { hidden = true } end, desc = "Grep", mode = "n" },
    {
      "<C-f>",
      function() Snacks.picker.grep { hidden = true, search = get_visual_selection() } end,
      desc = "Grep",
      mode = "v",
    },
    -- In-buffer search (ivy layout, no preview)
    {
      "/",
      function() Snacks.picker.lines { layout = { preset = "ivy" }, preview = false } end,
      desc = "Search in Buffer",
    },
    {
      "?",
      function() Snacks.picker.lines { layout = { preset = "ivy" }, preview = false } end,
      desc = "Search in Buffer",
      mode = "n",
    },
    -- Jump list
    { "<leader>j", function() Snacks.picker.jumps() end, desc = "Jumplist" },
    -- Symbols
    { "<leader>r", function() Snacks.picker.treesitter() end, desc = "File Symbols" },
    { "\\s", function() Snacks.picker.lsp_symbols() end, desc = "Search Symbols" },
    -- Diagnostics (current buffer)
    { "\\d", function() Snacks.picker.diagnostics_buffer { focus = "list" } end, desc = "Buffer Diagnostics" },
    -- LSP
    { "gr", function() Snacks.picker.lsp_references() end, desc = "References" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
    -- Help (visual mode - search word under cursor)
    { "?", function() Snacks.picker.help { search = vim.fn.expand "<cword>" } end, desc = "Search Help", mode = "v" },
    -- Git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
  },
}
