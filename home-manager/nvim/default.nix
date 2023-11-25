{ config, pkgs, ... }:
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: toLua "${builtins.readFile file}";
  in
{

    imports = [
      ./lsp.nix
    ];

  programs.neovim = 

  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = [
      pkgs.lua-language-server
      pkgs.rnix-lsp
      pkgs.xclip
      pkgs.wl-clipboard
      # To work with rust projects
      pkgs.cargo

      # Python with some packages installed
      pkgs.python311Packages.python-lsp-server
      pkgs.ruff

      # Nix
      pkgs.rnix-lsp

      # Lua
      pkgs.sumneko-lua-language-server
      pkgs.lua53Packages.lua-lsp

      # Latex
      pkgs.texlab

      # Markdown lsp
      pkgs.marksman
      #  node lsp
      pkgs.nodePackages.typescript-language-server
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          vim.g.mapleader = ' '
          vim.g.maplocalleader = ' '
          vim.opt.shiftwidth = 4
          vim.opt.expandtab = true
          vim.opt.smartindent = true

          vim.opt.undofile = true

          vim.opt.hlsearch = true
          vim.opt.incsearch = true

          vim.opt.termguicolors = true

          vim.opt.nu = true
          vim.opt.relativenumber = false
          vim.opt.scrolloff = 4
          vim.opt.colorcolumn = "80"
          vim.opt.updatetime = 50
          vim.opt.signcolumn = "yes"


          vim.o.mouse = 'a'


          -- copy things from vim to my system
          vim.keymap.set("n", "<leader>y",  "\"+ y")
          vim.keymap.set("v", "<leader>y",  "\"+ y")
          vim.keymap.set("n", "<leader>y",  "\"+ Y")

          -- select and move highlight lines 
          vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
          vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

          -- copy for external
          vim.keymap.set("n", "<leader>y", "\"+y")
          vim.keymap.set("v", "<leader>y", "\"+y")
          vim.keymap.set("n", "<leader>d", "\"_d")
          vim.keymap.set("v", "<leader>d", "\"_d")

        '';
      }
      
      {
        plugin = vim-fugitive;
        type = "lua";
        config = ''
          vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
          vim.keymap.set("n", "<leader>gll",":Git log --all --decorate --oneline --graph<CR>")
          vim.keymap.set("n", "<leader>gpp" , ":G push <CR>")
          vim.keymap.set("n", "<leader>gff" , ":G fetch <CR>")
          vim.keymap.set("n", "<leader>gpl" , ":G pull <CR>")
        '';
      }

      {
        plugin = rose-pine;
        config = "colorscheme rose-pine";
      }

      neodev-nvim

      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<C-p>', builtin.git_files, {})
          vim.keymap.set('n', '<leader>ps', function()
            bultin.grep_string({search = vim.fn.input('Grep > ')});
          end)
        '';
      }

      telescope-fzf-native-nvim

      friendly-snippets


      lualine-nvim
      nvim-web-devicons
      plenary-nvim
      nui-nvim
      
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          vim.keymap.set("n", "<leader>pv", ":Neotree toggle<CR>")
          require("neo-tree").setup({
            close_if_last_window = false,
            enable_git_status = true,
            filesystem = {
              follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
              },
              hijack_netrw_behavior = "open_default",
            }
          })
        '';
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-javascript
        ]));
        type = "lua";
        config = ''        
          require('nvim-treesitter.configs').setup {
              ensure_installed = {},

              auto_install = false,

              highlight = { enable = true },

              indent = { enable = true },
          }
        '';
      }

      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
          require("toggleterm").setup{
            open_mapping = [[<c-t>]],
            direction = 'float',
            auto_scroll = true,
          }
        '';
      }

      vim-nix

    ];
  };
}
