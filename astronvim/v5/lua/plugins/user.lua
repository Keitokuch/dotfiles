-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  {
    "saghen/blink.cmp",
    opts = { signature = { enabled = true } },
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "lfv89/vim-interestingwords",
    event = "VeryLazy",
  },
  {
    "phaazon/hop.nvim",
    branch = "v1",
    keys = {
      { "f", function() require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true }) end, mode = { "n", "x" } },
      { "F", function() require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true }) end, mode = { "n", "x" } },
      { "f", function() require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true }) end, mode = "o" },
      { "F", function() require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true }) end, mode = "o" },
      { ";", function() require("hop").hint_char1({ multi_windows = true }) end, mode = "n" },
      { ";", function() require("hop").hint_char1() end, mode = "v" },
      { ";", function() require("hop").hint_char1({ inclusive_jump = true }) end, mode = "o" },
    },
    config = function()
      require("hop").setup {
        keys = "asdfghjkl;wertyuiopcvnm",
        multi_windows = true,
      }
    end,
  },
}
