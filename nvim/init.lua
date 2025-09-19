require 'config.lazy'
require 'autocommands'
require 'mappings'
require 'lsp'

vim.filetype.add({ extension = { templ = 'templ' } })
vim.cmd [[syntax enable]]
vim.cmd [[set nostartofline]]
-- Have terminal open in a split pane rather than current window
vim.cmd([[command! -nargs=* T w | split | terminal <args>]])
