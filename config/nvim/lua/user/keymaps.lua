local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

local amap = function (lhs, rhs) return keymap('', lhs, rhs, opts) end
local nmap = function (lhs, rhs) return keymap('n', lhs, rhs, opts) end
local imap = function (lhs, rhs) return keymap('i', lhs, rhs, opts) end
local vmap = function (lhs, rhs) return keymap('v', lhs, rhs, opts) end

-- Map Space as Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Editor
vmap('<', '<gv')
vmap('>', '>gv')

-- Telescope
nmap('<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<CR>)')
nmap('<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<CR>)')
nmap('<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<CR>)')
nmap('<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<CR>)')

nmap('<leader>pp',
        ':lua require\'telescope\'.extensions.project.project{}<CR>')

-- Nvim Tree
amap('<C-n>', '<cmd>NvimTreeToggle<cr>')

