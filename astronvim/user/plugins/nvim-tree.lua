require("nvim-tree").setup({
  view = {
    width = 26,
    adaptive_size = false,
    mappings = {
      custom_only = true,
      list = {
        { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
        { key = { "<BS>", "x" }, action = "close_node" },
        { key = "u", action = "dir_up" },
        { key = { "RightMouse", "C" }, action = "cd" },
        { key = "P", action = "parent_node" },
        { key = "<C-p>", action = "preview" },
        { key = "H", action = "toggle_dotfiles" },
        { key = "R", action = "refresh" },
        { key = "ma", action = "create" },
        { key = "md", action = "remove" },
        { key = "mD", action = "trash" },
        { key = "mr", action = "rename" },
        { key = "mx", action = "cut" },
        { key = "mc", action = "copy" },
        { key = "p", action = "paste" },
        { key = "y", action = "copy_path" },
        { key = "yy", action = "copy_absolute_path" },
        { key = "O", action = "system_open" },
        { key = "f", action = "live_filter" },
        { key = "F", action = "clear_live_filter" },
        { key = "q", action = "close" },
        { key = "X", action = "collapse_all" },
        { key = "S", action = "search_node" },
        { key = ".", action = "run_file_command" },
        { key = "K", action = "toggle_file_info" },
        { key = "?", action = "toggle_help" },
      },
    },
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "name",
    indent_markers = {
      enable = false,
    },
    icons = {
      git_placement = "after",
      show = {
        git = true,
        folder = false,
      }
    },
  },
  update_focused_file = {
    enable = true,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      }
    }
  },
  filters = {
    dotfiles = true,
  }
})
