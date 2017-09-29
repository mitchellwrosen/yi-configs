{-# language OverloadedStrings #-}

module KeymapSet
  ( myKeymapSet
  ) where

import Utils (newEmptyTabE)

import Data.Prototype (override)
import Yi.Editor (EditorM, newTempBufferE, nextTabE, newWindowE, previousTabE)
import Yi.Keymap.Keys (char, shift)
import Yi.Keymap.Vim (VimBinding, VimConfig(..), VimOperator, defVimConfig, mkKeymapSet)
import Yi.Keymap.Vim.Common (EventString, RepeatToken(Drop), VimMode(Normal))
import Yi.Keymap.Vim.Ex.Types (ExCommand)
import Yi.Keymap.Vim.Utils (mkStringBindingE)
import Yi.Types (Keymap, KeymapSet)

myKeymapSet :: KeymapSet
myKeymapSet = mkKeymapSet (override defVimConfig myOverride)

myOverride :: VimConfig -> VimConfig -> VimConfig
myOverride super self = super
  { vimBindings = tabnew : tabprev : tabnext : vimBindings super
  }

tabnew :: VimBinding
tabnew = mkStringBindingE Normal Drop ("<C-t>", newEmptyTabE, id)

tabprev :: VimBinding
tabprev = mkStringBindingE Normal Drop ("H", previousTabE, id)

tabnext :: VimBinding
tabnext = mkStringBindingE Normal Drop ("L", nextTabE, id)
