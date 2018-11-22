import XMonad
import XMonad.Hooks.DynamicLog

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar         = "xmobar"

myTerminal    = "termite"
myLauncher    = "rofi -show drun"
myModMask     = mod4Mask -- Win key or Super_L

myBorderWidth = 3
myNormalBorderColor = "#1C1C1C"
myFocusedBorderColor = "#8FAFD7"

myStartupHook = do
    spawn "feh --bg-fill /home/segfault/Pictures/default.png"

workspaceIcons =
  [ "\xe17f"
  , "\xe180"
  , "\xe184"
  , "\xe185"
  , "\xe186"
  , "\xe183"
  ]

workspaceNames =
  [ "Browser"
  , "Code"
  , "*"
  , "*"
  , "*"
  , "Media"
  ]

myWorkspaces = wrapWorkspaces workspaceIcons $ workspaceNames
  where
    wrapWorkspaces icons workspaces =
      [ "<fn=1>" ++ i ++ "</fn> " ++ ws | (i, ws) <- zip icons workspaces ]

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig
    { terminal           = myTerminal
    , modMask            = myModMask
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces
    , startupHook        = myStartupHook
    }
