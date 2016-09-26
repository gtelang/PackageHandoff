
{-# LANGUAGE UnicodeSyntax #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

 {- | This module contains scheduling algorithms and data-structures for 
      routing a single package from point A to point B, where the carrier-
      robots have varying velocity and possibly limited fuel.
 -}

 module SinglePackageRouting where

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

Made some edits here
