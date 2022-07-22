-- Add plugins, the packer syntax without the "use"
return {
  -- You can disable default plugins as follows:
  ["goolord/alpha-nvim"] = { disable = true },
  ["folke/which-key.nvim"] = { disable = true },
  ["akinsho/bufferline.nvim"] = { disable = true },
  ["nvim-neo-tree/neo-tree.nvim"] = { disable = not User.neo_tree },

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
  ["max397574/better-escape.nvim"] = {
    event = "BufEnter",
    config = function()
      require "configs.better_escape"
    end,
  },

  -- Added plugins
  {
    'kyazdani42/nvim-tree.lua',
    -- disable = not User.nvim_tree,
    tag = 'nightly',
    config = function ()
      require("user.plugins.nvim-tree")
    end
  },
  { 'lfv89/vim-interestingwords' },
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
    after =  "nvim-web-devicons",
    config = function()
      require("user.plugins.cokeline")
    end
  },
  {
    'ludovicchabant/vim-gutentags',
    config = function()
      require('user.plugins.gutentags')
    end
  },
  {
    'majutsushi/tagbar',
    cmd = { 'TagbarToggle', 'TagbarOpen', 'TagbarShowTag' },
    config = function ()
      require('user.plugins.tagbar')
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
