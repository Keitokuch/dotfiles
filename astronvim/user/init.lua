User = {
  fn = {}
}

require'user.mappings'
require'user.autocmds'

local map = vim.keymap.set

local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  -- colorscheme = "nordfox",
  -- colorscheme = "dawnfox",
  colorscheme = "default_theme",
  -- colorscheme = "tokyonight",
  -- colorscheme = "nightfox",

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      timeoutlen = 500, -- Length of time to wait for a mapped sequence
      wrap = true, -- Disable wrapping of lines longer than the width of window
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    -- Modify the highlight groups
    highlights = function(highlights)
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.white, bg = C.bg }
      highlights.TabLineFill = { fg = C.grey_3, bg = C.black }
      highlights.TabLine = { fg = C.grey, bg = C.grey_3 }
      highlights.VertSplit = { fg = C.grey_1, bg = C.bg }
      return highlights
    end,
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.rufo,
        -- Set a linter
        null_ls.builtins.diagnostics.rubocop,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = { "lua" },
    },
    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    },
    cinnamon = {
      default_keymaps = false
    },
    ["better_escape"] = {
      mapping = {"jj"}, -- a table with mappings to use
      clear_empty_lines = true,
    },
    toggleterm = {
      open_mapping = [[<c-t>]],
    },
    ["gitsigns"] = {
      attach_to_untracked = false,
    }
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- which-key registration table for normal mode, leader prefix
          -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
          ["\\"] = { name = "LSP" }
        },
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without lsp-installer
    servers = {
      -- "pyright"
    },
    -- add to the server on_attach function
    on_attach = function(client, bufnr)
      map("n", "K", function()
        vim.lsp.buf.hover()
      end, { desc = "Hover symbol details", buffer = bufnr })
      map("n", "\\a", function()
        vim.lsp.buf.code_action()
      end, { desc = "LSP code action", buffer = bufnr })
      map("n", "\\f", function()
        vim.lsp.buf.formatting_sync()
      end, { desc = "Format code", buffer = bufnr })
      map("n", "\\h", function()
        vim.lsp.buf.signature_help()
      end, { desc = "Signature help", buffer = bufnr })
      map("n", "\\rn", function()
        vim.lsp.buf.rename()
      end, { desc = "Rename current symbol", buffer = bufnr })
      map("n", "gD", function()
        vim.lsp.buf.declaration()
      end, { desc = "Declaration of current symbol", buffer = bufnr })
      map("n", "gI", function()
        vim.lsp.buf.implementation()
      end, { desc = "Implementation of current symbol", buffer = bufnr })
      map("n", "gd", function()
        vim.lsp.buf.definition()
      end, { desc = "Show the definition of current symbol", buffer = bufnr })
      map("n", "gr", function()
        vim.lsp.buf.references()
      end, { desc = "References of current symbol", buffer = bufnr })
      map("n", "\\d", function()
        vim.diagnostic.open_float()
      end, { desc = "Hover diagnostics", buffer = bufnr })
      map("n", "[d", function()
        vim.diagnostic.goto_prev()
      end, { desc = "Previous diagnostic", buffer = bufnr })
      map("n", "]d", function()
        vim.diagnostic.goto_next()
      end, { desc = "Next diagnostic", buffer = bufnr })
      map("n", "gl", function()
        vim.diagnostic.open_float()
      end, { desc = "Hover diagnostics", buffer = bufnr })
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        vim.lsp.buf.formatting()
      end, { desc = "Format file with LSP" })
    end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    mappings = function(_)
      return {}
    end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    local is_available = astronvim.is_available
    User.fn.do_mappings()
    User.fn.do_autocmds()

    -- Disable intro screen
    vim.cmd("set shortmess+=I")

    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = { "plugins.lua" },
      command = "source <afile> | PackerSync",
    })

    vim.api.nvim_create_augroup("session_start", { clear = true })
    -- Dir start
    if is_available "neovim-session-manager" then
      vim.api.nvim_del_augroup_by_name("neotree_start")
      local dir_start = function()
        if vim.fn.argc() == 1 and not vim.g.started_with_stdin and vim.fn.isdirectory(vim.v.argv[2]) then
          vim.loop.chdir(vim.v.argv[2])
          vim.cmd[[%argd]]
          local session_utils = require('session_manager.utils')
          local cwd = vim.loop.cwd()
          local session_f = session_utils.dir_to_session_filename(cwd)
          if session_f:exists() then
            require'session_manager'.load_current_dir_session()
            vim.defer_fn(function()
              vim.cmd[[Neotree show]]
            end, 10)
          else
            -- require("neo-tree.setup.netrw").hijack()
            vim.cmd[[bd]]
            vim.cmd[[Neotree focus]]
          end
        end
      end
      vim.api.nvim_create_autocmd("VimEnter", {
        group = "session_start",
        callback = dir_start
      })
    end


    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
