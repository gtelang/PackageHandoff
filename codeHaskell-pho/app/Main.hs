
module Main where

import PackageHandoffPrelude
import SinglePackageRouting
import Graphics.Gloss

main :: IO ()
main = do let initialWorld    = World {robots=[], packages=[]}
          let initialWorld'   = World'{world=initialWorld, robotSpeeds=[]}
          let windowSize      = (1800,1800)
          let windowPosition  = (0,0)
          let backgroundColor = greyN 0.9
          let framesPerSecond = 20
          play (InWindow "PackageHandoff" windowSize windowPosition) backgroundColor framesPerSecond
                initialWorld' renderWorld' handleEvent  (const id)
