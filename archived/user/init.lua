User = {
  fn = {},
  vars = {}
}

local ok, msg = pcall(require, "user.setup")
if not ok then
  print("Failed in user setup:", msg)
end

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
      scrolloff=20
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
      ["neo-tree"] = false,
      notify = true,
      ["nvim-tree"] = true,
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
      -- config.on_attach = function(client)
      --   -- NOTE: You can remove this on attach function to disable format on save
      --   if client.resolved_capabilities.document_formatting then
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       desc = "Auto format before save",
      --       pattern = "<buffer>",
      --       callback = vim.lsp.buf.formatting_sync,
      --     })
      --   end
      -- end
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
      display = {
        non_interactive = false,
      }
    },
    cinnamon = {
      default_keymaps = false,
      centered = false,
      horizontal_scroll = false,
      default_delay = 5
    },
    ["better_escape"] = {
      mapping = { "jj" }, -- a table with mappings to use
      clear_empty_lines = true,
    },
    toggleterm = {
      open_mapping = [[<c-t>]],
      direction = "horizontal",
    },
    ["gitsigns"] = {
      attach_to_untracked = false,
    },
    notify = {
      stages = "fade",
      timeout = 1000,
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

  lsp = {
    -- enable servers that already installed without lsp-installer
    servers = {
      -- "pyright"
    },
    -- add to the server on_attach function

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    mappings = function(_)
      return {}
    end,

  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    require 'user.mappings'
    require 'user.autocmds'

    local is_available = astronvim.is_available
    User.fn.do_mappings()

    -- Disable intro screen
    vim.cmd("set shortmess+=I")

    -- Set autocommands
    User.fn.do_autocmds()

    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = { "plugins.lua" },
      command = "source <afile> | PackerSync",
    })

    vim.api.nvim_create_augroup("user_start", { clear = true })
    vim.api.nvim_create_augroup("user_exit", { clear = true })
    local has_neotree = is_available("neo-tree")
    local has_nvimtree = is_available("nvim-tree.lua")
    -- Handle session save/load during startup
    if is_available "neovim-session-manager" then
      if has_neotree then
        vim.api.nvim_del_augroup_by_name("neotree_start")
      end
      local tree_show, tree_focus = "", ""
      tree_show = has_neotree and "Neotree show" or tree_show
      tree_focus = has_neotree and "Neotree focus" or tree_focus
      tree_show = has_nvimtree and "NvimTreeOpen" or tree_show
      tree_focus = has_neotree and "NvimTreeFocus" or tree_focus
      local session_get_f = function(dir)
        return require 'session_manager.utils'.dir_to_session_filename(dir)
      end

      local dir_start = function()
        if vim.fn.argc() == 1 and not vim.g.started_with_stdin and vim.fn.isdirectory(vim.v.argv[2]) ~= 0 then
          -- Started with dir name
          vim.loop.chdir(vim.v.argv[2])
          vim.cmd [[%argd]]
          local cwd = vim.loop.cwd()
          local session_f = session_get_f(cwd)
          print(cwd)
          if session_f:exists() then
            require 'session_manager'.load_current_dir_session()
            vim.defer_fn(function()
              vim.cmd("ShowTree")
            end, 30)
          else
            -- require("neo-tree.setup.netrw").hijack()
            require 'session_manager.utils'.is_session = true
            vim.cmd [[bd]]
            vim.cmd("FocusTree")
          end
        elseif vim.fn.argc() == 0 then
          -- Started without argument
          local cwd = vim.loop.cwd()
          local session_f = session_get_f(cwd)
          if session_f:exists() then
            require 'session_manager'.load_current_dir_session()
            vim.defer_fn(function()
              -- Open tree when only a empty buffer is opened in session
              if #vim.api.nvim_list_bufs() == 1 and vim.api.nvim_buf_line_count(0) == 1 then
                vim.cmd("FocusTree")
              end
            end, 10)
          else
            -- Create new session for cwd during 0-arg start
            print("New:", cwd)
            require 'session_manager.utils'.is_session = true
            vim.cmd("FocusTree")
          end
        end
      end

      vim.api.nvim_create_autocmd("VimEnter", {
        group = "user_start",
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
