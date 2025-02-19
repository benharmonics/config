vim.api.nvim_create_user_command('R', ':w <bar> !dune exec -- bin/main.exe', {})
