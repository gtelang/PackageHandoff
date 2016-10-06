
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}
module SinglePackageRouting where

import PackageHandoffPrelude
import Diagrams.Prelude
import qualified Data.List as List
import Graphics.Gloss
import Graphics.Gloss.Data.Color
import Graphics.Gloss.Interface.Pure.Game

type Speed = Double
type Time  = Double

-- A Wrapper around world which includes auxiliary information like velocity etc.
-- This auxiliary information will be specific to the variant of the problem we are solving.
data World' a = World' { world        :: World a , -- This is the core-input consisting of robots and packages.
                         robotSpeeds  :: [Speed]   -- Depending on the problem this information, may or may not be there
                       } deriving (Show)

renderWorld' :: World' a -> Picture
renderWorld' (World' world speeds)= Pictures [ Circle 10, Translate 0 10 $ circleSolid 5]

handleEvent :: Event -> World' a -> World' a
handleEvent event = id 

stepWorld' ::  Float -> World' a -> World' a
stepWorld' dt  = id
