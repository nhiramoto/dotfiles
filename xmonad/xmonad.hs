import System.IO
import System.Exit

import XMonad
import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Circle
import XMonad.Layout.Column
import XMonad.Layout.Cross
import XMonad.Layout.Dishes
import XMonad.Layout.DragPane
import XMonad.Layout.Dwindle
import XMonad.Layout.FixedColumn
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.ZoomRow
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import Graphics.X11.ExtraTypes.XF86

import Data.Char
import Data.Bits ((.|.))
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myBar         = "xmobar"
myTerminal    = "termite"
myLauncher    = "rofi -show drun"
myModMask     = mod4Mask -- Win key or Super_L

-- Borders
myBorderWidth = 3
myNormalBorderColor = "#1C1C1C"
myFocusedBorderColor = "#8FAFD7"

-- Startup commands
myStartupHook = do
    spawn "feh --bg-fill /home/segfault/Pictures/default.png"
    spawn "/home/segfault/.config/compton/launch.sh"
    spawn "/home/segfault/.config/conky/launch.sh"
    spawn "/home/segfault/.dropbox-dist/dropboxd"
    spawn "udiskie"

-- Workspaces
myWorkspaces = map show $ [1..9] ++ [0]
myWorkspaceKeys = [xK_1..xK_9] ++ [xK_0]

-- Layouts
myLayouts = emptyBSP ||| mouseResizableTile ||| zoomRow

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

    -- Kill current window
    , ((myModMask .|. shiftMask, xK_q), kill)

    -- Quit and Restart XMonad
    , ((myModMask, xK_Escape), io (exitWith ExitSuccess))
    , ((myModMask .|. shiftMask, xK_Escape), broadcastMessage ReleaseResources >> restart "xmonad" True)

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

myPP = xmobarPP
    { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
    , ppOrder = \(ws:_:t:_) -> [ws, t]
    }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig
    { terminal           = myTerminal
    , modMask            = myModMask
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces
    , startupHook        = myStartupHook
    , layoutHook         = avoidStruts $ smartBorders $ myLayouts
    , keys               = myKeys
    }

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
