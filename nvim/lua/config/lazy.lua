-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Global settings
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- Set options (global/buffer/windows-scoped)
local opt = vim.opt
opt.mouse = 'a'               -- Enable mouse
opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard
opt.number = true             -- Show line number
opt.relativenumber = true     -- Show relative line numbers
opt.showmatch = true          -- Highlight matching parenthesis
opt.foldmethod = 'marker'     -- Enable folding (default 'foldmarker')
opt.splitright = true         -- Vertical split to the right
opt.splitbelow = true         -- Horizontal split to the bottom
opt.ignorecase = true         -- Ignore case letters when search
opt.smartcase = true          -- Ignore lowercase for the whole pattern
opt.termguicolors = true      -- Enable 24-bit RGB colors
opt.hlsearch = true           -- Highlight searches
opt.confirm = true            -- Dialogue box to confirm file changes
opt.visualbell = true         -- Visual alert rather than audio
opt.cmdheight = 2             -- Set command window to 2 lines
opt.wrap = false              -- Don't wrap text
opt.encoding = 'utf-8'        -- Text encoding
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.backspace = 'indent,eol,start' -- Allow backspacing over autoindent, line breaks, & start of insert action

-- Setup lazy.nvim
require 'lazy'.setup {
  spec = {
    { import = 'plugins' }, -- import your plugins
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'habamax', 'dracul' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}
