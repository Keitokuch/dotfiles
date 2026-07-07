---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    opts = { signature = { enabled = true } },
  },

  {
    "lfv89/vim-interestingwords",
    event = "VeryLazy",
  },
  {
    "smoka7/hop.nvim",
    keys = {
      {
        "f",
        function()
          require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection.AFTER_CURSOR,
            current_line_only = true,
          }
        end,
        mode = { "n", "x" },
        desc = "Hop forward on line",
      },
      {
        "F",
        function()
          require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
            current_line_only = true,
          }
        end,
        mode = { "n", "x" },
        desc = "Hop backward on line",
      },
      {
        "f",
        function()
          require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection.AFTER_CURSOR,
            current_line_only = true,
            inclusive_jump = true,
          }
        end,
        mode = "o",
        desc = "Hop forward text object",
      },
      {
        "F",
        function()
          require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
            current_line_only = true,
            inclusive_jump = true,
          }
        end,
        mode = "o",
        desc = "Hop backward text object",
      },
      { ";", function() require("hop").hint_char1 { multi_windows = true } end, mode = "n", desc = "Hop char" },
      { ";", function() require("hop").hint_char1() end, mode = "v", desc = "Hop char" },
      { ";", function() require("hop").hint_char1 { inclusive_jump = true } end, mode = "o", desc = "Hop char" },
    },
    config = function()
      require("hop").setup {
        keys = "asdfghjkl;wertyuiopcvnm",
        multi_windows = true,
      }
    end,
  },
  { "jbmorgado/vim-pine-script" },
}
