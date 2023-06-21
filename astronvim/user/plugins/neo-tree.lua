return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 30,
      mappings = {
        ["<space>"] = false, -- disable space until we figure out which-key disabling
        ["<leader>l"] = "prev_source",
        ["<leader>;"] = "next_source",
        o = "open",
        O = "system_open",
        C = "cut_to_clipboard",
        x = "close_node",
        h = "parent_or_close",
        l = "child_or_open",
        Y = "copy_selector",
        s = false,
      },
    },
  }

}
