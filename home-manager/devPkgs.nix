
# List of the dev and system packages that we want to have installed in all of our systems
{pkgs, ...}:

let
    # Specify custom Python enviroment
    # `pp` is the passed python packages object
    custom_python_packages = pp: [
        pp.numpy
        pp.pytest
        pp.pip
        pp.virtualenv
        pp.black
        pp.isort
        pp.python-lsp-server
    ];
    custom_python_enviroment = pkgs.python311.withPackages custom_python_packages;

in
# Dev packages
[
    pkgs.tree-sitter        # Neovim relies heavily on treesitter
    pkgs.ripgrep            # Better grep
    pkgs.jq                 # Command line JSON pretty printer
    pkgs.lldb               # For debugging rust and c++ with nvim-dap
    pkgs.rclone             # For syncing with google drive
    pkgs.pandoc             # Tools like rmarkdown need this
    pkgs.curl                 # Good alternative to curl
    pkgs.fzf
    pkgs.fd

] ++

# System packages
[
    pkgs.dpkg
    pkgs.zip                        # To archive files
    pkgs.unzip                      # Some nvim LSPs need this to install
    pkgs.nodejs                     # Some nvim LSPs need this
    pkgs.go
    pkgs.libstdcxx5                 # Some nvim LSP need this to work
    pkgs.gcc-unwrapped
] ++

# Container dev and tools

[
    pkgs.podman
    pkgs.podman-compose
    pkgs.podman-desktop
    pkgs.podman-desktop
] ++
# Programming languages and their LSPs
[
    # To work with rust projects
    pkgs.cargo

    # Python with some packages installed
    custom_python_enviroment
    # ruff python lint
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
    pkgs.nodePackages.eslint
]

