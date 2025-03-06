local luasnip = require("luasnip")
local cmp = require("cmp")

return { -- override nvim-cmp plugin
	"hrsh7th/nvim-cmp",
	-- override the options table that is used in the `require("cmp").setup()` call
	opts = function(_, opts)
		-- opts parameter is the default options table
		-- the function is lazy loaded so cmp is able to be required
		-- modify the mapping part of the table
		opts.mapping = {
			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if luasnip.expandable() then
						luasnip.expand()
					else
						cmp.confirm({
							select = true,
						})
					end
				else
					fallback()
				end
			end),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}
	end,
}
