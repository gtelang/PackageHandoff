module Main where

import PackageHandoffPrelude
import SinglePackageRouting
import Graphics.Gloss

main :: IO ()
main = do let initialWorld    = World {robots=[], packages=[]}
          let initialWorld'   = GlossWorld{world=initialWorld, robotSpeeds=[], displayString = "0 Robots, 0 Packages"}
          let windowSize      = (1800,1800)
          let windowPosition  = (0,0)
          let backgroundColor = greyN 0.9
          let framesPerSecond = 20
          play (InWindow "PackageHandoff" windowSize windowPosition) backgroundColor framesPerSecond
                initialWorld' renderGlossWorld handleEvent  (const id)
