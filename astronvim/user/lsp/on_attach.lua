local utils = require "astronvim.utils"
local conditional_func = utils.conditional_func
local is_available = utils.is_available

return function(client, bufnr)
  local capabilities = client.server_capabilities
  local map = vim.keymap.set

  map("n", "K", function()
    vim.lsp.buf.hover()
  end, { desc = "Hover symbol details", buffer = bufnr })
  map("n", "\\a", function()
    vim.lsp.buf.code_action()
  end, { desc = "LSP code action", buffer = bufnr })

  if capabilities.documentFormattingProvider then
    map("n", "\\f",
      function()
        vim.notify("Format code", "info", { title = "LSP" })
        vim.lsp.buf.format()
      end,
      { desc = "Format code", buffer = bufnr }
    )
  end

  if capabilities.renameProvider then
    map("n", "\\r",
      function() vim.lsp.buf.rename() end,
      { desc = "Rename symbol", buffer = bufnr }
    )
  end
end
