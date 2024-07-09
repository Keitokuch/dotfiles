local lsp_mappings = {
  n = {
    ["<leader>l"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      nowait = true,
      desc = "Previous buffer",
    },
    ["<leader>la"] = false,
    ["<leader>ld"] = false,
    ["<leader>lf"] = false,
    ["<leader>lh"] = false,
    ["<leader>li"] = false,
    ["<leader>ll"] = false,
    ["<leader>lL"] = false,
    ["<leader>lI"] = false,
    ["<leader>lR"] = false,
    ["<leader>lr"] = false,
    ["<leader>lG"] = false,
    ["<leader>lD"] = false,
  },
  v = {
    ["<leader>l"] = false,
    ["<leader>lf"] = false,
    ["<leader>la"] = false,
  }
}

return lsp_mappings
