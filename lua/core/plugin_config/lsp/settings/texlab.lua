return {
  settings = {
    texlab = {
      build = {
        executable = 'pdflatex',
        forwardSearchAfter = true,
        --[[ args = { '-X', 'compile', '%f', '--synctex', '--keep-logs', '--key-intermediates'}, ]]
        onSave = true,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      forwardSearch = {
        executable = 'evince-synctex',
        args = { '-f', '%l', '%p', '"code -g %f:%l"' },
      },
    },
  }
}
