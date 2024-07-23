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
      }
    }
  end
}
