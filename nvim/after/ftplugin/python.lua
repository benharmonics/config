vim.opt_local.autoindent  = true -- align new line indent with previous line
vim.opt_local.expandtab   = true -- insert spaces when hitting TAB
vim.opt_local.shiftround  = true -- round indent to multiple of 'shiftwidth'
vim.opt_local.shiftwidth  = 4    -- operation >>  indents 'shiftwidth' columns; << unindents
vim.opt_local.softtabstop = 4    -- insert/delete 'softtabstop' spaces when hitting TAB/Backspace
vim.opt_local.textwidth   = 79   -- lines longer than 79 columns will be broken

vim.api.nvim_create_user_command('R', ':w <bar> !python %', {})
