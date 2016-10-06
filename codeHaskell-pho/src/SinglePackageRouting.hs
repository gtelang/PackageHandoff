
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}
{-# LANGUAGE PatternGuards             #-}
{-# LANGUAGE TypeApplications          #-}
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
                         robotSpeeds  :: [Speed] , -- Depending on the problem this information, may or may not be there
                         test         :: String
                       } deriving (Show)

renderWorld' :: World' a -> Picture
renderWorld' (World' world speeds test)= Pictures [ Text test ] 

-- The <- is critical! Not sure about world, but certainly for event, since it represents some kind of IO event
-- Also you just discovered the lens problem! Why did you have to unpack so much!
-- This event-handler is going to represent the real meat of the code.
-- You can now fuse the event and world, thing with pattern matching and boolean 
-- conditions. And yes, currying is lovely!
-- The more events you add, the more branches will there be
-- Possible there will be sub-branching too!
handleEvent :: Event -> World' a -> World' a
handleEvent event world'
       | (EventKey (MouseButton LeftButton) Down _ pt@(x,y) ) <- event,
          World' world robotSpeeds test                       <- world', 
         ( abs x <  abs y)                                    = World' world robotSpeeds ('c':test)
       | otherwise = world'

stepWorld' ::  Float -> World' a -> World' a
stepWorld' dt  = id
