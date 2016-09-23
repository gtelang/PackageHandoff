
{-# LANGUAGE UnicodeSyntax #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
module ProbX where

import qualified Data.List as List
import qualified Data.Map  as Map
import qualified Data.Set  as Set
import qualified Data.Function as Function
import Data.Ord
import Control.Monad
import Data.Monoid -- To be able to use <> for `mappend`
-- Diagrams
import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine
-- Gloss
import Data.Colour.Palette.BrewerSet
import Graphics.Gloss


-- -- | The game state.
-- data State
--         = State (Maybe Path)    -- The current line being drawn.
--                 [Picture]       -- All the lines drawn previously.


-- -- | A Line Segment
-- type Segment    = ((Float, Float), (Float, Float))


-- -- | Convert our state to a picture.
-- renderState :: State -> Picture
-- renderState (State m xs)
--         = Pictures (maybe xs (\x -> Line x : xs) m)


-- -- | Handle mouse click and motion events. Done via pattern matching! 
-- handleEvent :: Event -> State -> State
-- handleEvent event state
--         -- If the mouse has moved, then extend the current line.
--         | EventMotion (x, y)    <- event
--         , State (Just ps) ss    <- state
--         = State (Just ((x, y):ps)) ss

--         -- Start drawing a new line.
--         | EventKey (MouseButton LeftButton) Down _ pt@(x,y) <- event
--         , State Nothing ss       <- state
--         = State (Just [pt])
--                 ((Translate x y $ Scale 0.1 0.1 $ Text "Down") : ss)

--         -- Finish drawing a line, and add it to the picture.
--         | EventKey (MouseButton LeftButton) Up _ pt@(x,y)      <- event
--         , State (Just ps) ss    <- state
--         = State Nothing
--                 ((Translate x y $ Scale 0.1 0.1 $ Text "up") : Line (pt:ps) : ss)

--         | otherwise
--         = state

-- stepWorld :: Float -> State -> State
-- stepWorld _ = id
