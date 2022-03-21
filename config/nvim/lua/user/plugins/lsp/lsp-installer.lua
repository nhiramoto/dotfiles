local ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not ok then
    vim.notify('Error while importing nvim-lsp-installer. ' .. lsp_installer)
    return
end

lsp_installer.on_server_ready(function (server)
    local opts = {
        on_attach = require('user.plugins.lsp.handlers').on_attach,
        capabilities = require('user.plugins.lsp.handlers').capabilities
    }

    if server.name == 'jsonls' then
        local jsonls_opts = require('user.plugins.lsp.settings.jsonls')
        opts = vim.tbl_deep_extend('force', jsonls_opts, opts)
    elseif server.name == 'sumneko_lua' then
        local sumneko_opts = require('user.plugins.lsp.settings.sumneko_lua')
        opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
    elseif server.name == 'pyright' then
        local pyright_opts = require('user.plugins.lsp.settings.pyright')
        opts = vim.tbl_deep_extend('force', pyright_opts, opts)
    elseif server.name == 'jdtls' then
        local jdtls_opts = require('user.plugins.lsp.settings.jdtls')
        opts = vim.tbl_deep_extend('force', jdtls_opts)
    end

    server:setup(opts)
end)

