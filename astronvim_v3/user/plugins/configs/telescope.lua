local actions = require "telescope.actions"
local actions_layout = require "telescope.actions.layout"
return {
  defaults = {
    prompt_prefix = "  ",
    dynamic_preview_title = true,
    results_title = false,
    preview = {
      check_mime_type = false,
      msg_bg_fillchar = ' '
    },
    mappings = {
      i = {
        ["<Tab>"] = { "<esc>", type = "command" },
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<M-j>"] = actions.move_selection_next,
        ["<M-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close
      },
      n = {
        ["<Tab>"] = { "i", type = "command" },
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["p"] = actions_layout.toggle_preview,
        ["<Space>"] = actions_layout.toggle_preview,
      }
    }
  }
}
