return {
  "mg979/vim-visual-multi",
  event = "BufEnter",
  config = function()
    vim.g.VM_theme = "ocean"
    vim.g.VM_mouse_mapping = 1
    vim.g.VM_default_mappings = 0
    vim.g.VM_silent_exit = 1
    vim.g.VM_maps = {
      ["Exit"] = "<C-c>",
      ["Switch Mode"] = "v",
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Add Cursor Down"] = "<S-Down>",
      ["Add Cursor Up"] = "<S-Up>",
      ["Remove Region"] = "x",
      ["Skip Region"] = "<C-x>",
      ["Find Next"] = "]",
      ["Find Prev"] = "[",
      ["Goto Next"] = "}",
      ["Goto Prev"] = "{",
      ["Seek Next"] = "<C-f>",
      ["Seek Prev"] = "<C-b>",
      ["Undo"] = "u",
      ["Redo"] = "<C-r>",
      ["Add Cursor At Pos"] = "+",
      ["Visual Regex"] = "\\/",
      ["Visual All"] = "\\A",
      ["Visual Add"] = "\\a",
      ["Visual Find"] = "\\f",
      ["Visual Cursors"] = "\\c",
      ["Select All"] = "\\A",
      ["Start Regex Search"] = "\\/",
    }

    vim.g.VM_custom_remaps = {
      ["q"] = "<C-c>",
    }
  end,
}
