vim.opt_local.wrap      = true
vim.opt_local.linebreak = true
vim.opt_local.spell     = true

nopt = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'j', 'gj', nopt)
vim.api.nvim_set_keymap('n', 'k', 'gk', nopt)

