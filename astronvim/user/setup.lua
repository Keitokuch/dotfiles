local nvim_tree = true

User.neo_tree = not nvim_tree
User.nvim_tree = nvim_tree

User.tree_filetype = "NerdTree"
User.tree_filetype = User.neo_tree and "neo-tree" or User.tree_filetype
User.tree_filetype = User.nvim_tree and "NvimTree" or User.tree_filetype
