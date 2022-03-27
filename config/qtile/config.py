import os
import subprocess
import random

from typing import List

from libqtile import hook, bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


###############################################################################
### Vars
###############################################################################
qtile_home = os.path.expanduser('~/.config/qtile')

# Keys
mod = 'mod4'
alt = 'mod1'
ctrl = 'control'
shift = 'shift'
space = 'space'
enter = 'Return'
tab = 'Tab'
esc = 'Escape'

# Fonts
font = 'BlexMono Nerd Font SemiBold'
font_bold = 'BlexMono Nerd Font Bold'
font_size = 13

# Applications
terminal = 'alacritty'
launcher = 'rofi -show drun'
browser = 'google-chrome-stable'
editor = 'neovide'
player = terminal + ' -e ncmpcpp'

# System
lock_screen = 'betterlockscreen -l pixel'
suspend = 'systemctl suspend'

# Colors
colors = {
    'bg': '#1C1C1C',
    'bga': '#282C34',
    'fg': '#ABB2BF',
    'black0': '#5C6370',
    'black1': '#4B5263',
    'white0': '#ABB2BF',
    'white1': '#3E4452',
    'red0': '#E06C75',
    'red1': '#BE5046',
    'yellow0': '#E5C07B',
    'green': '#98C379',
    'pink': '#C678DD',
    'blue0': '#61AFEF',
    'blue1': '#61AFEF',
    'cyan': '#56B6C2',
}

# Gradients
gradients = [
    ['#8FBCBB', '#88C0D0'],
    ['#8FBCBB', '#81A1C1'],
    ['#8FBCBB', '#5E81AC'],
    ['#88C0D0', '#81A1C1'],
    ['#81A1C1', '#5E81AC']
]

# Icons
icons = {
    'clock': '\uf017',
    'calendar': '\uf133',
    'volume': '\uf027',
    'chip': '\uf2db',
    'browser': '\ue743',
    'code': '\ue696',
    'terminal': '\uf120',
    'tools': '\uf7d9',
    'remote': '\ue066',
    'music': '\ue405',
    'cube': '\uf1b2',
    'network': '\uf6ff',
    'hdd': '\uf0a0',
    'python': '\ue606',
    '1': '\u3044\u3061',
    '2': '\u306b',
    '3': '\u3055\u3093',
    '4': '\u3087\u3093',
    '5': '\u3054',
    '6': '\u308d\u304f',
    '7': '\u306a\u306a',
    '8': '\u306f\u3061',
    '9': '\u304d\u3085\u3046',
    '10': '\u3058\u3085\u3046',
}

# Layout Theme
layout_theme = {
    'border_width': 3,
    'margin': 5,
    'border_focus': colors['blue0'],
    'border_normal': colors['bga'],
    'font': font,
    'grow_amount': 2,
}

###############################################################################
### Functions
###############################################################################

volume_script = os.path.expanduser('~/.scripts/volume')

def volume_up(qtile):
    subprocess.call([volume_script, 'up'])

def volume_down(qtile):
    subprocess.call([volume_script, 'down'])

def volume_toggle(qtile):
    subprocess.call([volume_script, 'toggle'])

###############################################################################
### Autostart
###############################################################################
@hook.subscribe.startup
def autorestart():
    autorestart_script = qtile_home + '/autorestart.sh'
    subprocess.call([autorestart_script])

@hook.subscribe.startup_once
def autostart():
    autostart_script = qtile_home + '/autostart.sh'
    subprocess.call([autostart_script])

###############################################################################
### Keybindings
###############################################################################
keys = [
    # Switch between windows
    Key([mod], 'h', lazy.layout.left(), desc='Move focus to left'),
    Key([mod], 'l', lazy.layout.right(), desc='Move focus to right'),
    Key([mod], 'j', lazy.layout.down(), desc='Move focus down'),
    Key([mod], 'k', lazy.layout.up(), desc='Move focus up'),
    Key([mod], space, lazy.layout.next(),
        desc='Move window focus to other window'),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, shift], 'h', lazy.layout.shuffle_left(),
        desc='Move window to the left'),
    Key([mod, shift], 'l', lazy.layout.shuffle_right(),
        desc='Move window to the right'),
    Key([mod, shift], 'j', lazy.layout.shuffle_down(),
        desc='Move window down'),
    Key([mod, shift], 'k', lazy.layout.shuffle_up(),
        desc='Move window up'),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, ctrl], 'h', lazy.layout.grow_left(),
        desc='Grow window to the left'),
    Key([mod, ctrl], 'l', lazy.layout.grow_right(),
        desc='Grow window to the right'),
    Key([mod, ctrl], 'j', lazy.layout.grow_down(),
        desc='Grow window down'),
    Key([mod, ctrl], 'k', lazy.layout.grow_up(),
        desc='Grow window up'),
    Key([mod, ctrl], 'n', lazy.layout.normalize(),
        desc='Reset all window sizes'),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, shift], enter, lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'),

    # Launch Applications
    Key([mod], enter, lazy.spawn(terminal), desc='Launch terminal'),
    Key([mod], 'z', lazy.spawn(terminal), desc='Launch terminal'),
    Key([mod], 'w', lazy.spawn(browser)),
    Key([mod], 'e', lazy.spawn(editor)),
    Key([mod], 'n', lazy.spawn(player)),
    Key([mod], space, lazy.spawn(launcher)),
    # Key([mod], 'a', lazy.spawn(rofi_apps)),
    # Key([mod, shift], space, lazy.spawn(rofi_quicklinks)),
    # Key([mod], 'm', lazy.spawn(rofi_mpd)),

    # Toggle between different layouts as defined below
    Key([mod], tab, lazy.next_layout(), desc='Toggle between layouts'),
    Key([mod], 'q', lazy.window.kill(), desc='Kill focused window'),
    Key([alt], 'F4', lazy.window.kill(), desc='Kill focused window'),

    # System
    Key([mod, ctrl], 'r', lazy.restart(), desc='Restart Qtile'),
    Key([mod, ctrl], 'q', lazy.shutdown(), desc='Shutdown Qtile'),
    Key([mod], 'r', lazy.spawncmd(),
        desc='Spawn a command using a prompt widget'),
    Key([mod, ctrl], 'o', lazy.spawn(lock_screen), desc='Lock screen'),
    Key([mod, ctrl], 'p', lazy.spawn(suspend), desc='Lock and suspend system.'),

    # Media
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer sset Master 5%+')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer sset Master 5%-')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer sset Master toggle')),
    Key([mod], 'Up', lazy.spawn('amixer sset Master 5%+')),
    Key([mod], 'Down', lazy.spawn('amixer sset Master 6%-')),
]

###############################################################################
### Groups (workspaces)
###############################################################################

workspaces = [
    { 'label': icons['browser'], 'name': '1', 'key': '1', 'matches': [] },
    { 'label': icons['code'], 'name': '2', 'key': '2', 'matches': [] },
    { 'label': icons['terminal'], 'name': '3', 'key': '3', 'matches': [] },
    { 'label': icons['tools'], 'name': '4', 'key': '4', 'matches': [] },
    { 'label': icons['5'], 'name': '5', 'key': '5', 'matches': [] },
    { 'label': icons['6'], 'name': '6', 'key': '6', 'matches': [] },
    { 'label': icons['7'], 'name': '7', 'key': '7', 'matches': [] },
    { 'label': icons['8'], 'name': '8', 'key': '8', 'matches': [] },
    { 'label': icons['music'], 'name': '9', 'key': '9', 'matches': [] },
]

groups = []

for ws in workspaces:
    matches = ws['matches'] if 'matches' in ws else None
    groups.append(Group(ws['name'], label=ws['label'], matches=matches))
    keys.extend([
        Key([mod], ws['key'], lazy.group[ws['name']].toscreen(),
            desc='Switch to group {}'.format(ws['label']) ),

        Key([mod, shift], ws['key'], lazy.window.togroup(ws['name'], switch_group=False),
            desc='Move focused window to group {}'.format(ws['label'])),
    ])

###############################################################################
### Layouts
###############################################################################
layouts = [
    layout.Bsp(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# Floating Windows
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),
    Match(wm_class='makebranch'),
    Match(wm_class='maketag'),
    Match(wm_class='ssh-askpass'),
    Match(wm_class='gnome-calculator'),
    Match(title='branchdialog'),
    Match(title='pinentry'),
])

widget_defaults = dict(
    font=font,
    fontsize=font_size,
    padding=16,
    foreground=colors['fg'],
    background=colors['bg']
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(padding=10, foreground=colors['bg']),
                widget.TextBox(
                    text=icons['python'],
                    foreground=colors['blue0'],
                    fontsize=20
                ),
                widget.GroupBox(
                    highlight_color=colors['bga'],
                    highlight_method='line',
                    block_highlight_text_color=colors['blue1'],
                    this_current_screen_border=colors['blue1'],
                    # this_screen_border='',
                    other_current_screen_border=colors['green'],
                    # other_screen_border=colors['green'],
                    foreground=colors['fg'],
                    background=colors['bg'],
                    hide_unused=True,
                    #padding=10,
                    rounded=True,
                    font=font,
                    fontsize=20
                ),
                widget.Prompt(),
                widget.WindowName(
                    max_chars = 80
                ),
                widget.Chord(
                    chords_colors={
                        'launch': ('#ff0000', '#ffffff'),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.CheckUpdates(
                    display_format='<span foreground="' + colors['yellow0'] + '">' + icons['cube'] + '</span>  {updates}',
                    custom_command='checkupdates+aur',
                ),
                widget.DF(
                    fmt=icons['hdd'] + '  {}',
                    measure='G',
                    warn_space=43,
                    visible_on_warn=True,
                    warn_color=colors['fg'],
                ),
                widget.Bluetooth(),
                widget.CPUGraph(
                    type='box',
                    border_width=1,
                    border_color=colors['bga']
                ),
                widget.Volume(
                    fmt='<span foreground="' + colors['blue0'] + '">' + icons['volume'] + '</span>  {}'
                ),
                widget.Clock(
                    fmt='<span foreground="' + colors['pink'] + '">' + icons['clock'] + '</span>  {}',
                    format='%H:%M'
                    #foreground=colors['pink']
                ),
                widget.Clock(
                    fmt='<span foreground="' + colors['green'] + '">' + icons['calendar'] + '</span>  {}',
                    format='%a %d/%m/%Y'
                ),
                widget.CurrentLayoutIcon(
                    margin=10,
                    scale=.6,
                    foreground=colors['fg']
                ),
                widget.Systray(),
                # widget.QuickExit(),
                widget.Sep(padding=10, foreground=colors['bg']),
            ],
            28,
            background=colors['bg']
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.Sep(padding=10, foreground=colors['bg']),
                widget.TextBox(
                    text=icons['python'],
                    foreground=colors['blue0'],
                    fontsize=20
                ),
                widget.GroupBox(
                    highlight_color=colors['bga'],
                    highlight_method='line',
                    block_highlight_text_color=colors['blue1'],
                    this_current_screen_border=colors['blue1'],
                    # this_screen_border='',
                    other_current_screen_border=colors['green'],
                    # other_screen_border=colors['green'],
                    foreground=colors['fg'],
                    background=colors['bg'],
                    hide_unused=True,
                    #padding=10,
                    rounded=True,
                    font=font,
                    fontsize=20
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ('#ff0000', '#ffffff'),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Sep(padding=10, foreground=colors['bg']),
            ],
            28,
            background=colors['bg']
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = 'smart'

wmname = 'LG3D'
