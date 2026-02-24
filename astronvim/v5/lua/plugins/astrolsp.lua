-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
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
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      pylsp = {
        plugins = {
          autopep8 = { enabled = false },
          flake8 = { enabled = true, maxLineLength = 100, ignore = { "E203", "F401", "F541", "F841" } },
          pylint = { args = { "--ignore=E231", "-" }, enabled = true, debounce = 200 },
          pycodestyle = {
            enabled = true,
            ignore = { "E231" },
            maxLineLength = 100,
          },
          pyflake = { enabled = false },
          mypy = { enabled = false },
          isort = { enabled = false },
          yapf = { enabled = false },
          preload = { enabled = false },
          rope_completion = { enabled = false },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh() end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        ["<Leader>l"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          nowait = true,
          desc = "Previous buffer",
        },
        ["<Leader>la"] = false,
        ["<Leader>lA"] = false,
        ["<Leader>ld"] = false,
        ["<Leader>lf"] = false,
        ["<Leader>lh"] = false,
        ["<Leader>li"] = false,
        ["<Leader>ll"] = false,
        ["<Leader>lL"] = false,
        ["<Leader>lI"] = false,
        ["<Leader>lR"] = false,
        ["<Leader>lr"] = false,
        ["<Leader>lG"] = false,
        ["<Leader>lD"] = false,
      },
      v = {
        ["<Leader>l"] = false,
        ["<Leader>lf"] = false,
        ["<Leader>la"] = false,
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      local capabilities = client.server_capabilities
      local map = vim.keymap.set

      map("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover symbol details", buffer = bufnr })
      map("n", "\\a", function() vim.lsp.buf.code_action() end, { desc = "LSP code action", buffer = bufnr })

      if capabilities.documentFormattingProvider then
        map("n", "\\f", function()
          vim.notify("Format code", "info", { title = "LSP" })
          vim.lsp.buf.format()
        end, { desc = "Format code", buffer = bufnr })
      end

      if capabilities.renameProvider then
        map("n", "\\r", function() vim.lsp.buf.rename() end, { desc = "Rename symbol", buffer = bufnr })
      end
    end,
  },
}
