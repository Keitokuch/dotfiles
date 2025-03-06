return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  { 
    'lfv89/vim-interestingwords',
    event = "BufEnter"
  },
  {
    'phaazon/hop.nvim',
    branch = 'v1',
    event = "VimEnter",
    config = function()
      require('hop').setup({
        keys = 'asdfghjkl;wertyuiopcvnm',
        multi_windows = true
      })
    end,
  },
  {
    'tpope/vim-surround',
    lazy = false,
    config = function()
      vim.g.surround_no_insert_mappings = 1
    end
  },
  -- {
  --   'noib3/nvim-cokeline',
  --   after =  "nvim-web-devicons",
  --   config = function()
  --     require("user.plugins.cokeline")
  --   end
  -- },
}
