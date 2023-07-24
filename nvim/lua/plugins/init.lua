-- Packer package management setup
require'packer'.startup(function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- LSP & hrsh7th's plugin set
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- LSP tools
  use 'simrat39/rust-tools.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Language tools
  use 'ray-x/go.nvim'

  -- Misc
  use 'preservim/nerdtree'
  use 'nvim-lualine/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim'

  -- Colorschemes
  use 'rafamadriz/neon'
  use { 'Mofiqul/dracula.nvim', as = 'dracula' }
  use 'marko-cerovac/material.nvim'
  use 'luochen1990/rainbow'
end)

vim.g.rainbow_active = true

vim.cmd[[colorscheme dracula]]

require'plugins/tree'
require'plugins/lsp'
require'plugins/autocompletion'
require'plugins/statusline'
require'plugins/indent'
require'plugins/languages'

