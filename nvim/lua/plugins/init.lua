local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'nvim-lualine/lualine.nvim'
Plug 'preservim/nerdtree'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

Plug 'luochen1990/rainbow'
Plug 'dracula/vim'
Plug 'rafamadriz/neon'
-- Plug 'Th3Whit3Wolf/space-nvim' -- ok, very dark

vim.call('plug#end')

-- Rainbow brackets
vim.g.rainbow_active = 1

-- Colorscheme options
vim.cmd('colorscheme neon')
vim.g.neon_italic_variable = 1
vim.g.neon_italic_function = 1

require'plugins/tree'
require'plugins/lsp'
require'plugins/autocompletion'
require'plugins/statusline'

