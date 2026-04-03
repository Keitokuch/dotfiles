return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		bullet = {
			ordered_icons = function(ctx)
				local value = vim.trim(ctx.value)
				local index = tonumber(value:sub(1, #value - 1))
				return ("%d."):format((index and index > 1) and index or ctx.index)
			end,
		},
	},
}
