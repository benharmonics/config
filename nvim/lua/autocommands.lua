local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Transparent packground
autocmd('Colorscheme', {
  command = 'highlight Normal ctermbg=NONE guibg=NONE'
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
