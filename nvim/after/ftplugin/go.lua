vim.opt_local.expandtab   = false
vim.opt_local.tabstop     = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth  = 4

local cmd = vim.api.nvim_create_user_command
cmd('R', ':w <bar> !go run main.go', {})
cmd('Test', ':w <bar> !go test ./...', {})
