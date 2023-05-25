local utils = require "astronvim.utils"
local is_available = utils.is_available

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
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
        enabled = false, -- enable or disable format on save globally
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
    on_attach = function (client, bufnr)
    end 
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
        return require 'session_manager.config'.dir_to_session_filename(dir)
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

    local map = vim.keymap.set
    map("n", "<leader>l", function() 
      require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
    end,
      {nowait = true, desc = "Previous buffer"}
    )
  end
}
