-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  -- import/override with your plugins folder
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
