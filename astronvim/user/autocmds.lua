function User.fn.do_autocmds()
  vim.api.nvim_create_augroup("user", { clear = true })

  -- Open help in Hori Split
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = "user",
    callback = function()
      if vim.bo.buftype == "help" then
        vim.cmd[[
          wincmd L
          vert resize 80
        ]]
        vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<cr>", {})
        vim.api.nvim_buf_set_keymap(0, "n", "<esc>", "<cmd>q<cr>", {})
      end
    end
  })


  -- Toggle cursorlien on focus
  vim.api.nvim_create_autocmd("WinEnter", {
    group = "user",
    callback = function()
      vim.opt_local.cursorline = true
    end
  })
  vim.api.nvim_create_autocmd("WinLeave", {
    group = "user",
    callback = function()
      vim.opt_local.cursorline = false
    end
  })
end
