local ok, format = pcall(require, 'lsp-format')
if not ok then
    vim.notify('Error while importing module lsp-format. ' .. format)
    return
end


format.setup {
    html = {{ cmd = {"prettier -w"} }},
    css = {{ cmd = {"prettier -w"} }},
    json = {{ cmd = {"prettier -w"} }},
    yaml = {{ cmd = {"prettier -w"} }},
    javascript = {{ cmd = {"prettier -w"} }},
    lua = {{
        cmd = {
            function(file)
                return string.format('lua-format -i --indent-width=4 --tab-width=4 --continuation-indent-width=8 --no-use-tab --keep-simple-control-block-one-line --keep-simple-function-one-line --align-args --align-parameter --double-quote-to-single-quote --spaces-inside-table-braces --spaces-around-equals-in-field --line-breaks-after-function-body %s', file)
            end
        }
    }},
}
