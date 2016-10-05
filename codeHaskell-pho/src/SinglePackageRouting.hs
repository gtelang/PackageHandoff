
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}
module SinglePackageRouting where

import PackageHandoffPrelude
import Diagrams.Prelude
import qualified Data.List as List
import Data.Colour.Palette.BrewerSet
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
