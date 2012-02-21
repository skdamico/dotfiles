import XMonad
import XMonad.Core
import System.IO (hPutStrLn)
import Data.Bits ((.|.))
import qualified Data.Map as M

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Man

import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps

import XMonad.Hooks.ManageDocks
import XMonad.Config (defaultConfig)

import XMonad.Actions.GridSelect
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog hiding (xmobar)
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)
import Graphics.X11

main = do
    xmobar <- spawnPipe "xmobar"
    spawn "trayer --edge top --align right --width 5 --height 10 --SetDockType true --transparent true --tint 0x000000 --expand true --distancefrom top --distance -2 --margin 140"
    xmonad $ defaultConfig
         { normalBorderColor  = myBorderColor
         , focusedBorderColor = myFocusBorderColor
         , borderWidth        = 1
         , terminal = "urxvt"
     , modMask = mod4Mask
         , logHook = dynamicLogWithPP defaultPP { ppTitle  = shorten 90
                                                , ppLayout = (>> "")
                                                , ppOutput = hPutStrLn xmobar }
         , layoutHook = avoidStruts ( smartBorders (tiled ||| Full ||| Mirror tiled ))
         , manageHook = composeOne [ isFullscreen -?> doFullFloat,
                                     isDialog     -?> doCenterFloat ]
                        <+> manageDocks
     , keys = \c -> myKeys c `M.union` keys defaultConfig c 
     }
  where
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Color
myFgColor = "#DDDDDD"
myBgColor = "#222222"
myBorderColor = "#444444"
myFocusBorderColor = "#CCCCCC"
myHighlightedFgColor = "#FFFFFF"
myHighlightedBgColor = "#444444"

myXPConfig = defaultXPConfig {
  position = Bottom,
  promptBorderWidth = 0,
  height = 12,
  bgColor = "black",
  fgColor = myFgColor,
  fgHLight = myHighlightedFgColor,
  bgHLight = myHighlightedBgColor
}

myKeys (XConfig {modMask = modm}) = M.fromList $
        [ ((modm .|. shiftMask, xK_q), spawn "gnome-session-save --gui --logout-dialog")
    , ((modm, xK_Return), shellPrompt myXPConfig)
    , ((modm, xK_p), shellPrompt myXPConfig)
    , ((modm, xK_o), manPrompt myXPConfig)
    , ((modm, xK_f), spawn "firefox")
    , ((modm, xK_b), sendMessage ToggleStruts)
    ]
