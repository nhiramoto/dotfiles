-- Defina essas variáveis
-- * JDTLS_HOME: Pasta de instalação do JDTLS
-- * JAVA2x_HOME: pasta de instalação do Java da versão 20 ou acima
-- * NVIM_WORKSPACE: Pasta do workspace para manter dados pro projeto
-- * JAVA_DEBUG: Pasta do java-debug.

local project_root = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]);
local jdtlsHome = vim.env.JDTLS_HOME
local javaExec = vim.fs.joinpath(vim.env.JAVA2x_HOME, 'bin', 'java')
local nvimWorkspace = vim.env.NVIM_WORKSPACE
local javaDebug = vim.env.JAVA_DEBUG

local data_dir = vim.fs.joinpath(nvimWorkspace, vim.fs.basename(project_root))

local config = {
  cmd = {
    javaExec,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. vim.fs.joinpath(jdtlsHome, 'lombok.jar'),
    '-jar', vim.fs.joinpath(jdtlsHome, 'plugins', 'org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'),
    '-configuration', vim.fs.joinpath(jdtlsHome, 'config_win'),
    '-data', data_dir
  },
  -- root_dir = project_root,
}
config['init_options'] = {
  bundles = {
    vim.fn.glob(vim.fs.joinpath(javaDebug, 'com.microsoft.java.debug.plugin', 'target', 'com.microsoft.java.debug.plugin-0.53.0.jar'), 1)
  }
}
require('jdtls').start_or_attach(config)
