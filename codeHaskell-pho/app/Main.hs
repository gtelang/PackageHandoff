
module Main where

import PackageHandoffPrelude
import SinglePackageRouting
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import System.IO

main :: IO ()
-- main = stub   
main = do let initialWorld   = World {robots=[], packages=[]}
          let initialWorld'  = World'{world=initialWorld, robotSpeeds=[]}
          let windowSize     = (800,800)
          let windowPosition = (200,200)
          play (InWindow "PackageHandoff" windowSize windowPosition) (greyN 0.9) 20
                initialWorld' renderWorld' handleEvent stepWorld'
