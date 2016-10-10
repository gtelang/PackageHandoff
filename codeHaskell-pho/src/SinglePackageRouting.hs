{-# LANGUAGE NoMonomorphismRestriction #-}
module SinglePackageRouting
(ProbWorld(..), handleEvent, renderProbWorld
)where

import PackageHandoffPrelude
import Diagrams.Prelude hiding (blue,red, green, Line)
import Graphics.Gloss.Interface.IO.Game
import System.Random

type Speed = Double

-- selected robots
-- Is point-clicked on selected group?
data ProbWorld a = ProbWorld { world       :: World a,
                               robotSpeeds :: [Speed],
                               banner :: String
                             } deriving (Show)

handleEvent :: Event -> ProbWorld Float -> IO (ProbWorld Float)
handleEvent event probWorld

 -- Insert robot
 | (EventKey (MouseButton LeftButton) Down _ (x,y)) <- event,
   ProbWorld (World rs ps) rSpeeds _                <- probWorld
   = do
        let  newRobot = Robot $ p2 (x,y)
        let  info     = "Robots: "   ++ (show . succ . length) rs
                    ++ " Packages: " ++ (show . length) ps
        return $ ProbWorld (World (newRobot:rs) ps) (1.0:rSpeeds) info

 -- Insert package source
 | (EventKey (MouseButton RightButton) Down _ (x,y)) <- event,
   ProbWorld (World rs ps) rSpeeds _                <- probWorld
   = do
         r <- randomRIO (0.0,1.0) :: IO Float
         g <- randomRIO (0.0,1.0) :: IO Float
         b <- randomRIO (0.0,1.0) :: IO Float
         let pkgColor = makeColor r g b 1.0
         -- on insertion, the source = target by default
         let  newPackage = Package (p2 (x,y)) (p2 (x,y)) pkgColor
         let  info       = "Robots: "   ++ (show . length) rs
                       ++ " Packages: " ++ (show . succ . length) ps
         return $ ProbWorld (World rs (newPackage:ps)) rSpeeds info

 -- Insert package target
 | (EventKey (MouseButton RightButton) Up _ (x,y))      <- event,
   ProbWorld (World rs ((Package s _ col):ps)) rSpeeds info <- probWorld
   = return $ ProbWorld (World rs (Package s (p2 (x,y)) col :ps)) rSpeeds info

 | otherwise = return probWorld


renderProbWorld :: ProbWorld Float -> IO Picture
renderProbWorld (ProbWorld w _ infoString)
   = do print $ length $ robots w
        return $ Pictures $ (plotDispString infoString):(map Pictures [rbts,
                                                                       srcs,
                                                                       trgts,
                                                                       arrows])
                   where rbts   = map plotRobot      (robots w)
                         srcs   = map plotPkgSource  (packages w)
                         trgts  = map plotPkgTarget  (packages w)
                         arrows = map plotSrcTgtLink (packages w)


plotRobot :: Robot Float-> Picture
plotRobot (Robot initPosn) = (ThickCircle 5 5) # (Translate x y)
                                where (x,y) = unp2 initPosn


-- The hard-constansts below were chosen after experimenting with the canvas look visually
-- They should have  NO bearing on the algorithms of the problem
plotPkgSource :: Package Float -> Picture
plotPkgSource (Package s _ col) = Pictures (map moveXY [Text "s" # scale' 0.1 # Translate (-1.5) (-1.5),
                                                    pkgMarker  # Color (withAlpha 0.5 col) ])
                                          where (x,y) = unp2 s
                                                moveXY = Translate x y

plotPkgTarget :: Package Float -> Picture
plotPkgTarget (Package _ t col) = Pictures (map moveXY [Text "t" # scale' 0.1 # Translate (-1.4) (-1.4),
                                                    pkgMarker # Color (withAlpha 0.5 col) ])
                                        where (x,y) = unp2 t
                                              moveXY = Translate x y

plotSrcTgtLink :: Package Float -> Picture
plotSrcTgtLink (Package s t col) = Color col $ Line $ map unp2 [s, t]


plotDispString :: String -> Picture
plotDispString infoString = Text infoString # Translate (-600) 550 # Scale 0.5 0.5


-- Shrink a picture uniformly in X and Y directions.
scale':: Float -> Picture -> Picture
scale' stretchVal picture = Scale stretchVal stretchVal picture


-- The circle around 's' and 't' of packages on canvas.
pkgMarker :: Picture
pkgMarker = ThickCircle radius thickness
                where radius    = 7
                      thickness = 14
