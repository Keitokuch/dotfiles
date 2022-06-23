local M = {
  use_default_mappings = false,
  window = {
    mapping_options = {
      noremap = true,
      nowait = false,
    },
    mappings = {
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["S"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["x"] = "close_node",
      ["ma"] = {
        "add",
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none" -- "none", "relative", "absolute"
        }
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
      ["md"] = "delete",
      ["mr"] = "rename",
      ["mC"] = "copy_to_clipboard",
      ["mx"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["mc"] = {
        "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        config = {
          show_path = "none" -- "none", "relative", "absolute"
        }
      },
      ["mm"] = "move"
    }
  },
  filesystem = {
    follow_current_file = false,
    group_empty_dirs = true,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["u"] = "navigate_up",
        ["."] = "set_root",
        ["C"] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      }
    }
  }
}

return M
