vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌"
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    }
}

local ok, ntree = pcall(require, 'nvim-tree')
if not ok then
    return
end

local c_ok, ntree_config = pcall(require, 'nvim-tree.config')
if not c_ok then
    return
end

ntree.setup {
    auto_close = true,
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
        tree_width = 30
    },
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true
    }
}
