local utils = require "astronvim.utils"
local is_available = utils.is_available
local map = vim.keymap.set

local function get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
maps = {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    -- unmap
    s = false,
    S = false,
    ["\\"] = false,
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    ["<leader>s"] = { ":w!<cr>", nowait = true, desc = "Save File" },
    -- quick quit
    ["<leader>q"] = { ":qa<cr>", desc = "Quit" },
    ["<leader>Q"] = { ":qa!<cr>", desc = "Force quit" },
    -- caret move
    ["<C-d>"] = { "15j" },
    ["<C-i>"] = { "15k" },
    ["<tab>"] = { "15k" },
    -- jump stack
    ["<C-p>"] = { "<C-]>" },
    ["<C-u>"] = { "<C-i>" },
    ["<C-y>"] = { "<C-t>" },
    -- split window
    ["s|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
    ["s_"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
    ["<leader><C-w>"] = { ":close<cr>", desc = "Close window" },
    -- jump window
    ["sp"] = { "<C-w>p", desc = "Previous window" }
  },
  v = {
    ["<C-d>"] = { "15j" },
    ["<C-i>"] = { "15k" },
    ["<tab>"] = { "15k" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  x = {
    ["<C-d>"] = { "15j" },
    ["<C-i>"] = { "15k" },
    ["<tab>"] = { "15k" },
  },
  i = {
    -- caret move
    ["<C-f>"] = { "<right>" },
    ["<C-b>"] = { "<left>" },
    ["<C-p>"] = { "<up>" },
    ["<C-n>"] = { "<down>" },
    ["<C-e>"] = { "<end>" },
    ["<C-a>"] = { "<esc>^i" },
  },
}

-- Control
maps.n["q"] = { "<esc><cmd>noh<cr>" }
maps.n["<C-c>"] = { "<esc><cmd>noh<cr>" }
maps.v["q"] = { "<esc>" }
maps.v["<C-c>"] = { "<esc>" }

-- Manage Buffers
maps.n["<leader>w"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" }
maps.n["<leader>W"] = { function() require("astronvim.utils.buffer").close(0, true) end, desc = "Force close buffer" }
maps.n["<leader>;"] =
{ function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" }
maps.n["<leader>l"] = {
  function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
  nowait = true,
  desc = "Previous buffer",
}
maps.n["<leader>>"] = {
  function() require("astronvim.utils.buffer").move(vim.v.count > 0 and vim.v.count or 1) end,
  desc = "Move buffer tab right",
}
maps.n["<leader><"] = {
  function() require("astronvim.utils.buffer").move(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Move buffer tab left",
}

-- Smart splits
if is_available "smart-splits.nvim" then
  maps.n["sh"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["sj"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["sk"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["sl"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  maps.n["sh"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["sj"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["sk"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["sl"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- NeoTree
if is_available "neo-tree.nvim" then
  maps.n["<leader>d"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer", nowait = true }
  maps.n["sf"] = {
    function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd "p"
      else
        vim.cmd.Neotree "focus"
      end
    end,
    desc = "Toggle Explorer Focus",
  }
end

if is_available("hop.nvim") then
  vim.api.nvim_set_keymap('n', 'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
    {})
  vim.api.nvim_set_keymap('n', 'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
    {})
  vim.api.nvim_set_keymap('o', 'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {})
  vim.api.nvim_set_keymap('o', 'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
    {})
  vim.api.nvim_set_keymap('x', 'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true})<cr>",
    {})
  vim.api.nvim_set_keymap('x', 'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true})<cr>",
    {})
  vim.api.nvim_set_keymap('n', ';', "<cmd> lua require'hop'.hint_char1({multi_windows=true})<cr>", {})
  vim.api.nvim_set_keymap('v', ';', "<cmd> lua require'hop'.hint_char1()<cr>", {})
  vim.api.nvim_set_keymap('o', ';', "<cmd> lua require'hop'.hint_char1({ inclusive_jump = true })<cr>", {})
end

if is_available "vim-surround" then
  maps.n["s"] = { "<Plug>VgSurround" }
  maps.n["S"] = { "<Plug>VgSurround" }
  maps.n["ss"] = { "<Plug>VgSurround" }
  maps.n["Ss"] = { "<Plug>VgSurround" }
  maps.n["SS"] = { "<Plug>VgSurround" }
  maps.x["s"] = { "<Plug>VgSurround" }
  maps.x["gs"] = { "<Plug>VgSurround" }
  maps.x["S"] = { "<Plug>VgSurround" }
end

if is_available "telescope.nvim" then
  maps.n["<leader>p"] = {
    function()
      require("telescope.builtin").buffers(
        require('telescope.themes').get_ivy
        {
          follow = true,
          preview = {
            hide_on_startup = true
          },
        }
      )
    end,
    silent = true,
    nowait = true,
    desc = "Search buffers"
  }
  maps.n["<leader>o"] = {
    function()
      require("telescope.builtin").find_files({
        no_ignore = true,
        follow = true,
      })
    end,
    desc = "Search files"
  }
  maps.n["<leader>j"] = {
    function()
      require("telescope.builtin").jumplist({
        initial_mode = 'normal',
        fname_width = 80
      })
    end,
    desc = "Jumplist"
  }
  maps.n["<C-f>"] = {
    function()
      require("telescope.builtin").live_grep({
        no_ignore = true,
        prompt_title = "Find String"
      })
    end,
    desc = "Find String"
  }
  maps.v["<C-f>"] = {
    function()
      local text = get_visual_selection()
      require("telescope.builtin").live_grep({
        no_ignore = true,
        prompt_title = "Find String",
        default_text = text
      })
    end,
    desc = "Find String"
  }
  maps.n["?"] = {
    function()
      local cword = vim.fn.expand("<cword>")
      require("telescope.builtin").help_tags({
        default_text = cword,
      })
    end,
    desc = "Search Help"
  }
  maps.n["/"] = { function()
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
  end }
  maps.n["<leader>fn"] = { function()
    require("telescope").extensions.notify.notify()
  end }
  maps.n["<leader>r"] = { function()
    require("telescope.builtin").treesitter({
      prompt_title = "File Symbols",
      preview_title = false,
    })
  end }
  maps.n["\\d"] = {
    function()
      require("telescope.builtin").diagnostics({
        bufnr = 0,
        initial_mode = 'normal'
      })
    end,
    desc = "Search diagnostics"
  }
  maps.n["gr"] = {
    function()
      require("telescope.builtin").lsp_references({
        include_declaration = false,
        include_current_line = false,
        initial_mode = 'normal'
      })
    end,
    desc = "References of current symbol"
  }
  maps.n["gd"] = {
    function()
      require("telescope.builtin").lsp_definitions()
    end,
    desc = "Show the definition of current symbol"
  }
  maps.n["<leader>lD"] = false
  maps.n["<leader>ls"] = false
  maps.n["\\s"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbols",
  }
end

-- Plugin Manager
maps.n["<leader>P"] = false
maps.n["<leader>Pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
maps.n["<leader>Ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
maps.n["<leader>PS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
maps.n["<leader>Pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
maps.n["<leader>PU"] = { function() require("lazy").update() end, desc = "Plugins Update" }

-- AstroNvim
maps.n["<leader>Pa"] = { "<cmd>AstroUpdatePackages<cr>", desc = "Update Plugins and Mason" }
maps.n["<leader>PA"] = { "<cmd>AstroUpdate<cr>", desc = "AstroNvim Update" }
maps.n["<leader>Pv"] = { "<cmd>AstroVersion<cr>", desc = "AstroNvim Version" }
maps.n["<leader>Pl"] = { "<cmd>AstroChangelog<cr>", desc = "AstroNvim Changelog" }

maps.n["<leader>pi"] = false
maps.n["<leader>ps"] = false
maps.n["<leader>pS"] = false
maps.n["<leader>pu"] = false
maps.n["<leader>pU"] = false
maps.n["<leader>pa"] = false
maps.n["<leader>pA"] = false
maps.n["<leader>pv"] = false
maps.n["<leader>pl"] = false
maps.n["<leader>pm"] = false
maps.n["<leader>pM"] = false

-- SymbolsOutline
if is_available "aerial.nvim" then
  maps.n["<leader>lS"] = false
end

return maps
