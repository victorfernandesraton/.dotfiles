{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    #LSP
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = /* lua */ ''
        local lspconfig = require('lspconfig')
        function add_lsp(server, options)
          if options["cmd"] ~= nil then
            binary = options["cmd"][1]
          else
            binary = server["document_config"]["default_config"]["cmd"][1]
          end
          if vim.fn.executable(binary) == 1 then
            server.setup(options)
          end
        end

        add_lsp(lspconfig.dockerls, {})
        add_lsp(lspconfig.bashls, {})
        add_lsp(lspconfig.clangd, {})
        add_lsp(lspconfig.nil_ls, {})
        add_lsp(lspconfig.pylsp, {})
        add_lsp(lspconfig.terraformls, {})
        add_lsp(lspconfig.gopls, {})
        add_lsp(lspconfig.lua_ls, {})
        add_lsp(lspconfig.tsserver, {})
        add_lsp(lspconfig.marksman, {})
        add_lsp(lspconfig.texlab, {
          chktex = { onEdit = true, onOpenAndSave = true }
        })
        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<leader>gv', vim.diagnostic.open_float)
        vim.keymap.set('v', '<leader>gv', vim.diagnostic.open_float)
        vim.keymap.set('n', '<leader>gN', vim.diagnostic.goto_prev)
        vim.keymap.set('n', '<leader>gn', vim.diagnostic.goto_next)

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
            vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>hh', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('v', '<leader>hh', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>cA', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<C-f>', function()
              vim.lsp.buf.format { async = true }
            end, opts)
          end,
        })
      '';
    }

    # Markdown support
    nvim-treesitter-parsers.markdown
 
    # Completions
    cmp-nvim-lsp
    cmp-buffer
    lspkind-nvim
    {
      plugin = go-nvim;
      type = "lua";
      config = /*lua*/ ''
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
           require('go.format').goimport()
          end,
          group = format_sync_grp,
        })

        require('go').setup()
      '';
    }

    {
      plugin = nvim-cmp;
      type = "lua";
      config = /* lua */ ''
        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}

        cmp.setup({
            sources = {
                {name = 'path'},
                {name = 'nvim_lsp'},
                {name = 'nvim_lua'},
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })
      '';
    }
  ];
}

