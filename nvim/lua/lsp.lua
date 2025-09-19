local lsps = {
  { 'gopls' },
  { 'pyright' },
  { 'templ' },
  { 'hls' },
  { 'dartls' },
  { 'vuels' },

  {
    'clangd',
    {
      init_options = { fallbackFlags = { '--std=c++20' } },
    },
  },

  {
    'ts_ls',
    {
      filetypes = {
        'typescript',
        'javascript',
        'typescriptreact',
        'javascriptreact',
        'vue',
      },
    },
  },

  {
    'tailwindcss',
    {
      filetypes = {
        'templ',
        'astro',
        'javascript',
        'typescript',
        'react',
        'typescriptreact',
        'javascriptreact',
      },
    },
  },

  {
    'ocamllsp',
    {
      filetypes = {
        'ocaml',
        'ocaml.menhir',
        'ocaml.interface',
        'ocaml.ocamllex',
        'reason',
        'dune',
      },
      -- TODO
      -- root_dir = vim.lsp.util.root_pattern('*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace'),
    },
  },

  {
    'lua_ls',
    {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- '${3rd}/luv/library'
              -- '${3rd}/busted/library',
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            -- library = vim.api.nvim_get_runtime_file('', true)
          },
        })
      end,
      settings = { Lua = {} },
    },
  },

  {
    'solidity',
    {
      -- on_attach = on_attach, -- probably you will need this.
      settings = {
        -- example of global remapping
        solidity = {
          includePath = '',
          remapping = { ["@OpenZeppelin/"] = 'OpenZeppelin/openzeppelin-contracts@4.6.0/' },
          -- Array of paths to pass as --allow-paths to solc
          allowPaths = {}
        },
      },
    },
  },
}

vim.lsp.config('*', { capabilities = require 'cmp_nvim_lsp'.default_capabilities() })

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]
  vim.lsp.enable(name)
  if config then
    vim.lsp.config(name, config)
  end
end

vim.diagnostic.config({ virtual_text = true })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    -- TODO: do we need the following options at all?
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  end,
})
