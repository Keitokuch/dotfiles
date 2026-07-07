-- AstroCommunity imports load before local specs in `plugins/`.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
      compile = true,
    },
  },
}
