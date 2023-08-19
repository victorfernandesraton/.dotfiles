require("neo-tree").setup({
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree

    filesystem = {
        filtered_items = {
            visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
            hide_dotfiles = false,
            hide_gitignored = true,
        },
    }
})
