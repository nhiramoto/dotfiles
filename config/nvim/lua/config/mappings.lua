-- Tabs/Buffers
vim.keymap.set('n', '<leader>tc', '<cmd>tabe<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sh', '<cmd>split<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<cr>', { noremap = true, silent = true })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
vim.keymap.set('n', '<leader>te', function()
  require('telescope').extensions.file_browser.file_browser()
end)
vim.keymap.set('n', '<leader>st', '<cmd>vsplit<bar>Telescope find_files<cr>', { noremap = true, silent = true })

-- Nvim Tree
vim.keymap.set('n', '<C-f>', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
