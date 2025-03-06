-- Customize Treesitter

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		indent = { enabled = false },
		ensure_installed = {
			"lua",
			"vim",
			-- add more arguments for adding more treesitter parsers
		},
	},
}
