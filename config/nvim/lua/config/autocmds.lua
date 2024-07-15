vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.java' },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
  end
})
