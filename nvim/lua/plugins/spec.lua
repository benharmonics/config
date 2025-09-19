local function nmap(shortcut, command, opts)
  vim.keymap.set('n', shortcut, command, opts)
end

return {
  { 'neovim/nvim-lspconfig' },
  { 'mfussenegger/nvim-dap' },
  { 'preservim/nerdtree', cmd = { "NERDTreeToggle" } },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'BurntSushi/ripgrep',    -- optional - grep
      'sharkdp/fd',            -- optional - find
    },
    init = function()
      local builtin = require'telescope.builtin'
      nmap('<leader>ff', builtin.find_files)
      nmap('<leader>fg', builtin.live_grep)
      nmap('<leader>fb', builtin.buffers)
      nmap('<leader>fh', builtin.help_tags)
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        theme = 'material',
      },
      sections = {
        lualine_c = { { 'filename', path = 4 } },
        lualine_x = { 'encoding', 'filetype', 'tabs' },
        lualine_y = { 'tabs', 'windows' },
        lualine_z = { 'progress', 'location' },
      },
    },
  },

  -- Language tools
  { 'ray-x/go.nvim', ft = 'go', opts = {} },
  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    opts = function()
      local rt = require'rust-tools'
      return {
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            nmap('<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            nmap('<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
          end,
        },
      }
    end,
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    ft = 'dart',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {},
  },

  -- Colors, UI
  { 'xiyaowong/transparent.nvim' },
  { 'hiphish/rainbow-delimiters.nvim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function() vim.cmd[[colorscheme catppuccin]] end,
  },
  { 'rafamadriz/neon', lazy = true },
  { 'marko-cerovac/material.nvim', lazy = true },
  { 'Mofiqul/dracula.nvim', lazy = true },
}
