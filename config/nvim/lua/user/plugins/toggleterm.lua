local ok, tterm = pcall(require, 'toggleterm')
if not ok then
    return
end

tterm.setup {
    open_mapping = [[<c-t>]],
    start_in_insert = true,
    direction = 'float',
    float_opts = {
        border = 'curved'
    }
}
