-- Add plugins, the packer syntax without the "use"
return {
  -- You can disable default plugins as follows:
  ["goolord/alpha-nvim"] = { disable = true },
  ["folke/which-key.nvim"] = { disable = true },
  ["akinsho/bufferline.nvim"] = { disable = true },
  -- ["neovim/nvim-lspconfig"] = { disable = true },
  ["Shatur/neovim-session-manager"] = {
    event = "VimEnter",
    config = function()
      require "configs.session_manager"
    end,
  },

  ["lewis6991/gitsigns.nvim"] = {
    tag = 'release',
    event = "VimEnter",
    config = function()
      require "configs.gitsigns"
    end,
  },

  -- Added plugins
  { 'lfv89/vim-interestingwords' },
  {
    'phaazon/hop.nvim',
    branch = 'v1',
    event = "VimEnter",
    config = function()
      require('hop').setup({
        keys = 'asdfghjkl;qwertyuiopcvnm'
      })
    end,
  },
  {
    'mg979/vim-visual-multi',
    setup = function()
      require('user.plugins.visual-multi')
    end
  },
  {
    'tpope/vim-surround',
    config = function()
      vim.g.surround_no_insert_mappings = 1
    end
  },
  {
    'noib3/nvim-cokeline',
    after = "nvim-web-devicons",
    config = function()
      require("user.plugins.cokeline")
    end
  },

  -- ColorSchemes
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require('user.plugins.nightfox')
    end,
  },

  {
    'projekt0n/github-nvim-theme',
    disable = true,
    config = function()
      require('github-theme').setup({
        comment_style = "italic",
      })
    end
  },
  {
    'folke/tokyonight.nvim',
    setup = function ()
      vim.g.tokyonight_style = "storm"
      vim.g.tokyonight_sidebars = { "neo-tree", "packer" }
    end
  },

  -- You can also add new plugins here as well:
  -- { "andweeb/presence.nvim" },
  -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "BufRead",
    --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- }
}
