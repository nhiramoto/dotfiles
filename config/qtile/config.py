import os
import subprocess
from libqtile.config import Key, Screen, Group, ScratchPad, DropDown, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

try:
    from typing import List  # noqa: F401
except ImportError:
    pass

sup = "mod4"
alt = "mod1"
ctrl = "control"
shift = "shift"

term = "termite"

# Autostart {{{

@hook.subscribe.startup
def autorestart():
    home = os.path.expanduser('~/.config/qtile/autorestart.sh')
    subprocess.call([home])

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

# }}}

keys = [
    # Switch between windows in current stack pane
    Key([sup], "h", lazy.layout.left()),
    Key([sup], "j", lazy.layout.down()),
    Key([sup], "k", lazy.layout.up()),
    Key([sup], "l", lazy.layout.right()),

    # Move windows up or down in current stack
    Key([sup, shift], "k", lazy.layout.shuffle_down()),
    Key([sup, shift], "j", lazy.layout.shuffle_up()),
    Key([sup, shift], "h", lazy.layout.swap_left()),
    Key([sup, shift], "l", lazy.layout.swap_right()),

    Key([sup], 'u', lazy.layout.grow()),
    Key([sup], 'i', lazy.layout.shrink()),

    Key([sup, ctrl], 'n', lazy.layout.normalize()),
    Key([sup, ctrl], 'm', lazy.layout.maximize()),

    # Switch layout
    Key([sup], "Tab", lazy.next_layout()),
    Key([sup, shift], "Tab", lazy.previous_layout()),

    Key([sup], ',', lazy.layout.previous()),
    Key([sup], '.', lazy.layout.next()),

    # Swap panes of split stack
    Key([sup, ctrl], 'r', lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([sup, shift], "Return", lazy.layout.toggle_split()),
    Key([sup], "Return", lazy.spawn(term)),

    # Toggle between different layouts as defined below
    Key([sup, shift], "q", lazy.window.kill()),

    Key([sup, ctrl], "r", lazy.restart()),
    Key([sup, ctrl], "q", lazy.shutdown()),

    Key([sup], 'f', lazy.window.toggle_floating()),
    Key([sup, shift], 'f', lazy.window.toggle_fullscreen()),

    Key([sup], 'space', lazy.spawn('rofi -show drun')),
    Key([sup, shift], 'space', lazy.spawn('rofi -show run')),

    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer set Master 5%+')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer set Master 5%-')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer set Master toggle')),
    Key([], 'XF86AudioPlay', lazy.spawn('mpc toggle || playerctl play-pause')),
    Key([], 'XF86AudioNext', lazy.spawn('mpc next || playerctl next')),
    Key([], 'XF86AudioPrev', lazy.spawn('mpc prev || playerctl previous')),
    Key([], 'XF86AudioStop', lazy.spawn('mpc stop || playerctl stop')),

    Key([], 'XF86MonBrightnessUp', lazy.spawn('xbacklight -inc 5')),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('xbacklight -dec 5')),

    Key([], 'XF86Reload', lazy.restart()),

    Key([sup], 'w', lazy.spawn('google-chrome-stable')),
    Key([sup], 'r', lazy.spawn(term + ' -e ranger')),
    Key([sup, shift], 't', lazy.spawn('~/.script/touchpad.sh toggle')),
    Key([sup], 'n', lazy.spawn(term + ' -e ncmpcpp'))
]

# Groups {{{
groups = [
    ScratchPad('scratchpad', [
        DropDown('term', term,
            x=0.0, y=0.0, width=1.0, height=0.6, opacity=0.95, on_focus_lost_hide=True
        )
    ])
]
groups.extend([Group(str(i)) for i in range(1, 11)])

# Switching groups
for group in list(filter(lambda g: type(g) is Group, groups[:-1])):
    keys.extend([
        # Switch to workspace by sup+position
        Key([sup], group.name, lazy.group[group.name].toscreen()),

        # sup1 + shift + letter of group = switch to & move focused window to group
        Key([sup, shift], group.name, lazy.window.togroup(group.name)),

        # Toggle dropdown terminal visibility
        Key([sup, shift], 'space', lazy.group['scratchpad'].dropdown_toggle('term'))
    ])
keys.extend([
    Key([sup], '0', lazy.group['10'].toscreen()),
    Key([sup, shift], '0', lazy.window.togroup('10'))
])
# }}}

layout_theme = {
    "border_width": 2,
    "border_normal": "#1c1c1c",
    "border_focus": "#8fafd7",
    "margin": 2
}

layouts = [
    layout.Max(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Zoomy(**layout_theme)
]

widget_defaults = dict(
    font='Exo 2 Medium',
    fontsize=12,
    padding=5,
    border_color='#8FAFD7'
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                #widget.CurrentLayoutIcon(scale=0.5),
                widget.CurrentLayout(),
                widget.TextBox(text='::'),
                widget.Prompt(),
                widget.WindowName(),
                widget.CPUGraph(width=40, border_width=0, samples=50),
                widget.MemoryGraph(width=40),
                widget.TextBox(text='Pacman:'),
                widget.Pacman(),
                widget.TextBox(text='Backlight:'),
                widget.Backlight(backlight_name='intel_backlight', format='{percent: 2.0%}'),
                widget.TextBox(text='VOL:'),
                widget.Volume(emoji=True),
                widget.TextBox(text='BAT:'),
                widget.Battery(format='{char} {percent:2.0%} {hour:d}:{min:02d}'),
                widget.Clock(format='%I:%M'),
                widget.Systray(),
            ],
            28,
            background='#262626',
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.WindowName(),
                widget.Clock(format='%I:%M')
            ],
            28,
        )
    )
]

# Drag floating layouts.
mouse = [
    Drag([sup], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([sup], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([sup], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"

