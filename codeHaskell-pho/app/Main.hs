{-# LANGUAGE PatternGuards #-}
{-# LANGUAGE UnicodeSyntax #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import System.IO

type Radius = Float
type RealTime   = Float
type GlossTime  = Float -- Turns out this has a bad doc-string inside the Gloss manual. this is basically "dt" for the simulation.

data World = World Radius RealTime GlossTime

main :: IO ()
main = do
         a <- do  let initWorld = World 100.0 0 0
                  let windowSize = (800,800)
                  let windowPosition = (200,200)
                  print "Hello"
                  hFlush stdout
                  play (InWindow "PackageHandoff" windowSize windowPosition)
                    white 40 initWorld  -- Window setup and initialization
                    renderWorld        -- The three arrows of figure 1 in the literate document.
                    handleEvent
                    stepWorld
                  hFlush stdout
                  print "World"
                  return "World"
         print a

-- The dumbest arrows ever!
renderWorld :: World -> Picture
renderWorld (World rad rtime gtime) = Pictures [ Translate  5.0 250.0 $
                                                    Scale 0.3 0.3 $
                                                    Text ("Time: " ++ show rtime ++ "  " ++ show gtime) , --  figure annotations.
                                                 Circle rad ]

handleEvent :: Event -> World -> World
handleEvent _ = id -- don't change the state

stepWorld ::  Float -> World -> World -- wobbling circle
stepWorld  gtime (World _ rtime _)  = World (100 * sin rtime) (rtime+0.1) gtime -- Note that I am not using the actual time passed by Gloss anywhere here! Purely a rendering of the state-variable
