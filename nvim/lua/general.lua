------------------------------------------------------------------------
-- General Neovim settings and configuration
------------------------------------------------------------------------

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

------------------------------------------------------------------------
-- General
------------------------------------------------------------------------
g.mapleader = ','
vim.cmd[[syntax enable]]
opt.mouse = 'a'                 -- Enable mouse
opt.clipboard = 'unnamedplus'   -- Copy/paste to system clipboard
-- Have terminal open in a split pane rather than current window
vim.cmd([[command! -nargs=* T w | split | terminal <args>]])

------------------------------------------------------------------------
-- UI
------------------------------------------------------------------------
opt.number = true           -- Show line number
opt.relativenumber = true   -- Show relative line numbers
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.hlsearch = true         -- Highlight searches
opt.confirm = true          -- Dialogue box to confirm file changes
opt.visualbell = true       -- Visual alert rather than audio
opt.cmdheight = 2           -- Set command window to 2 lines
opt.wrap = false            -- Don't wrap text
opt.encoding = 'utf-8'      -- Text encoding

------------------------------------------------------------------------
-- Tabs, indentation
------------------------------------------------------------------------
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.backspace = 'indent,eol,start' -- Allow backspacing over autoindent, line breaks, & start of insert action
vim.cmd[[set nostartofline]]

