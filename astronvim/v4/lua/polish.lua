-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

local utils = require "astrocore"
local is_available = utils.is_available

vim.api.nvim_create_augroup("user_start", { clear = true })

if is_available "hop.nvim" then
  vim.api.nvim_set_keymap(
    "n",
    "f",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "n",
    "F",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "o",
    "f",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "o",
    "F",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "x",
    "f",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true})<cr>",
    {}
  )
  vim.api.nvim_set_keymap(
    "x",
    "F",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true})<cr>",
    {}
  )
  vim.api.nvim_set_keymap("n", ";", "<cmd> lua require'hop'.hint_char1({multi_windows=true})<cr>", {})
  vim.api.nvim_set_keymap("v", ";", "<cmd> lua require'hop'.hint_char1()<cr>", {})
  vim.api.nvim_set_keymap("o", ";", "<cmd> lua require'hop'.hint_char1({ inclusive_jump = true })<cr>", {})
end

vim.api.nvim_set_keymap("v", "q", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "q", "<Esc>", { noremap = true, silent = true })
