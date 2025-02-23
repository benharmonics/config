return {
  'neovim/nvim-lspconfig',
  init = function ()
    local capabilities = require'cmp_nvim_lsp'.default_capabilities()
    local lspcfg = require'lspconfig'
    lspcfg.clangd.setup  { capabilities = capabilities }
    lspcfg.gopls.setup   { capabilities = capabilities }
    lspcfg.pyright.setup { capabilities = capabilities }
    lspcfg.templ.setup   { capabilities = capabilities }
    lspcfg.hls.setup     { capabilities = capabilities }
    lspcfg.dartls.setup  { capabilities = capabilities }
    lspcfg.vuels.setup   { capabilities = capabilities }

    lspcfg.ts_ls.setup   {
      capabilities = capabilities,
      filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
    }

    lspcfg.tailwindcss.setup {
      capabilities = capabilities,
      filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'react', 'typescriptreact', 'javascriptreact' },
      settings = {
        tailwindCSS = {
          includeLanguages = {
            templ = 'html',
            typescript = 'html',
          },
        },
      },
    }

    lspcfg.ocamllsp.setup {
      capabilities = capabilities,
      filetypes = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
      root_dir = lspcfg.util.root_pattern('*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace'),
    }

    lspcfg.lua_ls.setup  {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
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
      settings = {
        Lua = {}
      },
      capabilities = capabilities,
    }

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
  end
}
