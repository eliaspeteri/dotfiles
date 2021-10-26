# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Copyright (c) 2021 Elias Peteri
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from subprocess import check_output, call

try:
    from typing import List  # noqa: F401
except ImportError:
    pass

from libqtile import bar, layout, widget, hook, notify
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# mod4 = Super-key
mod = "mod4"
alt = "mod1"
ctl = "control"
shift = "shift"

#terminal = guess_terminal()
terminal = "st"

keys = [
    # Media keys
    Key(
        [],"XF86AudioMute",
        lazy.spawn("amixer --quiet set Master toggle"),
        desc="Mute audio"
    ),
    Key(
        [],"XF86AudioLowerVolume",
        lazy.spawn("amixer --quiet sset Master 5%-"),
        desc="Decrease audio volume"
    ),
    Key(
        [],"XF86AudioRaiseVolume",
        lazy.spawn("amixer --quiet set Master 5%+"),
        desc="Increase audio volume"
    ),
    Key(
        [],"XF86AudioMicMute",
        lazy.spawn("amixer --quiet set Capture toggle"),
        desc="Mute mic capture"
    ),
    Key(
        [],"XF86MonBrightnessDown",
        lazy.spawn("brightnessctl set 10%-"),
        desc="Decrease monitor brightness"
    ),
    Key(
        [],"XF86MonBrightnessUp",
        lazy.spawn("brightnessctl set 10%+"),
        desc="Increase monitor brightness"
    ),

    # System keys
    #Key(
    # [], "XF86WebCam",
    # lazy.spawn("sh ~/code/github/toggle-webcam/togglecamera.sh"),
    # desc="Toggle WebCam"
    # ),
    Key(
        [], "XF86WLAN",
        lazy.spawn("sh ~/toggle-wifi.sh"),
        desc="Toggle WLAN"
    ),
    #Key(
    # [], "XF86Option",
    # lazy.spawn("echo 'Opening Options'"),
    # desc="Open Options"
    # ),
    #Key(
    # [], "XF86Search",
    # lazy.spawn("echo 'Opening Search"),
    # desc="Open Search"
    # ),

    # Control the notify widget
    Key(
        [mod], "n",
        lazy.widget['notify'].toggle()
    ),
    Key(
        [mod, alt], "n",
        lazy.widget['notify'].prev()
    ),
    Key(
        [mod, alt], "m",
        lazy.widget['notify'].next()
    ),

    # Switch between windows
    Key(
        [mod], "h",
        lazy.layout.left(),
        desc="Move focus to left"
    ),
    Key(
        [mod], "l",
        lazy.layout.right(),
        desc="Move focus to right"
    ),
    Key(
        [mod], "j",
    
        lazy.layout.down(),
        desc="Move focus down"
    ),

    Key(
        [mod], "k",
    
        lazy.layout.up(),
        desc="Move focus up"
    ),

    Key(
        [alt], "Tab",
        lazy.layout.next(),
        desc="Move window focus to the next window"
    ),

    Key(
        [alt, shift], "Tab",
        lazy.layout.previous(),
        desc="Move window to focus to the previous window"
    ),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, shift],"h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"
    ),
    Key(
        [mod, shift], "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"
    ),
    Key(
        [mod, shift], "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"
    ),
    Key(
        [mod, shift], "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"
    ),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, ctl], "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"
    ),
    Key(
        [mod, ctl], "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"
    ),
    Key(
        [mod, ctl], "j",
        lazy.layout.grow_down(),
        desc="Grow window down"
    ),
    Key(
        [mod, ctl], "k",
        lazy.layout.grow_up(),
        desc="Grow window up"
    ),
    Key(
        [mod], "n",
        lazy.layout.normalize(),
        desc="Reset all window sizes"
    ),

    Key(
        [mod], "q",
        lazy.findwindow()
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, shift], "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"
    ),
    Key(
        [mod], "Return",
        lazy.spawn(terminal),
        desc="Launch terminal"
    ),

    # Toggle between different layouts as defined below
    Key(
        [mod], "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts"
    ),
    Key(
        [mod, shift], "c",
        lazy.window.kill(),
        desc="Kill focused window"
    ),

    Key(
        [mod, shift], "r",
        lazy.restart(), desc="Restart Qtile"
    ),
    Key(
        [mod, shift], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
    ),
    Key(
        [mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"
    ),
    Key(
        [mod], "Left",
        lazy.group.prevgroup()
    ),
    Key(
        [mod], "Right",
        lazy.group.nextgroup()
    ),
]

groups = [
    Group(
        name='www',
        init=True,
        matches=Match(
            title=['Mozilla Firefox',
                   'about:blank'],
            wm_class=[
                'firefox',
                'vimb',
            ],
            role=['browser'],
        ),
        layout="Max",
        position=3,
    ),
    Group(
        name='dev',
        matches=Match(
            wm_class=[
                'Code',
                'vim'
            ]
        )
    ),
    Group(
        init=True,
        name='term',
        matches=Match(
            wm_class=[
                'urxvt',
                'gnome-terminal',
                'xterm',
                'st'
            ]
        )
    ),
    Group(
        name='sdr',
        matches=Match(
            wm_class=[
                'sdrsharp',
                'gqrx',
                'rtlsdr'
            ]
        ),
        layout="Max",
    ),
    Group(
        init=True,
        name='keep',
        matches=Match(
            wm_class=['keepassxc']
        )
    ),
    Group(
        init=True,
        name='mail',
        matches=Match(
            wm_class=['Thunderbird',
                      'Claws']
        )
    ),
    Group(
        init=True,
        name='comms',
        matches=Match(
            wm_class=['Discord']
        ),
        layout="Max",
    ),
    Group(
        name='misc'
    ),
]

for index, grp in enumerate(groups):
    # index is the position in the group list grp is the group object.
    # We assign each group object a set of keys based on its
    # position in the list.

    keys.extend([
        # switch to group
        Key(
            [mod], str(index+1),
            lazy.group[grp.name].toscreen()
        ),

        # send to group
        Key(
            [mod, shift], str(index+1),
            lazy.window.togroup(grp.name)
        ),

        # swap with group
        Key(
            [alt, shift], str(index+1),
            lazy.group.swap_groups(grp.name)
        ),
    ])

layouts = [
    layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    layout.Floating(),
    # layout.Bsp(),
    layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# Screens Config

flat_theme = {"bg_dark": ["#606060", "#000000"],
              "bg_light": ["#707070", "#303030"],
              "font_color": ["#ffffff", "#cacaca"],
              
              # groupbox
              "gb_selected": ["#7ba1ba", "#215578"],
              "gb_urgent": ["#ff0000", "#820202"]
              }

gloss_theme = {"bg_dark": ["#505050",
                           "#303030",
                           "#202020",
                           "#101010",
                           "#202020",
                           "#303030",
                           "#505050"],
              "bg_light": ["#707070",
                           "#505050",
                           "#505050",
                           "#505050",
                           "#505050",
                           "#707070"],
              "font_color": ["#ffffff", "#ffffff", "#cacaca", "#707070"],
              
              # groupbox
              "gb_selected": ["#707070",
                              "#505050",
                              "#404040",
                              "#303030",
                              "#404040",
                              "#505050",
                              "#707070"],
              "gb_urgent": ["#ff0000",
                            "#820202",
                            "#820202",
                            "#820202",
                            "#820202",
                            "#ff0000"
                            ]
              }

theme = gloss_theme

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(text=u'&#9701;',fontsize=40, padding=-1,
                               font="Arial",
                               foreground=theme["bg_dark"]),
                widget.GroupBox(borderwidth=0, padding=3, margin=0,
                                highlight_method="block", rounded=False,
                                this_current_screen_border=theme["gb_selected"],
                                urgent_border=theme["gb_urgent"],
                                active=theme["font_color"],
                                background=theme["bg_dark"],
                ),
                widget.TextBox(text=u'&#9699;', fontsize=40, padding=-1,
                               font="Arial",
                               foreground=theme["bg_dark"]),
                widget.LaunchBar([
                                  ('code', 'code', 'launch vscode'),
                                  ('thunderbird', 'thunderbird', 'launch thunderbird'),
                                  ('firefox', 'firefox','launch firefox'),
                                  ('discord','discord','launch discord')
                                  ],
                                  padding=5
                ),
                widget.CurrentLayout(foreground="#a0a0a0"),
                widget.Prompt(),
                widget.Clipboard(),
                widget.Clipboard(selection="PRIMARY"),
                widget.TextBox(text=u"&#9701;", fontsize=40, padding=-1,
                               font="Arial",
                               foreground=theme["bg_dark"]),
                widget.TaskList(borderwidth=2, padding=2,
                                margin=2, highlight_method="border",
                                border=theme["gb_selected"],
                                background=theme["bg_dark"]),
                widget.Notify(),
                widget.DF(partition="/"),
                widget.TextBox(text=u" ", background=theme["bg_dark"]),
                widget.TextBox(text=u'&#9699;', fontsize=40, padding=-1,
                               font="Arial",
                               foreground=theme["bg_dark"]),
                widget.Wttr(location={'Tampere':'Tampere','Rovaniemi':'Rovaniemi'}, update_interval=30),
                widget.Sep(padding=2, height_percent=90),
                widget.CheckUpdates(),
                widget.Battery(format='{percent:2.0%} {hour:d}:{min:02d} left', low_foreground='#ff0000', low_percentage=0.25),
                widget.Sep(padding=2, height_percent=90),
                widget.Volume(update_interval=0.2, emoji=True),
                widget.Systray(icon_size=14),
                widget.Sep(padding=2, height_percent=90),
                widget.Clock(format='%d.%m.%Y %H:%M', fontsize=13, padding=6),
                widget.QuickExit(),
            ],
            size=22,
            opacity=0.9,
        ),
        wallpaper="~/Pictures/Wallpapers/3.png",
        wallpaper_mode="fill2"
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod], "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),
    Drag(
        [mod], "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click(
        [mod], "Button2",
        lazy.window.bring_to_front()
    )
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

dpi_scale = 1.0
