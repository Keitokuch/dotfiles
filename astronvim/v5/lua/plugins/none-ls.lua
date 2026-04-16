-- Disable none-ls and mason-null-ls (not used, and mason-null-ls adds ~7s to startup)
---@type LazySpec
return {
  { "nvimtools/none-ls.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
}
