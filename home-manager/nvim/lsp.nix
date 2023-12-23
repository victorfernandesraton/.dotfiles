{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    #LSP
    lsp-zero-nvim
    # Completions
    cmp-nvim-lsp
    cmp-buffer
    lsp-format-nvim
    lspkind-nvim
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = /* lua */ ''

        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        lsp_zero.on_attach(function(client, bufnr)
          lsp_zero.default_keymaps({buffer = bufnr})
          if client.supports_method('textDocument/formatting') then
            require('lsp-format').on_attach(client)
          end
        end)

        local lspconfig = require('lspconfig')
        lsp_zero.setup_servers({
          'lua_ls', 
          'pyright',
          'tsserver',
          'gopls',
          'bashls',
          'dockerls', 
          'marksman'
        })
        local configs = lspconfig.configs
        if not configs.ruff_lsp then
          configs.ruff_lsp = {
            default_config = {
              cmd = { 'ruff-lsp' },
              filetypes = { 'python' },
              root_dir = require('lspconfig').util.find_git_ancestor,
              init_options = {
                settings = {
                  args = {}
                }
              }
            }
          }
        end
        lspconfig.texlab.setup({
          chktex = { onEdit = true, onOpenAndSave = true }
        })
        require('lspconfig').ruff_lsp.setup({})

        lsp_zero.format_on_save({
          format_opts = {
            async = false,
            timeout_ms = 10000,
          },
          servers = {
            ['tsserver'] = {'javascript', 'typescript'},
            ['rust_analyzer'] = {'rust'},
            ['gofmt'] = {'golang'},
            ['ruff_lsp'] = {'python'}
          }
        })
      '';
    }

    # Markdown support
    nvim-treesitter-parsers.markdown
 

    # Go lsp
    nvim-treesitter-parsers.go
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

