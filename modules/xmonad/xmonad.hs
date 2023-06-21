{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant $" #-}
import qualified Codec.Binary.UTF8.String as UTF8
import Control.Monad ( when, void )
import qualified DBus as D
import qualified DBus.Client as D
import Data.Char (isSpace, toUpper)
import qualified Data.Map as M
import Data.Maybe (fromJust, fromMaybe, isJust)
import Data.Monoid ()
import Data.Semigroup ()
import Data.Tree ()
import System.Directory ()
import System.Exit (exitSuccess)
import System.IO (hPutStrLn)
import XMonad
  ( Atom,
    ChangeLayout (NextLayout),
    Default (def),
    Dimension,
    KeyMask,
    ManageHook,
    MonadReader (ask),
    Query,
    Resize (Expand, Shrink),
    Tall (Tall),
    Window,
    X,
    XConfig
      ( XConfig,
        borderWidth,
        focusedBorderColor,
        handleEventHook,
        keys,
        layoutHook,
        logHook,
        manageHook,
        modMask,
        mouseBindings,
        normalBorderColor,
        startupHook,
        terminal,
        workspaces
      ),
    XState (windowset),
    button1,
    button2,
    button3,
    className,
    composeAll,
    doF,
    doFloat,
    doShift,
    focus,
    getAtom,
    gets,
    liftX,
    mod4Mask,
    mouseMoveWindow,
    mouseResizeWindow,
    sendMessage,
    spawn,
    title,
    windows,
    xC_left_ptr,
    xmonad,
    (-->),
    (<+>),
    (=?), Mirror (Mirror), withFocused, modifyWindowSet,
  )
import XMonad.Actions.CopyWindow (copyToAll, kill1)
import XMonad.Actions.CycleWS
import XMonad.Actions.PhysicalScreens (sendToScreen, viewScreen)
import XMonad.Actions.Promote ()
import XMonad.Actions.RotSlaves (rotAllDown, rotSlavesDown)
import qualified XMonad.Actions.Search as S
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (killAll, sinkAll)
import XMonad.Config.Azerty (azertyKeys)
import XMonad.Config.Desktop ()
import XMonad.Config.Mate (mateConfig)
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap)
import XMonad.Hooks.DynamicProperty (dynamicPropertyChange)
import XMonad.Hooks.EwmhDesktops
  ( addEwmhWorkspaceSort,
    ewmh,
    ewmhFullscreen,
    setEwmhActivateHook,
  )
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docks, docksEventHook, manageDocks)
import XMonad.Hooks.ManageHelpers
  ( doFullFloat,
    doRectFloat,
    isDialog,
    isFullscreen,
  )
import XMonad.Hooks.ServerMode ()
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.WorkspaceHistory ()
import XMonad.Hooks.XPropManage ()
import XMonad.Layout ()
import XMonad.Layout.Accordion ()
import XMonad.Layout.Combo ()
import XMonad.Layout.Gaps ()
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.LimitWindows (decreaseLimit, increaseLimit, limitWindows)
import XMonad.Layout.Master ()
import XMonad.Layout.MultiToggle (EOT (EOT), Toggle (..), mkToggle, single, (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import XMonad.Layout.NoBorders
  ( noBorders,
    smartBorders,
    withBorder,
  )
import XMonad.Layout.NoFrillsDecoration
  ( Theme
      ( activeBorderColor,
        activeColor,
        activeTextColor,
        fontName,
        inactiveBorderColor,
        inactiveColor,
        inactiveTextColor
      ),
    shrinkText,
  )
import XMonad.Layout.PerScreen ()
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.ResizableTile (ResizableTall (ResizableTall))
import XMonad.Layout.ShowWName ()
import XMonad.Layout.Simplest (Simplest (Simplest))
import XMonad.Layout.SimplestFloat ()
import XMonad.Layout.Spacing
  ( Border (Border),
    Spacing,
    spacingRaw,
  )
import XMonad.Layout.SubLayouts (subLayout)
import XMonad.Layout.Tabbed (addTabs, tabbed)
import XMonad.Layout.TallMastersCombo
  ( tmsCombineTwoDefault,
    (|||),
  )
import XMonad.Layout.ToggleLayouts (ToggleLayout (Toggle), toggleLayouts)
import XMonad.Layout.TwoPane ()
import XMonad.Layout.WindowArranger (WindowArrangerMsg (..), windowArrange)
import XMonad.Layout.WindowNavigation (windowNavigation)
import qualified XMonad.StackSet as W
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP, removeMouseBindings)
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.Ungrab (unGrab)
import XMonad.Util.WindowProperties (getProp32)
import XMonad.Util.WorkspaceCompare (filterOutWs)
import XMonad.Layout.ThreeColumns
import XMonad.Actions.FloatKeys
import Control.Monad.RWS (modify')

--- myColors
colorBack = "#2D2A2E"

colorFore = "#FCFCFA"

color01 = "#403E41"

color02 = "#FF6188"

color03 = "#A9DC76"

color04 = "#FFD866"

color05 = "#FC9867"

color06 = "#AB9DF2"

color07 = "#78DCE8"

color08 = "#FCFCFA"

color09 = "#727072"

color10 = "#FF6188"

color11 = "#A9DC76"

color12 = "#FFD866"

color13 = "#FC9867"

color14 = "#AB9DF2"

color15 = "#78DCE8"

color16 = "#FCFCFA"

base03 = "#002b36"

base02 = "#073642"

base01 = "#586e75"

base00 = "#657b83"

base0 = "#839496"

base1 = "#93a1a1"

base2 = "#eee8d5"

base3 = "#fdf6e3"

yellow = "#b58900"

orange = "#cb4b16"

red = "#dc322f"

magenta = "#d33682"

violet = "#6c71c4"

blue = "#268bd2"

cyan = "#2aa198"

active = blue

green = "#859900"

--- end myColors

myFont :: String
myFont = "xft:SF Pro Display Regular:regular:size=11:antialias=true:hinting=true"

myModMask :: XMonad.KeyMask
myModMask = XMonad.mod4Mask -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "wezterm" -- Sets default terminal

myBrowser :: String
myBrowser = "microsoft-edge" -- Sets qutebrowser as browser

myEditor :: String
myEditor = myTerminal ++ " -e vi " -- Sets vim as editor

myBorderWidth :: XMonad.Dimension
myBorderWidth = 2 -- Sets border width for windows

myNormColor :: String -- Border color of normal windows
myNormColor = colorBack -- This variable is imported from Colors.THEME

myFocusColor :: String -- Border color of focused windows
myFocusColor = color15 -- This variable is imported from Colors.THEME

myStartupHook :: XMonad.X ()
myStartupHook = do
  spawnOnce "dex --autostart --environment xmonad"
  spawnOnce "birdtray"
  spawnOnce "redshift-gtk -l 36:10"
  spawnOnce "kdeconnect-indicator"
  spawnOnce "picom --experimental-backend"
  spawnOnce "indicator-sound-switcher"
  spawnOnce "mate-settings-daemon &"
  spawnOnce "matedpi"
  spawnOnce "mate-power-manager &"
  XMonad.Util.Cursor.setDefaultCursor XMonad.xC_left_ptr
  spawnOnce "feh --randomize --bg-fill ~/.local/share/wallpapers/*"
  setWMName "LG3D"

-- Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

tiled =
  renamed [Replace "tiled"] $
    smartBorders $
      XMonad.Layout.WindowNavigation.windowNavigation $
        addTabs shrinkText myTabTheme $
          subLayout [] (smartBorders Simplest) $
            limitWindows 12 $
              mySpacing 8 $
                ResizableTall 1 (3 / 100) (1 / 2) []

myTall =
  mySpacing' 8 $
    XMonad.Tall 0 (3 / 100) 0

tabs =
  renamed [Replace "tabs"] $
    tabbed shrinkText myTabTheme

mySubLayout =
  smartBorders $
    XMonad.Layout.WindowNavigation.windowNavigation $
      tmsCombineTwoDefault myTall tabs

-- setting colors for tabs layout and tabs sublayout.
myTabTheme =
  XMonad.def
    { fontName = myFont,
      activeColor = active,
      inactiveColor = base02,
      activeBorderColor = active,
      inactiveBorderColor = base02,
      activeTextColor = base03,
      inactiveTextColor = base00
    }

myHoriLayout =
  mySpacing' 8 $
  Mirror mySubLayout
-- The layout hook
myLayoutHook =
  avoidStruts $
    smartBorders $
      windowArrange myDefaultLayout
  where
    myDefaultLayout =
      noBorders tabs
        ||| withBorder myBorderWidth mySubLayout
        ||| withBorder myBorderWidth tiled
        ||| withBorder myBorderWidth myHoriLayout

myWorkspaces = ["\62057", "\61728", "\61729", "\61729 2", "\61764", "\61441", "\61557", "\61448"]

myWorkspaceIndices = M.fromList $ zip myWorkspaces [1 ..] -- (,) == \x y -> (x,y)

myManageHook =
  XMonad.composeAll
    [ hasNetWMState "_NET_WM_STATE_ABOVE" XMonad.--> XMonad.doFloat,
      hasNetWMState "_NET_WM_WINDOW_TYPE_DIALOG" XMonad.--> XMonad.doFloat,
      -- hasNetWMState "_NET_WM_STATE_STICKY" XMonad.--> XMonad.doF copyToAll,
      isFullscreen XMonad.--> doFullFloat,
      XMonad.className XMonad.=? "xdg-desktop-portal-gnome" XMonad.--> XMonad.doFloat,
      isDialog XMonad.--> XMonad.doFloat,
      XMonad.className XMonad.=? "scrcpy" XMonad.--> XMonad.doFloat,
      XMonad.className XMonad.=? "Deadbeef" XMonad.--> XMonad.doShift (myWorkspaces !! 5),
      XMonad.className XMonad.=? "mpv" XMonad.--> XMonad.doShift (myWorkspaces !! 4),
      XMonad.className XMonad.=? "org.wezfurlong.wezterm" XMonad.--> XMonad.doShift (myWorkspaces !! 1),
      XMonad.className XMonad.=? "jetbrains-pycharm" XMonad.--> XMonad.doShift (myWorkspaces !! 2),
      XMonad.className XMonad.=? "jetbrains-datagrip" XMonad.--> XMonad.doShift (myWorkspaces !! 2),
      XMonad.className XMonad.=? "jetbrains-goland" XMonad.--> XMonad.doShift (myWorkspaces !! 2),
      XMonad.className XMonad.=? "jetbrains-webstorm" XMonad.--> XMonad.doShift (myWorkspaces !! 2),
      XMonad.className XMonad.=? "jetbrains-idea" XMonad.--> XMonad.doShift (myWorkspaces !! 2),
      XMonad.className XMonad.=? "Postman" XMonad.--> XMonad.doShift (myWorkspaces !! 3),
      XMonad.className XMonad.=? "obsidian" XMonad.--> XMonad.doShift (myWorkspaces !! 3),
      XMonad.className XMonad.=? "okular" XMonad.--> XMonad.doShift (myWorkspaces !! 3),
      XMonad.className XMonad.=? "Microsoft-edge" XMonad.--> XMonad.doShift (head myWorkspaces),
      XMonad.className XMonad.=? "firefox" XMonad.--> XMonad.doShift (head myWorkspaces),
      XMonad.title XMonad.=? "Picture-in-Picture" XMonad.--> XMonad.doF copyToAll XMonad.<+> doRectFloat (W.RationalRect 0.05 0.05 0.6 0.6),
      XMonad.title XMonad.=? "Picture in picture" XMonad.--> XMonad.doF copyToAll XMonad.<+> doRectFloat (W.RationalRect 0.05 0.05 0.6 0.6),
      XMonad.title XMonad.=? "floatt" XMonad.--> doRectFloat (W.RationalRect 0.05 0.05 0.6 0.6),
      XMonad.className XMonad.=? "pcmanfm-qt" XMonad.--> XMonad.doShift (myWorkspaces !! 4),
      XMonad.className XMonad.=? "thunderbird" XMonad.--> XMonad.doShift (myWorkspaces !! 6)
    ]
  where
    -- \| Get the `_NET_WM_STATE` property as a list of atoms.
    getNetWMState :: XMonad.Window -> XMonad.X [XMonad.Atom]
    getNetWMState w = do
      atom <- XMonad.getAtom "_NET_WM_STATE"
      maybe [] (map fromIntegral) <$> getProp32 atom w

    hasNetWMState :: String -> XMonad.Query Bool
    hasNetWMState state = do
      window <- XMonad.ask
      wmstate <- XMonad.liftX $ getNetWMState window
      atom <- XMonad.liftX $ XMonad.getAtom state
      return $ elem atom wmstate

myDynamicManageHook :: XMonad.ManageHook
myDynamicManageHook =
  XMonad.composeAll
    [ XMonad.className XMonad.=? "Spotify" XMonad.--> XMonad.doShift (myWorkspaces !! 5)
    ]

finalHook = myManageHook XMonad.<+> manageHook mateConfig
-- Check if the given window is floating
isFloating :: Window -> X Bool
isFloating w = do
  floats <- gets (W.floating . windowset)
  return (M.member w floats)

resizeIfFloating :: ChangeDim -> G -> Window -> X ()
resizeIfFloating dim g w = do
  floating <- isFloating w
  when floating (keysResizeWindow dim g w)

-- START_KEYS
myKeys :: [(String, XMonad.X ())]
myKeys =
  [ ("M-S-r", XMonad.spawn "xmonad --restart"), -- Restarts xmonad
    ("C-M1-<Delete>", XMonad.spawn "powermenu"), -- Logout
    ("M-S-<Return>", XMonad.spawn "rofi -no-lazy-grab -show drun -modi drun -theme kde_launcher"), -- Dmenu
    ("M-S-d", XMonad.spawn "rofi -no-lazy-grab -show drun -modi drun -theme kde_launcher"), -- Dmenu
    ("M-<Return>", XMonad.spawn "switchto 'wezterm' 'org.wezfurlong.wezterm'"),
    ("M-b", XMonad.spawn "switchto 'microsoft-edge' 'Microsoft-edge'"),
    ("M-d", XMonad.spawn "alacritty  -e ff.sh"),
    ("M-s", XMonad.spawn "alacritty  -e fd.sh"),
    ("M-g", XMonad.spawn "switchto 'pcmanfm-qt' 'pcmanfm-qt'"),
    ("M-q", kill1), -- Kill the currently focused client
    ("M-S-a", killAll), -- Kill all windows on current workspace
    ("M-u", XMonad.Actions.CycleWS.swapNextScreen),
    ("M-i", XMonad.Actions.CycleWS.swapPrevScreen),
    ("M-n", XMonad.spawn "kill -s USR1 $(pidof deadd-notification-center)"), -- Kill the currently focused client
    ("M-o", XMonad.spawn "switchto 'obsidian' 'obsidian'"), -- Kill the currently focused client
    ("M-j", XMonad.windows W.focusDown), -- Move focus to the next window
    ("M-k", XMonad.windows W.focusUp), -- Move focus to the prev window
    ("M-f", XMonad.sendMessage ToggleStruts),
    ("M-t", withFocused toggleFloat),
    ("M-M1-l", withFocused $ resizeIfFloating (10, 0) (0, 0)),
    ("M-M1-h", withFocused $ resizeIfFloating (-10, 0) (0, 0)),
    ("M-M1-k", withFocused $ resizeIfFloating (0, -10) (0, 0)),
    ("M-M1-j", withFocused $ resizeIfFloating (0, 10) (0, 0)),
    ("M-<Tab>", XMonad.sendMessage XMonad.NextLayout), -- Switch to next layout
    ("M-h", XMonad.sendMessage XMonad.Shrink), -- Shrink horiz window width
    ("M-l", XMonad.sendMessage XMonad.Expand), -- Expand horiz window width
    ("M-M1-<Page_Down>",moveTo Next NonEmptyWS),
    ("M-M1-<Page_Up>", moveTo Prev NonEmptyWS),
    ("<Print>", unGrab *> XMonad.spawn "flameshot gui"),
    ("<XF86AudioLowerVolume>", XMonad.spawn "amixer set Master 5%-"),
    ("<XF86AudioRaiseVolume>", XMonad.spawn "amixer set Master 5%+"),
    ("<XF86AudioMute>", XMonad.spawn "amixer set Master toggle"),
    ("<XF86MonBrightnessDown>", XMonad.spawn "brightnessctl set 5%-"),
    ("<XF86MonBrightnessUp>", XMonad.spawn "brightnessctl set 5%+")
  ]
    where
            toggleFloat w = windows (\s -> if M.member w (W.floating s)
                            then W.sink w s
                            else W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s)


myMouseBindings (XMonad.XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ( (modm, XMonad.button1),
        \w -> do
          floats <- XMonad.gets $ W.floating . windowset
          Control.Monad.when (w `M.member` floats) $ do
            XMonad.focus w
            XMonad.mouseMoveWindow w
            XMonad.windows W.shiftMaster
      ),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, XMonad.button3),
        \w -> do
          floats <- XMonad.gets $ W.floating . windowset
          Control.Monad.when (w `M.member` floats) $ do
            XMonad.focus w
            XMonad.mouseResizeWindow w
            XMonad.windows W.shiftMaster
      )
    ]

-- END_KEYS

main :: IO ()

main =
  XMonad.xmonad $
  withUrgencyHook NoUrgencyHook $
    docks $
      ewmhFullscreen $
        ewmh $
          XMonad.def
            { manageHook = finalHook,
              handleEventHook = dynamicPropertyChange "WM_NAME" myDynamicManageHook,
              modMask = myModMask,
              terminal = myTerminal,
              startupHook = myStartupHook,
              layoutHook = myLayoutHook,
              workspaces = myWorkspaces,
              borderWidth = myBorderWidth,
              mouseBindings = myMouseBindings,
              normalBorderColor = myNormColor,
              keys = \c -> azertyKeys c `M.union` keys XMonad.def c,
              focusedBorderColor = myFocusColor
            }
            `additionalKeysP` myKeys
            `removeKeysP` ["M-p", "M-S-p", "M-<Space>", "M-S-<Space>", "M-;", "M-S-c", "M-,", "M-z", "M-e", "M-r", "M-w"]
            `removeMouseBindings` [(myModMask, XMonad.button2)]
