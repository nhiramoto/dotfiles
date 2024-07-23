local project_root = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]);
local data_dir = project_root .. '/.nvim-jdtls'
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '-jar', 'C:\\jdtls\\plugins\\org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    '-configuration', 'C:\\jdtls\\config_win',
    '-data', data_dir
  },
  root_dir = project_root,
}
require('jdtls').start_or_attach(config)
