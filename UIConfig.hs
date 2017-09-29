{-# language RecordWildCards #-}

module UIConfig
  ( myUIConfig
  ) where

import Yi.Config (CursorStyle(AlwaysFat), UIConfig(..))
import Yi.Config.Misc (ScrollStyle(SingleLine))
import Yi.Style.Library (Theme, defaultTheme)

myUIConfig :: UIConfig
myUIConfig = UIConfig{..}
 where
  -- Hide the scroll bar if there is enough text to fit on one screen? Irrelevant
  -- if configLeftSideScrollbar = True.
  configAutoHideScrollBar :: Bool
  configAutoHideScrollBar = False

  -- Hide the tab bar if there is only one tab open?
  configAutoHideTabBar :: Bool
  configAutoHideTabBar = True

  -- Irrelevant for the vty frontend.
  configCursorStyle :: CursorStyle
  configCursorStyle = AlwaysFat

  -- Font name.
  configFontName :: Maybe String
  configFontName = Nothing

  -- Font size.
  configFontSize :: Maybe Int
  configFontSize = Just 10

  -- Show a scroll bar on the left side?
  configLeftSideScrollBar :: Bool
  configLeftSideScrollBar = True

  -- Wrap long lines?
  configLineWrap :: Bool
  configLineWrap = True

  -- Amount to move the buffer when using the scroll wheel.
  configScrollWheelAmount :: Int
  configScrollWheelAmount = 4

  configScrollStyle :: Maybe ScrollStyle
  configScrollStyle = Just SingleLine

  -- The character used to fill empty window space.
  configWindowFill :: Char
  configWindowFill = '~'

  -- UI theme.
  configTheme :: Theme
  configTheme = defaultTheme
