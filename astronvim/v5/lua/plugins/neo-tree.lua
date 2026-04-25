local function filter_git_status_sources(opts)
	opts.sources = { "filesystem", "buffers" }

	local selector_sources = opts.source_selector and opts.source_selector.sources
	if selector_sources then
		opts.source_selector.sources = vim.tbl_filter(
			function(source) return source.source ~= "git_status" end,
			selector_sources
		)
	end
end

local function apply_network_fs_profile(opts)
	opts.enable_git_status = false
	opts.git_status_async = false
	opts.enable_refresh_on_write = false

	filter_git_status_sources(opts)

	opts.filesystem = opts.filesystem or {}
	opts.filesystem.use_libuv_file_watcher = false
	opts.filesystem.check_gitignore_in_search = false
	opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
	opts.filesystem.filtered_items.hide_gitignored = false
	opts.filesystem.filtered_items.hide_ignored = false
	opts.filesystem.filtered_items.ignore_files = {}

	opts.default_component_configs = opts.default_component_configs or {}
	opts.default_component_configs.name = opts.default_component_configs.name or {}
	opts.default_component_configs.name.use_git_status_colors = false
	opts.default_component_configs.git_status = opts.default_component_configs.git_status or {}
	opts.default_component_configs.git_status.enabled = false
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = function(_, opts)
		local astro = require "astrocore"
		opts = astro.extend_tbl(opts, {
			enable_diagnostics = false,
			filesystem = {
				hijack_netrw_behavior = "disabled",
				scan_mode = "shallow",
				async_directory_scan = "always",
				-- Don't auto-scroll the tree to the current buffer on every file
				-- switch; reveal only on explicit focus (`sf` → `Neotree reveal`).
				follow_current_file = { enabled = false },
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
				-- file_size / type / last_modified each call vim.loop.fs_stat per
				-- entry, which is the dominant cost when traversing slow/network FS.
				file_size = {
					enabled = false,
					width = 8, -- width of the column
					required_width = 40, -- min width of window required to show this column
				},
				type = {
					enabled = false,
					width = 10, -- width of the column
					required_width = 122, -- min width of window required to show this column
				},
				last_modified = {
					enabled = false,
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
		})

		if vim.g.network_fs then apply_network_fs_profile(opts) end

		return opts
	end,
}
