vim.api.nvim_create_user_command('R', ':w <bar> !chmod +x % && %:p', {})
