return {
  {
    -- In tmux/wezterm AstroNvim loads this on VeryLazy for mux integration.
    -- Loading it on first split-navigation command keeps startup lighter while
    -- preserving the existing mappings, which require("smart-splits") on use.
    "mrjones2014/smart-splits.nvim",
    event = function() return {} end,
  },
  {
    "NMAC427/guess-indent.nvim",
    enabled = not vim.g.network_fs,
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = not vim.g.network_fs,
  },
  {
    "RRethy/vim-illuminate",
    enabled = not vim.g.network_fs,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    enabled = not vim.g.network_fs,
  },
}
