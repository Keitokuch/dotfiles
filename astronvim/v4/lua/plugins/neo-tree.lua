return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		enable_diagnostics = false,
		filesystem = {
			hijack_netrw_behavior = "disabled",
		},
		window = {
			width = 30,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<space>"] = false, -- disable space until we figure out which-key disabling
				["<leader>l"] = "prev_source",
				["<leader>;"] = "next_source",
				o = { "open", nowait = true },
				O = "system_open",
				C = "cut_to_clipboard",
				x = "close_node",
				h = "parent_or_close",
				l = "child_or_open",
				Y = "copy_selector",
				s = false,
				["oc"] = false,
				["od"] = false,
				["og"] = false,
				["om"] = false,
				["on"] = false,
				["os"] = false,
				["ot"] = false,
			},
		},
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "󰜌",
				provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
					if node.type == "file" or node.type == "terminal" then
						local success, web_devicons = pcall(require, "nvim-web-devicons")
						local name = node.type == "terminal" and "terminal" or node.name
						if success then
							local devicon, hl = web_devicons.get_icon(name)
							icon.text = devicon or icon.text
							icon.highlight = hl or icon.highlight
						end
					end
				end,
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "*",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type
					added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
					deleted = "✖", -- this can only be used in the git_status source
					renamed = "󰁕", -- this can only be used in the git_status source
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
			-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
			file_size = {
				enabled = true,
				width = 8, -- width of the column
				required_width = 40, -- min width of window required to show this column
			},
			type = {
				enabled = true,
				width = 10, -- width of the column
				required_width = 122, -- min width of window required to show this column
			},
			last_modified = {
				enabled = true,
				width = 20, -- width of the column
				required_width = 88, -- min width of window required to show this column
			},
			created = {
				enabled = false,
				width = 20, -- width of the column
				required_width = 110, -- min width of window required to show this column
			},
			symlink_target = {
				enabled = false,
			},
		},
	},
}
