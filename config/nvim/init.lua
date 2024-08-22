if vim.g.vscode then
  local settings = vim.fs.joinpath(vim.env.LOCALAPPDATA, 'nvim', 'settings.vim')
  vim.cmd('source ' .. settings)
else
  require('config.leader')
  require('config.lazy')
  require('config.options')
  require('config.autocmds')
  require('config.mappings')
  require('config.colors')
end
