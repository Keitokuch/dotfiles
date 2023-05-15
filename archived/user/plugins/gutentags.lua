vim.g.gutentags_project_root = {
  '.root', '.svn', '.git', '.project', '.proj'
}
vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/tags/')

vim.g.gutentags_ctags_extra_args = {
  '--tag-relative=yes',
  '--fields=+ailmnS',
}

vim.g.gutentags_ctags_exclude = {
  '*.git', '*.svg', '*.hg',
  'dist',
  'bin',
  '.ccls',
  '.ccls-*',
  'node_modules',
  'cache',
  '*-lock.json',
  '*.lock',
  '*bundle*.js',
  '*build*.js',
  '*.json',
  '*.bak',
  '*.zip',
  '*.pyc',
  '*.class',
}
