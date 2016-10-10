module Main where

import PackageHandoffPrelude
import SinglePackageRouting
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game

main :: IO ()
main = do let initialWorld     = World {robots=[], packages=[]}
          let initialProbWorld = ProbWorld{world=initialWorld, robotSpeeds=[],
                                           banner = "0 Robots, 0 Packages"}
          let winSize         = (1800,1800)
          let winPosn         = (0,0)
          let backgroundColor = greyN 0.9
          let framesPerSecond = 2
          let winConfig       = InWindow "PackageHandoff" winSize winPosn
          playIO winConfig backgroundColor framesPerSecond
                 initialProbWorld
                 renderProbWorld
                 handleEvent
                 (\_ probWorld -> return probWorld)
