local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local jdtls_home = vim.fn.expand('~/.local/share/nvim/lsp_servers/jdtls')
local launcher_jar = 'org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
print('ftplugin:java: project_name=' .. project_name .. ', jdtls_home=' .. jdtls_home .. ', launcher_jar=' .. launcher_jar)

local ok, jdtls = pcall(require, 'jdtls')
if not ok then
    vim.notify('Error while importing jdtls. ' .. jdtls)
    return
end
local ok_2, jdtls_setup = pcall(require, 'jdtls.setup')
if not ok_2 then
    vim.notify('Error while importing jdtls.setup. ' .. jdtls_setup)
    return
end

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java11_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',

    -- 💀
    '-jar', jdtls_home .. '/plugins/' .. launcher_jar,

    -- 💀
    '-configuration', jdtls_home .. '/config_linux',

    -- 💀
    -- See `data directory configuration` section in the README
    '-data', jdtls_home .. '/workspace/' .. project_name
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = jdtls_setup.find_root({'.git', 'mvnw', 'gradlew'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
