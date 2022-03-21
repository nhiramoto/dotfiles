local ok, lsp = pcall(require, 'lspconfig')
if not ok then
    vim.notify('Error while importing lspconfig. ' .. lsp)
    return
end

require('user.plugins.lsp.lsp-installer')
require('user.plugins.lsp.handlers').setup()

lsp.jdtls.setup {}
