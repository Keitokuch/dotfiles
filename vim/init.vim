let g:config_path = resolve(expand('<sfile>:p:h')).'/'

exec 'source' g:config_path . 'config.vim'
exec 'source' g:config_path . 'functions.vim'
exec 'source' g:config_path . 'mappings.vim'
exec 'source' g:config_path . 'plugin.vim'
exec 'source' g:config_path . 'autocmd.vim'
exec 'source' g:config_path . 'filetype.vim'
