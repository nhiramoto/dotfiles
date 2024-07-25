return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    local flutterConfig = require("flutter-tools")

    flutterConfig.setup {
      ui = {
        border = 'rounded',
        notification_style = 'native'
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true
        }
      },
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        prefix = '// ...'
      },
      lsp = {
        color = {
          enabled = true,
        },
        settings = {
          completeFunctionCalls = true,
          renameFilesWithClasses = 'prompt',
          updateImportsOnRename = true,
        }
      },
      dev_log = {
        open_cmd = 'tabedit',
      },
      debugger = {
        enabled = true,
        register_configurations = function(paths)
          local dap = require('dap')
          local flutterExec = vim.fn.resolve(vim.fn.exepath('flutter'))
          dap.adapters.dart = {
            type = 'executable',
            command = vim.fn.exepath('cmd'),
            args = { '/c', flutterExec, 'debug_adapter' },
            options = {
              detached = false,
            },
          }
          dap.configurations.dart = {}
        end
      }
    }
  end
}
