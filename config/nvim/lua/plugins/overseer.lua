return {
  'stevearc/overseer.nvim',
  opts = {
    task_list = {
      direction = 'right',
      bindings = {
        ['?'] = 'ShowHelp',
        ['g?'] = 'ShowHelp',
        ['F'] = 'OpenFloat',
        ['E'] = 'Edit',
        ['S'] = 'Stop',
      }
    }
  },
}
