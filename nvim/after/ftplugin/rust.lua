vim.opt_local.shiftwidth  = 2
vim.opt_local.softtabstop = 2

local cmd = vim.api.nvim_create_user_command
cmd('R', ':w <bar> !cargo run', {})
cmd('Fmt', ':w <bar> !cargo fmt', {})
cmd('Test', ':w <bar> !cargo test', {})
cmd('Check', ':w <bar> !cargo check', {})
cmd('Clippy', ':w <bar> !cargo clippy', {})
