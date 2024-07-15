local wezterm = require 'wezterm';

local config = wezterm.config_builder()

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
end

config.initial_rows = 40
config.initial_cols = 120
config.color_scheme = 'Kanagawa Dragon (Gogh)'
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 10.5
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'TITLE | RESIZE'
config.window_close_confirmation = 'AlwaysPrompt'
config.keys = {
    { key='w', mods='ALT', action=wezterm.action{CloseCurrentPane={confirm=false}} },
    { key='q', mods='ALT|SHIFT', action=wezterm.action{CloseCurrentPane={confirm=true}} },
    { key='h', mods='ALT', action=wezterm.action{ActivatePaneDirection="Left"} },
    { key='j', mods='ALT', action=wezterm.action{ActivatePaneDirection="Down"} },
    { key='k', mods='ALT', action=wezterm.action{ActivatePaneDirection="Up"} },
    { key='l', mods='ALT', action=wezterm.action{ActivatePaneDirection="Right"} },
    { key='l', mods='ALT|SHIFT', action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}} },
    { key='j', mods='ALT|SHIFT', action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}} },
    { key='t', mods='CTRL', action=wezterm.action{SpawnTab="CurrentPaneDomain"} },
    { key='x', mods='ALT', action="ShowLauncher" },
}
config.launch_menu = {
    {
        label = "Bash",
        args = { "bash", "-l" },
        cwd = "~"
    }
}

return config