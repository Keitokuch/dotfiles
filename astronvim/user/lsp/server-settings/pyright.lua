local map = vim.keymap.set
return {
  on_attach = function(client, bufnr)
    map("n", "\\i", function()
      vim.notify("Organize imports", "info", { title = "Pyright" })
      vim.cmd [[PyrightOrganizeImports]]
    end, { desc = "Organize imports", buffer = bufnr })
  end
}
