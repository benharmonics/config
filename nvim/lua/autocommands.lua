local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Transparent packground
autocmd('Colorscheme', {
  command = 'highlight normal ctermbg=none guibg=none',
})

-- go to insert mode immediately when entering terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})
autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert',
})

-- Don't show exit code, just close terminal
autocmd('TermClose', {
  command = ':q',
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert',
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e",
})

autocmd({ "BufWritePre" }, {
  pattern = { "*.templ" },
  callback = vim.lsp.buf.format,
})

-- Run gofmt and goimport for Golang files on save
local import_sync_group = vim.api.nvim_create_augroup('GoImport', {})
autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function() require'go.format'.goimport() end,
  group = import_sync_grp,
})

