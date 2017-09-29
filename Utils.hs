{-# language OverloadedStrings #-}

module Utils where

import Control.Monad.State (get, put)
import Data.List.PointedList.Circular (insertRight)
import Lens.Micro.Platform
import Yi.Editor (EditorM, newWindowE, refSupply, stringToNewBuffer, tabsA)
import Yi.Tab (makeTab1)
import Yi.Types (BufferId(MemBuffer))

newEmptyTabE :: EditorM ()
newEmptyTabE = do
  win <- newWindowE False =<< stringToNewBuffer (MemBuffer "<new>") mempty
  ref <- newRef
  tabsA %= insertRight (makeTab1 ref win)

newRef :: EditorM Int
newRef = do
  s <- get
  let n = refSupply s
  put (s { refSupply = n+1 })
  pure (n+1)
