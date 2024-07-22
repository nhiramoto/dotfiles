local keyset = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Tabs/Buffers
keyset('n', '<leader>tc', '<cmd>tabe<cr>', opts)
keyset('n', '<leader>bn', '<cmd>bn<cr>', opts)
keyset('n', '<leader>bp', '<cmd>bp<cr>', opts)
keyset('n', '<leader>bd', '<cmd>bd<cr>', opts)
keyset('n', '<leader>sh', '<cmd>split<cr>', opts)
keyset('n', '<leader>sv', '<cmd>vsplit<cr>', opts)

-- Telescope
local builtin = require('telescope.builtin')
keyset('n', '<leader>tf', builtin.find_files, {})
keyset('n', '<leader>tg', builtin.live_grep, {})
keyset('n', '<leader>tb', builtin.buffers, {})
keyset('n', '<leader>th', builtin.help_tags, {})
keyset('n', '<leader>te', function()
  require('telescope').extensions.file_browser.file_browser()
end)
keyset('n', '<leader>st', '<cmd>vsplit<bar>Telescope find_files<cr>', opts)
keyset('n', '<leader>td', builtin.diagnostics, {})
keyset('n', '<leader>tr', builtin.resume, {})

-- Nvim Tree
keyset('n', '<C-f>', '<cmd>NvimTreeToggle<cr>', opts)

keyset('n', '<leader>rl', '<cmd>OverseerToggle<cr>', opts)
keyset('n', '<leader>rr', '<cmd>OverseerRun<cr>', opts)

-- Nvim DAP
local dap = require('dap')
keyset('n', '<leader>db', dap.toggle_breakpoint, opts)
keyset('n', '<leader>dc', dap.continue, opts)
keyset('n', '<leader>do', dap.step_over, opts)
keyset('n', '<leader>di', dap.step_into, opts)
keyset('n', '<leader>dr', dap.repl.open, opts)
