{-# language ScopedTypeVariables #-}

import Config (myConfig)

import Control.Monad (when)
import Control.Monad.State.Lazy (execStateT)
import System.Environment (getArgs)
import Yi.Config (Config(debugMode))
import Yi.Config.Default.HaskellMode (configureHaskellMode)
import Yi.Config.Default.MiscModes (configureMiscModes)
import Yi.Config.Simple.Types (ConfigM, runConfigM)
import Yi.Core (startEditor)
import Yi.Debug (initDebug)
import Yi.Types (Editor)

main :: IO ()
main = do
  files :: [String] <-
    getArgs

  let myConfigM :: ConfigM ()
      myConfigM = do
        configureHaskellMode
        configureMiscModes

  config :: Config <-
    execStateT (runConfigM myConfigM) (myConfig files)

  -- Editor state to initialize (or Nothing to start from scratch).
  let editor :: Maybe Editor
      editor = Nothing

  when (debugMode config)
    (initDebug "yi-debug-output.txt")

  startEditor config editor
