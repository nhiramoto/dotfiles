return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local neogit = require('neogit')
    neogit.setup({
      kind = 'split'
    })
    local opts = { silent = true, noremap = true }
    vim.keymap.set('n', '<leader>gs', neogit.open, opts)
    vim.keymap.set('n', '<leader>gc', '<cmd>Neogit commit<cr>', opts)
    vim.keymap.set('n', '<leader>gp', '<cmd>Neogit pull<cr>', opts)
    vim.keymap.set('n', '<leader>gP', '<cmd>Neogit push<cr>', opts)
    vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', opts)
    vim.keymap.set('n', '<leader>gm', '<cmd>Neogit merge<cr>', opts)
  end
}
