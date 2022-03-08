local wezterm = require 'wezterm';

return {
    initial_rows = 40,
    initial_cols = 120,
    color_scheme = 'Tomorrow Night',
    font = wezterm.font("CaskaydiaCove Nerd Font"),
    font_size = 10.5,
    use_fancy_tab_bar = false,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = 'TITLE | RESIZE',
    window_close_confirmation = 'AlwaysPrompt',
    keys = {
        { key='w', mods='ALT', action=wezterm.action{CloseCurrentPane={confirm=false}} },
        { key='w', mods='CTRL', action=wezterm.action{CloseCurrentTab={confirm=true}} },
        { key='h', mods='ALT', action=wezterm.action{ActivatePaneDirection="Left"} },
        { key='j', mods='ALT', action=wezterm.action{ActivatePaneDirection="Down"} },
        { key='k', mods='ALT', action=wezterm.action{ActivatePaneDirection="Up"} },
        { key='l', mods='ALT', action=wezterm.action{ActivatePaneDirection="Right"} },
        { key='l', mods='ALT|SHIFT', action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}} },
        { key='j', mods='ALT|SHIFT', action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}} },
        { key='t', mods='CTRL', action=wezterm.action{SpawnTab="CurrentPaneDomain"} },
        { key='x', mods='ALT', action="ShowLauncher" },
    },
    launch_menu = {
        {
            label = "Bash",
            args = { "bash", "-l" },
            cwd = "~"
        }
    }
}
