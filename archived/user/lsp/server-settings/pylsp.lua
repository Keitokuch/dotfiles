return {
  settings = {
    pylsp = {
      plugins = {
        flake8 = {enabled=true, maxLineLength=100, ignore={'E203', 'F401', 'F541', 'F841'}},
        pylint = {args = {'--ignore=E231', '-'}, enabled=true, debounce=200},
        pycodestyle={
          enabled=false,
          -- ignore={'E501', 'E231'},
          maxLineLength=100},
        },
        yapf={enabled=true}
      }
    }
}
