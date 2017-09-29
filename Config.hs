{-# language RecordWildCards #-}

module Config
  ( myConfig
  ) where

import KeymapSet (myKeymapSet)
import UIConfig (myUIConfig)

import Data.DynamicState (DynamicState)
import Data.List
import Data.Sequence (Seq)
import Yi
import Yi.Buffer.Normal (RegionStyle(Inclusive))
import Yi.Config.Misc (ScrollStyle(SingleLine))
import Yi.Config.Simple.Types
import Yi.Editor (newTabE)
import Yi.File (openNewFile)
import Yi.Frontend.Vty (start)
import Yi.Interact (idAutomaton)
import Yi.Keymap (Action(EditorA, YiA))
import Yi.Keymap.Vim (keymapSet)
import Yi.Layout (AnyLayoutManager, hPairNStack, tall, vPairNStack, wide)
import Yi.Mode.Common (fundamentalMode)

myConfig :: [String] -> Config
myConfig files = Config{..}
 where
  -- Use the vty front-end.
  startFrontEnd :: UIBoot
  startFrontEnd = start

  -- UI-specific configuration.
  configUI :: UIConfig
  configUI = myUIConfig

  -- Key bindings.
  defaultKm :: KeymapSet
  defaultKm = myKeymapSet

  -- On startup, open each command-line argument in a new tab.
  startActions :: [Action]
  startActions = intersperse newTabA (map openNewFileA files)

  -- Actions to run after startup or reload. These are run after 'startActions'.
  initialActions :: [Action]
  initialActions = []

  -- Modes listed by order of preference.
  modeTable :: [AnyMode]
  modeTable = [AnyMode fundamentalMode]

  -- If 'True', write debug output to 'yi-debug-output.txt'.
  debugMode :: Bool
  debugMode = True

  -- 'True' = emacs-like, that's all I know.
  configKillringAccumulate :: Bool
  configKillringAccumulate = False

  -- Undocumented bool, wat.
  configCheckExternalChangesObsessively :: Bool
  configCheckExternalChangesObsessively = True

  -- Vim-like region style.
  configRegionStyle :: RegionStyle
  configRegionStyle = Inclusive

  -- Undocumented process thing.
  configInputPreprocess :: P Event Event
  configInputPreprocess = idAutomaton

  -- Undocumented whosey-whatey.
  bufferUpdateHandler :: Seq (Seq Update -> BufferM ())
  bufferUpdateHandler = mempty

  -- List of layout managers.
  layoutManagers :: [AnyLayoutManager]
  layoutManagers = [hPairNStack 1, vPairNStack 1, tall, wide]

  -- Custom configuration.
  configVars :: DynamicState
  configVars = mempty

openNewFileA :: String -> Action
openNewFileA file = YiA (openNewFile file)

newTabA :: Action
newTabA = EditorA newTabE
