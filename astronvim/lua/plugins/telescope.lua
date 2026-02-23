local actions = require "telescope.actions"
local actions_layout = require "telescope.actions.layout"

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = { "<leader>f" }, -- Example: Map leader+f to Telescope
  opts = {
    defaults = {
      file_ignore_patterns = {
        -- Python venvs (common directory names)
        "/%.venv/",
        "/venv/",
        "/%.virtualenv/",
        "/virtualenv/",
        -- Catches any venv by internal structure (lib/python3.X/site-packages)
        "lib/python%d%.%d+/",
        "site%-packages/",
        -- Python build artifacts
        "__pycache__/",
        "%.pyc$",
        "%.egg%-info/",
        -- General
        "%.git/",
        "node_modules/",
      },
      layout_strategy = "horizontal", -- or "vertical"
      layout_config = {
        prompt_position = "top", -- Moves input box to the top
      },
      sorting_strategy = "ascending",
      prompt_prefix = "  ",
      dynamic_preview_title = true,
      results_title = false,
      preview = {
        check_mime_type = false,
        msg_bg_fillchar = " ",
      },
      mappings = {
        i = {
          -- ["<Tab>"] = { "<esc>", type = "command" },
          ["<Tab>"] = function(prompt_bufnr)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            actions.move_selection_next(prompt_bufnr)
          end,
          ["<S-Tab>"] = actions.move_selection_previous,
          ["<M-j>"] = actions.move_selection_next,
          ["<M-k>"] = actions.move_selection_previous,
          ["<esc>"] = actions.close,
          ["<C-f>"] = false,
          -- ["<C-c>"] = { "<esc>", type = "command" },
        },
        n = {
          -- ["<Tab>"] = { "i", type = "command" },
          ["<Tab>"] = actions.move_selection_next,
          ["<S-Tab>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["q"] = actions.close,
          ["p"] = actions_layout.toggle_preview,
          ["<Space>"] = actions_layout.toggle_preview,
        },
      },
    },
    pickers = {
      find_files = { hidden = true }, -- Show hidden files
      live_grep = { additional_args = { "--hidden" } }, -- Search hidden files
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
}
