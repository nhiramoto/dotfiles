local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- General Settings

opt.autoread = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false
opt.hidden = true
opt.synmaxcol = 240
opt.encoding = 'utf-8'
vim.wo.wrap = false

-- Editing

opt.number = true
opt.relativenumber = true
opt.splitright = true
opt.splitbelow = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Searching

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Backup

opt.backup = false
opt.writebackup = false
opt.swapfile = false

