# List of the dev and system packages that we want to have installed in all of our systems
{ pkgs, ... }:

let
  # Specify custom Python enviroment
  # `pp` is the passed python packages object
  custom_python_packages = pp: [
    pp.numpy
    pp.pytest
    pp.pip
    pp.virtualenv
    pp.debugpy
  ];
  custom_python_enviroment = pkgs.python311.withPackages custom_python_packages;

in
# Dev packages
[
  pkgs.tree-sitter # Neovim relies heavily on treesitter
  pkgs.ripgrep # Better grep
  pkgs.jq # Command line JSON pretty printer
  pkgs.lldb # For debugging rust and c++ with nvim-dap
  pkgs.rclone # For syncing with google drive
  pkgs.pandoc # Tools like rmarkdown need this
  pkgs.curl # Good alternative to curl
  pkgs.fzf
  pkgs.fd

] ++

# System packages
[
  pkgs.gcc
  pkgs.libgcc
  pkgs.glibc
  pkgs.libcap
  pkgs.dpkg
  pkgs.zip # To archive files
  pkgs.unzip # Some nvim LSPs need this to install
  pkgs.nodejs_20 # Some nvim LSPs need this
  pkgs.go
  pkgs.libstdcxx5 # Some nvim LSP need this to work
] ++

# Container dev and tools

[
  pkgs.podman
  pkgs.podman-compose
] ++
  # Programming languages and their LSPs
[
  # To work with rust projects
  pkgs.cargo

  # bash

  pkgs.nodePackages.bash-language-server

  # Python with some packages installed
  custom_python_enviroment
  pkgs.pipx
  pkgs.nodePackages.pyright
  pkgs.poetry

  # ruff python lint
  pkgs.ruff
  pkgs.ruff-lsp

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
  pkgs.nodePackages.eslint
  pkgs.nodePackages.vscode-html-languageserver-bin
  pkgs.nodePackages.stylelint
  pkgs.nodePackages.prettier

  # CSS
  pkgs.vscode-langservers-extracted
  # golang
  pkgs.gopls
  pkgs.delve
]

