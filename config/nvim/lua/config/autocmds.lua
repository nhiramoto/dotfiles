vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.java' },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Regra para fixar buffer usando stickybuf.',
  callback = function()
    local stickybuf = require('stickybuf')
    local bufname = vim.fn.expand('%')
    if not stickybuf.is_pinned() and bufname == '__FLUTTER_DEV_LOG__' then
      stickybuf.pin()
    end
  end
})
