local ok, module = pcall(require, 'project_nvim')
if not ok then
    return
end

module.setup {
    manual_mode = false,
    exclude_dirs = {},
    show_hidden = true,
    silent_chdir = true
}
