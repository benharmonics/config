local aucmd = vim.api.nvim_create_autocmd

-- go to insert mode immediately when entering terminal
aucmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})
aucmd('TermOpen', {
  pattern = '',
  command = 'startinsert',
})

-- Don't show exit code, just close terminal
aucmd('TermClose', {
  command = ':q',
})

-- Close terminal buffer on process exit
aucmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert',
})

-- Remove whitespace on save
aucmd('BufWritePre', {
  pattern = '',
  command = ':%s/\\s\\+$//e',
})

aucmd({ 'BufWritePre' }, {
  pattern = { '*.templ' },
  callback = vim.lsp.buf.format,
})

-- Run gofmt and goimport for Golang files on save
local import_sync_group = vim.api.nvim_create_augroup('GoImport', {})
aucmd('BufWritePre', {
  pattern = '*.go',
  callback = function() require'go.format'.goimport() end,
  group = import_sync_group,
})

