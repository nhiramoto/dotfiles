import System.IO
import System.Exit

import XMonad
import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Circle
import XMonad.Layout.Column
import XMonad.Layout.Grid
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ZoomRow
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import Graphics.X11.ExtraTypes.XF86

import Data.Char
import Data.Bits ((.|.))
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myBar         = "xmobar /home/hyokan/.xmonad/xmobar/xmobarrc"
myTerminal    = "termite"
myLauncher    = "rofi -show drun"
myModMask     = mod4Mask -- Win key or Super_L

-- Borders
myBorderWidth = 3
myNormalBorderColor = "#1C1C1C"
myFocusedBorderColor = "#8FAFD7"

-- Startup commands
myStartupHook = do
    spawn "xrdb -merge ~/.Xresources"
    spawn "xfce4-power-manager"
    spawn "feh --bg-fill /home/hyokan/Pictures/default.png"
    spawn "/home/hyokan/.config/compton/launch.sh"
    spawn "/home/hyokan/.config/conky/launch.sh"
    spawn "/home/hyokan/.dropbox-dist/dropboxd"
    spawn "setxkbmap -option ctrl:swapcaps"
    spawn "stalonetray"
    spawn "nm-applet"
    spawn "udiskie"

-- Workspaces
myWorkspaces = ["1: \xf0ac", "2: \xf121"] ++ map show ([3..9]) ++ ["10: \xf001"]
myWorkspaceKeys = [xK_1..xK_9] ++ [xK_0]

-- Layouts
-- myLayouts = windowNavigation . subTabbed $ Tall 1 (3/100) (1/2) ||| Accordion ||| Grid ||| emptyBSP ||| Circle ||| zoomRow
myLayouts = avoidStruts . smartBorders $ Tall 1 (3/100) (1/2) ||| Accordion ||| Grid ||| emptyBSP ||| Circle ||| zoomRow

-- Keybindings
myKeys conf@(XConfig { XMonad.modMask = modMask }) =
  M.fromList $
    [
    ((myModMask, xK_Return), spawn myTerminal)
    , ((myModMask, xK_space), spawn myLauncher)

    , ((myModMask, xK_Tab), sendMessage NextLayout)
    , ((myModMask .|. shiftMask, xK_Tab), setLayout $ XMonad.layoutHook conf)

    -- Focus and Movements
    , ((myModMask, xK_j), windows W.focusDown)
    , ((myModMask, xK_k), windows W.focusUp)
    , ((myModMask .|. shiftMask, xK_j), windows W.swapDown)
    , ((myModMask .|. shiftMask, xK_k), windows W.swapUp)
    , ((myModMask, xK_h), sendMessage Shrink) -- Shrink master area
    , ((myModMask, xK_l), sendMessage Expand) -- Expand master area
    , ((myModMask, xK_t), withFocused $ windows . W.sink) -- Push window back into tiling
    , ((myModMask .|. shiftMask, xK_m), windows W.swapMaster) -- Swap focused window with master window

    -- subTabbed
    , ((myModMask .|. controlMask, xK_h), sendMessage $ pullGroup L)
    , ((myModMask .|. controlMask, xK_l), sendMessage $ pullGroup R)
    , ((myModMask .|. controlMask, xK_k), sendMessage $ pullGroup U)
    , ((myModMask .|. controlMask, xK_j), sendMessage $ pullGroup D)

    , ((myModMask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
    , ((myModMask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))

    , ((myModMask, xK_period), onGroup W.focusUp')
    , ((myModMask, xK_comma), onGroup W.focusDown')

    -- Kill current window
    , ((myModMask .|. shiftMask, xK_q), kill)

    -- Quit and Restart XMonad
    , ((myModMask, xK_Escape), io (exitWith ExitSuccess))
    , ((myModMask .|. shiftMask, xK_Escape), broadcastMessage ReleaseResources >> restart "xmonad" True)
    , ((myModMask .|. controlMask, xK_x), spawn $ "kill $(pidof xmobar); " ++ myBar)

    -- myBar
    , ((myModMask, xK_b), sendMessage ToggleStruts)

    -- Launch programs
    , ((myModMask, xK_w), spawn "google-chrome-stable")
    , ((myModMask, xK_r), spawn $ myTerminal ++ " -e ranger")
    , ((myModMask, xK_n), spawn $ myTerminal ++ " -e ncmpcpp")

    -- Media Keys
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")
    , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
    , ((0, xF86XK_AudioPlay), spawn "mpc toggle || playerctl play-pause")
    , ((0, xF86XK_AudioStop), spawn "mpc stop || playerctl stop")
    , ((0, xF86XK_AudioNext), spawn "mpc next || playerctl next")
    , ((0, xF86XK_AudioPrev), spawn "mpc prev || playerctl previous")
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 5")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 5")
    ]
 ++ [
    -- Switching to workspaces
    -- If shift is pressed, send current window to that workspace
    ((m .|. modMask, wsKey), windows $ f ws)
    | (ws, wsKey) <- zip myWorkspaces myWorkspaceKeys
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
    [ [manageDocks]
    , [isFullscreen   --> setFullFloat ]
    , [resource  =? c --> doIgnore | c <- ignores ]
    , [className =? c --> doShift wsWeb | c <- browser ]
    , [className =? c --> doShift wsDev | c <- dev ]
    , [className =? c --> doShift wsMedia | c <- media ]
    , [className =? c --> doCenterFloat | c <- floats ]
    , [manageHook defaultConfig]
    ]) 
    where
        -- classnames
        floats  = ["Smplayer","MPlayer","VirtualBox","Xmessage","XFontSel","Downloads","Nm-connection-editor"]
        browser = ["Google-chrome", "Chromium", "Chromium-browser", "Firefox"]
        media   = ["Rhythmbox", "Spotify", "Clementine"]
        dev     = ["gnome-terminal"]
        -- resources
        ignores = ["desktop", "desktop_window", "notify-osd", "stalonetray", "trayer", "dunst", "Xonotic", "xonotic-sdl"]
        -- Workspaces
        wsWeb   = "1"
        wsDev   = "2"
        wsMedia = "10"
        -- set full float
        setFullFloat :: ManageHook
        setFullFloat = doF W.focusDown <+> doFullFloat

myPP = xmobarPP
    { ppCurrent = xmobarColor "#8FDFD7" "" . wrap "[" "]"
    , ppHidden  = xmobarColor "#BCBCBC" "" . wrap " " " "
    , ppSep     = " :: "
    , ppWsSep   = " "
    -- , ppTitle   = " "
    -- , ppLayout  = const "Title Here"
    -- , ppOrder = \(ws:_:t:_) -> [ws, t]
    }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = def
    { terminal           = myTerminal
    , modMask            = myModMask
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces
    , startupHook        = myStartupHook
    , layoutHook         = myLayouts
    , manageHook         = myManageHook
    , keys               = myKeys
    }

main :: IO ()
main = do
    xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
