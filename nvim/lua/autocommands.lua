local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Transparent packground
autocmd('Colorscheme', {
  command = 'highlight normal ctermbg=none guibg=none'
})

-- Fold text within markers
autocmd('FileType', {
  pattern = { 'text', 'vim', 'lua' },
  command = 'setlocal foldmethod=marker'
})

-- Set Python indent
autocmd('FileType', {
  pattern = { 'python' },
  command = 'setlocal shiftwidth=4 softtabstop=4'
})

-- Set Golang indent
autocmd('FileType', {
  pattern = { 'go' },
  command = 'setlocal noexpandtab tabstop=4 shiftwidth=4'
})

-- Set Rust indent
autocmd('FileType', {
  pattern = { 'rust' },
  command = 'setlocal shiftwidth=2 softtabstop=2'
})

-- go to insert mode immediately when entering terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline'
})
autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})

-- Don't show exit code, just close terminal
autocmd('TermClose', {
  command = ':q'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Run gofmt and goimport for Golang files on save
local import_sync_group = vim.api.nvim_create_augroup('GoImport', {})
autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function() require'go.format'.goimport() end,
  group = import_sync_grp,
})

