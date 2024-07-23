local keyset = vim.keymap.set
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc };
end

-- Tabs/Buffers
keyset('n', '<leader>tc', '<cmd>tabe<cr>', opts('Nova aba.'))
keyset('n', '<leader>tn', '<cmd>tabn<cr>', opts('Próxima aba.'))
keyset('n', '<leader>tn', '<cmd>tabp<cr>', opts('Aba anterior.'))
keyset('n', '<leader>bn', '<cmd>bn<cr>', opts('Próximo buffer.'))
keyset('n', '<leader>bp', '<cmd>bp<cr>', opts('Buffer anterior'))
keyset('n', '<leader>bd', '<cmd>bd<cr>', opts('Deletar buffer.'))
keyset('n', '<leader>sh', '<cmd>split<cr>', opts('Dividir horizontalmente.'))
keyset('n', '<leader>sv', '<cmd>vsplit<cr>', opts('Dividir verticalmente.'))

-- Telescope
local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions
keyset('n', '<leader>tf', builtin.find_files, {})
keyset('n', '<leader>tg', builtin.live_grep, {})
keyset('n', '<leader>tb', builtin.buffers, {})
keyset('n', '<leader>th', builtin.help_tags, {})
keyset('n', '<leader>te', function()
  require('telescope').extensions.file_browser.file_browser()
end)
keyset('n', '<leader>st', '<cmd>vsplit<bar>Telescope find_files<cr>', opts('[Telescope] Buscar arquivos.'))
keyset('n', '<leader>dl', builtin.diagnostics, opts('[Telescope] Listar diagnostics.'))
keyset('n', '<leader>o', builtin.lsp_document_symbols, opts('[Telescope] Lista símbolos.'))
keyset('n', '<leader>wo', builtin.lsp_workspace_symbols, opts('[Telescope] Lista símbolos do workspace.'))
keyset('n', 'gr', builtin.lsp_references, opts('[Telescope] Ir/Listar referências.'))
keyset('n', '<leader>cl', builtin.commands, opts('[Telescope] Listar comandos.'))
keyset('n', '<leader>ql', builtin.quickfix, opts('[Telescope] Quickfix.'))
keyset('n', '<leader>tic', builtin.lsp_incoming_calls, opts('[Telescope] List incoming calls.'))
keyset('n', '<leader>toc', builtin.lsp_outgoing_calls, opts('[Telescope] List outgoing calls.'))
keyset('n', 'gd', builtin.lsp_definitions, opts('[Telescope] Ir para definição.'))
keyset('n', 'gi', builtin.lsp_implementations, opts('[Telescope] Ir/Listar implementações.'))
keyset('n', '<leader>ts', builtin.git_status, opts('[Telescope] Listar status do git.'))
keyset('n', '<leader>fr', extensions.flutter.commands, opts('[Telescope] Listar comandos Flutter.'))
keyset('n', '<C-r>', builtin.jumplist, opts('[Telescope] Listar jumplist.'))
keyset('n', '<leader>tr', builtin.registers, opts('[Telescope] Listar registros.'))

-- LSP
keyset({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts('[LSP] Ações rápidas.'))
keyset('n', '<leader>cf', function() vim.lsp.buf.format { async = true } end, opts('[LSP] Formatar código.'))
keyset({'n', 'i'}, '<C-k>', vim.lsp.buf.signature_help, opts('[LSP] Signature help.'))
keyset('n', '<leader>rn', vim.lsp.buf.rename, opts('[LSP] Renomear símbolo.'))

-- Nvim Tree
keyset('n', '<C-f>', '<cmd>NvimTreeToggle<cr>', opts('[NvimTree] Mostrar/ocultar NvimTree.'))

keyset('n', '<leader>,', '<cmd>OverseerToggle<cr>', opts('[Overseer] Mostrar/ocultar execução das tarefas.'))
keyset('n', '<leader>.', '<cmd>OverseerRun<cr>', opts('[Overseer] Executar tarefa.'))

-- Nvim DAP
local dap = require('dap')
keyset('n', '<leader>db', dap.toggle_breakpoint, opts('[dap] Alternar breakpoint.'))
keyset('n', '<leader>dc', dap.continue, opts('[dap] Continuar.'))
keyset('n', '<leader>do', dap.step_over, opts('[dap] Step Over.'))
keyset('n', '<leader>di', dap.step_into, opts('[dap] Step Into.'))
keyset('n', '<leader>dr', dap.repl.open, opts('[dap] Repl open.'))

-- Hover
local hover = require('hover')
keyset("n", "K", hover.hover, {desc = "hover.nvim"})
keyset("n", "gK", hover.hover_select, {desc = "hover.nvim (select)"})
keyset("n", "<C-p>", function() hover.hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
keyset("n", "<C-n>", function() hover.hover_switch("next") end, {desc = "hover.nvim (next source)"})
