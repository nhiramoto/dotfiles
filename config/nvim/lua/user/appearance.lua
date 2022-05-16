
vim.opt.cursorline = true
vim.o.guifont = 'BlexMono Nerd Font:h10'
vim.opt.termguicolors = true

vim.cmd [[hi Comment cterm=italic]]
vim.cmd [[set background=dark]]

local colorscheme = 'tokyodark'

-- Material theme variant
vim.g.material_style = 'darker'

if colorscheme == 'kanagawa' then
    require('kanagawa').setup({
        commentStyle = 'italic'
    })
elseif colorscheme == 'material' then
    require('material').setup({
        italics = {
            comments = true,
            keywords = true,
            functions = false,
            strings = false,
            variables = false
        }
    })
end

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ok then
    vim.notify('Color scheme ' .. colorscheme .. ' not found!')
end


