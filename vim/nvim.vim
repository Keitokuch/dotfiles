" Neovim Configuration
let g:python_host_prog = system('which python')[:-2]
let g:python3_host_prog = system('which python3')[:-2]

lua << EOF
require "core"
require "core.options"

vim.defer_fn(function()
   require("core.utils").load_mappings()
end, 0)

-- setup packer + plugins
require("core.packer").bootstrap()
require "plugins"
EOF
