-- Required and used from plugins/astrocore.lua

local function get_visual_selection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

maps = {
	-- first key is the mode
	n = {
		-- second key is the lefthand side of the map
		-- mappings seen under group name "Buffer"
		s = false,
		S = false,
		["\\"] = false,
		-- tables with the `name` key will be registered with which-key if it's installed
		-- this is useful for naming menus
		["<Leader>b"] = { name = "Buffers" },
		-- quick save
		["<Leader>s"] = { ":w!<cr>", nowait = true, desc = "Save File" }, -- change description but the same command
		-- quick quit
		["<Leader>q"] = { ":qa<cr>", desc = "Quit" },                   -- change description but the same command
		["<Leader>Q"] = { ":qa!<cr>", desc = "Force quit" },            -- change description but the same command
		-- caret move
		["<C-d>"] = { "15j" },
		["<C-i>"] = { "15k" },
		["<Tab>"] = { "15k" },
		-- split window
		["s|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
		["s_"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
		["<Leader><C-w>"] = { ":close<cr>", desc = "Close window" }, -- change description but the same command
		["sp"] = { "<C-w>p", desc = "Previous window" },

		-- NeoTree
		["<Leader>d"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer", nowait = true },
		["sf"] = {
			function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd("p")
				else
					vim.cmd.Neotree("focus")
				end
			end,
			desc = "Toggle Explorer Focus",
		},

		["st"] = {
			function()
				require("aerial").open({ focus = true })
			end,
			desc = "Switch to Symbol Tree",
		},
		["ss"] = {
			function()
				require("aerial").toggle({ focus = false })
			end,
		},

		-- Smart Split
		["sh"] = {
			function()
				require("smart-splits").move_cursor_left()
			end,
			desc = "Move to left split",
		},
		["sj"] = {
			function()
				require("smart-splits").move_cursor_down()
			end,
			desc = "Move to below split",
		},
		["sk"] = {
			function()
				require("smart-splits").move_cursor_up()
			end,
			desc = "Move to above split",
		},
		["sl"] = {
			function()
				require("smart-splits").move_cursor_right()
			end,
			desc = "Move to right split",
		},
		["<C-Up>"] = {
			function()
				require("smart-splits").resize_up()
			end,
			desc = "Resize split up",
		},
		["<C-Down>"] = {
			function()
				require("smart-splits").resize_down()
			end,
			desc = "Resize split down",
		},
		["<C-Left>"] = {
			function()
				require("smart-splits").resize_left()
			end,
			desc = "Resize split left",
		},
		["<C-Right>"] = {
			function()
				require("smart-splits").resize_right()
			end,
			desc = "Resize split right",
		},

		["q"] = { "<esc><cmd>noh<cr>" },
		["<C-c>"] = { "<esc><cmd>noh<cr>" },
	},
	v = {
		["<C-d>"] = { "15j" },
		["<C-i>"] = { "15k" },
		["<Tab>"] = { "15k" },
		["q"] = { "<esc>" },
		["<C-c>"] = { "<esc>" },
	},
	t = {
		-- setting a mapping to false will disable it
		-- ["<esc>"] = false,
	},
	x = {
		--
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

	-- tables with just a `desc` key will be registered with which-key if it's installed
	-- this is useful for naming menus
	-- ["<Leader>b"] = { desc = "Buffers" },

	-- setting a mapping to false will disable it
	-- ["<C-S>"] = false,
}

maps.n["<Leader>p"] = {
	function()
		require("telescope.builtin").buffers(require("telescope.themes").get_ivy({
			follow = true,
			preview = {
				hide_on_startup = true,
			},
		}))
	end,
	silent = true,
	nowait = true,
	desc = "Search buffers",
}
maps.n["<Leader>o"] = {
	function()
		require("telescope.builtin").find_files({
			no_ignore = true,
			follow = true,
		})
	end,
	desc = "Search files",
}
maps.n["<Leader>j"] = {
	function()
		require("telescope.builtin").jumplist({
			initial_mode = "normal",
			fname_width = 80,
		})
	end,
	desc = "Jumplist",
}
maps.n["<C-f>"] = {
	function()
		require("telescope.builtin").live_grep({
			no_ignore = true,
			prompt_title = "Find String",
		})
	end,
	desc = "Find String",
}
maps.v["<C-f>"] = {
	function()
		local text = get_visual_selection()
		require("telescope.builtin").live_grep({
			no_ignore = true,
			prompt_title = "Find String",
			default_text = text,
		})
	end,
	desc = "Find String",
}
maps.v["?"] = {
	function()
		local cword = vim.fn.expand("<cword>")
		require("telescope.builtin").help_tags({
			default_text = cword,
		})
	end,
	desc = "Search Help",
}
maps.n["/"] = {
	function()
		require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy({
			prompt_title = "Search String",
			preview_title = false,
			preview = {
				hide_on_startup = true,
				-- hide_on_startup = false,
			},
		}))
	end,
}
maps.n["?"] = { "/" }
maps.n["<Leader>fn"] = {
	function()
		require("telescope").extensions.notify.notify()
	end,
}
maps.n["<Leader>r"] = {
	function()
		require("telescope.builtin").treesitter({
			prompt_title = "File Symbols",
			preview_title = false,
		})
	end,
}
maps.n["\\d"] = {
	function()
		require("telescope.builtin").diagnostics({
			bufnr = 0,
			initial_mode = "normal",
		})
	end,
	desc = "Search diagnostics",
}
maps.n["gr"] = {
	function()
		require("telescope.builtin").lsp_references({
			include_declaration = false,
			include_current_line = false,
			initial_mode = "normal",
		})
	end,
	desc = "References of current symbol",
}
maps.n["gd"] = {
	function()
		require("telescope.builtin").lsp_definitions()
	end,
	desc = "Show the definition of current symbol",
}
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

-- Control
maps.n["q"] = { "<esc><cmd>noh<cr>" }
maps.n["<C-c>"] = { "<esc><cmd>noh<cr>" }
maps.v["q"] = { "<esc>" }
maps.v["<C-c>"] = { "<esc>" }

-- Manage Buffers
local buffer = astrobuffer
maps.n["<Leader>w"] = {
	function()
		buffer.close()
	end,
	desc = "Close buffer",
}
maps.n["<Leader>W"] = {
	function()
		buffer.close(0, true)
	end,
	desc = "Force close buffer",
}
maps.n["<Leader>;"] = {
	function()
		buffer.nav(vim.v.count > 0 and vim.v.count or 1)
	end,
	desc = "Next buffer",
}
maps.n["<Leader>l"] = {
	function()
		buffer.nav(-(vim.v.count > 0 and vim.v.count or 1))
	end,
	nowait = true,
	desc = "Previous buffer",
}
maps.n["<Leader>>"] = {
	function()
		buffer.move(vim.v.count > 0 and vim.v.count or 1)
	end,
	desc = "Move buffer tab right",
}
maps.n["<Leader><"] = {
	function()
		buffer.move(-(vim.v.count > 0 and vim.v.count or 1))
	end,
	desc = "Move buffer tab left",
}

maps.n["S"] = { "<Plug>(nvim-surround-normal)" }
-- maps.v["s"] = { "<Plug>(nvim-surround-visual)" }
-- maps.n["s"] = { "<Plug>VgSurround" }
-- maps.n["S"] = { "<Plug>VgSurround" }
-- maps.n["Ss"] = { "<Plug>VgSurround" }
-- maps.n["SS"] = { "<Plug>VgSurround" }
-- maps.v["S"] = { "<Plug>VgSurround" }
-- maps.x["gs"] = { "<Plug>VgSurround" }
-- maps.x["S"] = { "<Plug>VgSurround" }
-- maps.x["s"] = { "<Plug>VSurround" }

local function mapNoWait(mapping)
	for ascii = string.byte("A"), string.byte("z") do
		local key = mapping .. string.char(ascii)
		maps.n[key] = false
	end
end

mapNoWait("<Leader>p")
mapNoWait("<Leader>d")
mapNoWait("<Leader>l")

return maps
