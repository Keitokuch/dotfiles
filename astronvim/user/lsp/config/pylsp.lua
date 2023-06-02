return {
  pylsp = {
    plugins = {
      autopep8 = { enabled = false },
      flake8 = { enabled = true, maxLineLength = 100, ignore = { 'E203', 'F401', 'F541', 'F841' } },
      pylint = { args = { '--ignore=E231', '-' }, enabled = true, debounce = 200 },
      pycodestyle = {
        enabled = true,
        ignore = { 'E231' },
        maxLineLength = 100
      },
      pyflake = { enabled = false },
      mypy = { enabled = false },
      isort = { enabled = false },
      yapf = { enabled = false },
      preload = { enabled = false },
      rope_completion = { enabled = false }
    },
  },
}
