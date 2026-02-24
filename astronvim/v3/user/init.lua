local utils = require "astronvim.utils"
local is_available = utils.is_available

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  -- colorscheme = "astrodark",
  colorscheme = "catppuccin",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
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
    vim.api.nvim_create_augroup("user_start", { clear = true })
    vim.api.nvim_create_augroup("user_exit", { clear = true })
    local has_neotree = is_available("neo-tree.nvim")
    local has_nvimtree = is_available("nvim-tree.lua")
    -- Handle session save/load during startup
    if is_available "neovim-session-manager" then
      if has_neotree then
        vim.api.nvim_del_augroup_by_name("neotree_start")
      end
      local tree_show, tree_focus = nil, nil
      if has_neotree then
        tree_show = function()
          vim.cmd("Neotree show")
        end
        tree_focus = function()
          vim.cmd("Neotree focus")
        end
      elseif has_nvimtree then
        tree_show = function()
          require('nvim-tree.api').tree.toggle(false, true)
        end
        tree_focus = function()
          require('nvim-tree.api').tree.toggle(false, true)
        end
      end
      local session_get_f = function(dir)
        return require 'session_manager.config'.dir_to_session_filename(dir)
      end

      local dir_start = function()
        if vim.fn.argc() == 1 and not vim.g.started_with_stdin and vim.fn.isdirectory(vim.fn.argv()[1]) ~= 0 then
          -- Started with dir name
          vim.loop.chdir(vim.fn.argv()[1])
          vim.cmd [[%argd]]
          local cwd = vim.loop.cwd()
          local session_f = session_get_f(cwd)
          if session_f:exists() then
            require 'session_manager'.load_current_dir_session()
            print("Load session in", cwd)
            vim.defer_fn(tree_show, 30)
          else
            print("New session", cwd)
            require 'session_manager.utils'.is_session = true
            vim.cmd [[bd]]
            tree_focus()
          end
        elseif vim.fn.argc() == 0 then
          -- Started without argument
          local cwd = vim.loop.cwd()
          local session_f = session_get_f(cwd)
          if session_f:exists() then
            require 'session_manager'.load_current_dir_session()
            print("Load session", cwd)
            vim.defer_fn(function()
              -- Open tree when only a empty buffer is opened in session
              if #vim.api.nvim_list_bufs() == 1 and vim.api.nvim_buf_line_count(0) == 1 then
                tree_show()
              end
            end, 10)
          else
            -- Create new session for cwd during 0-arg start
            print("New session", cwd)
            require 'session_manager.utils'.is_session = true
            tree_focus()
          end
        end
      end

      vim.api.nvim_create_autocmd("VimEnter", {
        group = "user_start",
        callback = dir_start
      })
      vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
        group = "user_exit",
        callback = require 'session_manager'.autosave_session
      })
    end
  end
}
