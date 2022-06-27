-- local M = { n = {}, v = {}, t = {}, i = {}, x = {}, o = {}, [""] = {} }
-- local map = function(mode, lfs, rhs, opts)
--   opts = opts or {}
--   opts[1] = rhs or "<Nop>"
--   if type(mode) == "table" then
--     for _, m in ipairs(mode) do
--       local opts_copy = {}
--       for k, v in pairs(opts) do
--         opts_copy[k] = v
--       end
--       M[m][lfs] = opts_copy
--     end
--   else
--     M[mode][lfs] = opts
--   end
-- end
--
-- local unmap = function(mode, lfs)
--   M[mode][lfs] = {"<Nop>"}
-- end

local map = vim.keymap.set
local unmap = function(mode, key) vim.keymap.set(mode, key, "<NOP>") end

User.fn.do_mappings = function ()
  local is_available = astronvim.is_available

  -- Remove bindings
  unmap("n", "s")
  unmap("n", "S")

  -- Set key bindings
  map("n", "<leader>s", ":w!<CR>", { desc = "Save", nowait = true })
  map("n", "<leader>q", ":qa<CR>", { desc = "Quit" })
  map("n", "<leader>Q", ":qa!<CR>", { desc = "Force Quit" })
  map("n", "<leader><C-w>", "<cmd>close<cr>", { desc = "Close window" })

  map({"n", "v"}, "<C-d>", "<Cmd>lua Scroll('15j', 0, 0)<CR>")
  map({"n", "v"}, "<C-i>", "<Cmd>lua Scroll('15k', 0, 0)<CR>")
  map({"n", "v"}, "<TAB>", "<Cmd>lua Scroll('15k', 0, 0)<CR>")

  map("n", "<C-p>", "<C-]>")
  map("n", "<C-u>", "<C-i>")
  map("n", "<C-y>", "<C-t>")

  map("i", "<C-f>", "<Right>")
  map("i", "<C-b>", "<Left>")
  map("i", "<C-p>", "<Up>", { remap = true })
  map("i", "<C-n>", "<Down>", { remap = true })
  map("i", "<C-e>", "<End>")
  map("i", "<C-a>", "<ESC>^i")

  map("n", "q", "<esc><cmd>noh<cr>")
  map("n", "<C-c>", "<esc><cmd>noh<cr>")
  map("v", "q", "<esc>")
  map("v", "<C-c>", "<esc>")

  -- Split windows
  map("n", "s_", "<cmd>new<cr>")
  map("n", "s|", "<cmd>vnew<cr>")
  map("n", "sl", "<C-w>l")
  map("n", "sh", "<C-w>h")
  map("n", "sk", "<C-w>k")
  map("n", "sj", "<C-w>j")
  map("n", "sp", "<C-w>p")

  -- Resize split windows
  if is_available "smart-splits.nvim" then
    map("n", "<M-Up>", require('smart-splits').resize_up)
    map("n", "<M-Down>", require('smart-splits').resize_down)
    map("n", "<M-Left>", require('smart-splits').resize_left)
    map("n", "<M-Right>", require('smart-splits').resize_right)
  else
    map("n", "<M-Up>", "<cmd>resize +5<CR>")
    map("n", "<M-Down>", "<cmd>resize -5<CR>")
    map("n", "<M-Left>", "<cmd>vertical resize -5<CR>")
    map("n", "<M-Right>", "<cmd>vertical resize +5<CR>")
  end

  if is_available "bufdelete.nvim" then
    map("n", "<leader>w", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
    map("n", "<leader>W", "<cmd>Bdelete!<cr>", { desc = "Close buffer" })
  else
    map("n", "<leader>w", "<cmd>bdelete<cr>", { desc = "Close buffer" })
    map("n", "<leader>W", "<cmd>bdelete!<cr>", { desc = "Close buffer" })
  end

  if is_available "neo-tree.nvim" then
    vim.api.nvim_create_user_command("ToggleTree", "Neotree action=show toggle=true", {})
    vim.api.nvim_create_user_command("ShowTree", "Neotree action=show", {})
    vim.api.nvim_create_user_command("FocusTree", "Neotree focus", {})
    vim.api.nvim_create_user_command("TreeFindFile", "Neotree focus reveal", {})
    map("n", "<leader>d", "<cmd>Neotree action=show toggle=true<cr>", { desc = "Toggle Explorer" })
    map("n", "sf", function()
      if (vim.bo.filetype == "neo-tree") then
        vim.cmd("wincmd p")
      else
        vim.cmd("Neotree focus")
      end
    end, { desc = "Toggle Explorer Focus" })
    map("n", "sF", function()
        vim.cmd("Neotree focus reveal")
    end, { desc = "Explorer Focus File" })
  end

  if is_available("nvim-tree.lua") then
    vim.api.nvim_create_user_command("ToggleTree", function() require"nvim-tree".toggle(false, true) end, {})
    vim.api.nvim_create_user_command("ShowTree", function() require"nvim-tree".toggle(false, true) end, {})
    vim.api.nvim_create_user_command("FocusTree", "NvimTreeFocus", { force = true })
    vim.api.nvim_create_user_command("TreeFindFile", "Neotree focus reveal", { force = true })
    map("n", "<leader>d", "<cmd>ToggleTree<cr>", { desc = "Toggle Explorer" })
    map("n", "sf", function()
      if (vim.bo.filetype == "NvimTree") then
        vim.cmd("wincmd p")
      else
        vim.cmd("NvimTreeFocus")
      end
    end, { desc = "Toggle Explorer Focus" })
    map("n", "sF", "<cmd>NvimTreeFindFile<cr>", { desc = "Explorer Focus File" })
  end

  if is_available("bufferline.nvim") then
    map("n", "<leader>l", "<cmd>BufferLineCyclePrev<cr>", { nowait = true, desc = "Previous tab" })
    map("n", "<leader>;", "<cmd>BufferLineCycleNext<cr>", { desc = "Next tab" })
    for i = 1,9 do
      map('n', ('<leader>%s'):format(i),  ('<cmd>(BufferLineGoToBuffer %s)'):format(i))
    end
  end

  if is_available("nvim-cokeline") then
    map("n", "<leader>l", "<Plug>(cokeline-focus-prev)", { nowait = true, desc = "Previous tab" })
    map("n", "<leader>;", "<Plug>(cokeline-focus-next)", { desc = "Next tab" })
    map("n", "<leader><", "<Plug>(cokeline-switch-prev)", { nowait = true, desc = "Previous tab" })
    map("n", "<leader>>", "<Plug>(cokeline-switch-next)", { desc = "Next tab" })
    for i = 1,9 do
      map('n', ('<leader>%s'):format(i),  ('<Plug>(cokeline-focus-%s)'):format(i),  { silent = true })
    end
  end

  if is_available("hop.nvim") then
    vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
    vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
    vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
    vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
    vim.api.nvim_set_keymap('x', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true})<cr>", {})
    vim.api.nvim_set_keymap('x', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true})<cr>", {})
    vim.api.nvim_set_keymap('n', ';', "<cmd> lua require'hop'.hint_char1({multi_windows=true})<cr>", {})
    vim.api.nvim_set_keymap('v', ';', "<cmd> lua require'hop'.hint_char1()<cr>", {})
    vim.api.nvim_set_keymap('o', ';', "<cmd> lua require'hop'.hint_char1({ inclusive_jump = true })<cr>", {})
  end

  if is_available("vim-interestingwords") then
    vim.api.nvim_set_keymap("", "<leader>i", "<Plug>InterestingWords", {})
    vim.api.nvim_set_keymap("", "<leader>h", "<Plug>InterestingWordsClear", {})
    vim.api.nvim_set_keymap("", "<leader>I", "<Plug>InterestingWordsClear", {})
    map("", "n", "<Plug>InterestingWordsForeward")
    map("", "N", "<Plug>InterestingWordsBackward")
  end

  if is_available "toggleterm.nvim" then
    map("n", "<C-t>", "<cmd>ToggleTerm direction=horizontal size=18<cr>", { desc = "Toggle terminal" })
    map("t", "<C-q>", "<cmd>wincmd p<cr>", { desc = "Focus terminal" })
    map("n", "<C-q>", function()
      local terms = require('toggleterm.terminal').get_all()
      for _, term in ipairs(terms) do
        if not term.hidden then
          local winnr = vim.fn.win_id2win(term.window)
          if winnr ~= 0 then
            vim.cmd(winnr..' wincmd w')
            vim.cmd("startinsert")
          else
            vim.cmd[[ToggleTerm]]
          end
        end
      end
    end)
  end

  if is_available "telescope.nvim" then
    map("n", "<leader>p", function ()
      require("telescope.builtin").buffers(
        require('telescope.themes').get_ivy
        {
          follow = true,
          preview = {
            hide_on_startup = true
          },
        }
      )
    end, { desc = "Search buffers", nowait = true } )
    map("n", "<leader>o", function()
      require("telescope.builtin").find_files({
        no_ignore = true,
        follow = true,
      })
    end, { desc = "Search files" })
    map("n", "<C-f>", function()
      require("telescope.builtin").live_grep({
        no_ignore = true,
        prompt_title = "Find String"
      })
    end, { desc = "Find String" })
    map("n", "?", function()
      local cword = vim.fn.expand("<cword>")
      require("telescope.builtin").help_tags({
        default_text = cword,
      })
    end, { desc = "Search Help" })
    map("n", "/", function ()
      require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_ivy
        {
          prompt_title = "Search String",
          preview_title = false,
          preview = {
            hide_on_startup = true,
            -- hide_on_startup = false,
          },
        }
      )
    end)
    map("n", "<leader>fn", function()
      require("telescope").extensions.notify.notify()
    end)
    map("n", "<leader>r", function()
      require("telescope.builtin").treesitter({
        prompt_title = "File Symbols",
        preview_title = false,
      })
    end)
    map("n", "\\d", function()
      require("telescope.builtin").diagnostics({ bufnr = 0 })
    end, { desc = "Search diagnostics" })
  end

  if is_available "Comment.nvim" then
    map("n", "<leader>cc", function()
      require('Comment.api').comment_current_linewise()
    end)
    map("v", "<leader>cc",
    "<esc><cmd>lua require('Comment.api').comment_linewise_op(vim.fn.visualmode())<cr>")
    map("n", "<leader>cu", function()
      require('Comment.api').uncomment_current_linewise()
    end)
    map("v", "<leader>cu",
    "<esc><cmd>lua require('Comment.api').uncomment_linewise_op(vim.fn.visualmode())<cr>")
  end

  if is_available "vim-surround" then
    map("n", "s", "<Plug>Ysurround")
    map("n", "S", "<Plug>YSurround")
    map("n", "ss", "<Plug>Yssurround")
    map("n", "Ss", "<Plug>YSsurround")
    map("n", "SS", "<Plug>YSsurround")
    map("x", "s", "<Plug>VSurround")
    map("x", "gs", "<Plug>VgSurround")
    map("x", "S", "<Plug>VgSurround")
  end
end

-- As a module overwrite default maps
return function (defaults)
  -- Unmap defaults
  defaults.n["<leader>c"] = nil
  defaults.n["<leader>ff"] = nil
  defaults.n["<leader>fw"] = nil
  defaults.n["<leader>fb"] = nil
  defaults.n["<leader>fo"] = nil
  return defaults
end
