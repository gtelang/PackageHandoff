
{- | Contains data-structures and scheduling algorithms for 
     routing a single package from sourcodeHaskell-pho/src/SinglePackageRouting -}

{-# LANGUAGE UnicodeSyntax #-} 
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}
{-# LANGUAGE GADTs                     #-}
module SinglePackageRouting where

import PackageHandoffPrelude

import Diagrams.Prelude
import qualified Data.List as List
import qualified Data.Map  as Map
import qualified Data.Set  as Set
import qualified Data.Function as Function
import Control.Monad
import Data.Monoid 
import Data.Colour.Palette.BrewerSet
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
