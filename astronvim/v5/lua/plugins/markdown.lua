return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
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
