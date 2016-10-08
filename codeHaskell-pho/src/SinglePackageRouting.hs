{-# LANGUAGE NoMonomorphismRestriction #-}
module SinglePackageRouting where
import PackageHandoffPrelude
import Diagrams.Prelude hiding (blue)
import Graphics.Gloss.Interface.Pure.Game
type Speed = Double

data GlossWorld a = GlossWorld { world :: World a,
                                 robotSpeeds :: [Speed],
                                 displayString :: String
                               } deriving (Show)

--TODO: The "world" passed to 'play' should be an IO action
-- Hence the thing to the right of the = sign must be a `do` block
-- The let expressions, themsleves can g
handleEvent :: Event -> GlossWorld Float -> GlossWorld Float
handleEvent event glossWorld

 -- Insert robot
 | (EventKey (MouseButton LeftButton) Down _ (x,y)) <- event,
   GlossWorld (World rs ps) rSpeeds _               <- glossWorld
   = let  newRobot = Robot $ p2 (x,y) ;
          info = "Robots: " ++ (show . succ . length) rs ++ " Packages: " ++ (show . length) ps in
     GlossWorld (World (newRobot:rs) ps) (1.0:rSpeeds) info

 -- Insert package source
 | (EventKey (MouseButton RightButton) Down _ (x,y)) <- event,
   GlossWorld (World rs ps) rSpeeds _                <- glossWorld
   = let  newPackage = Package (p2 (x,y)) (p2 (x,y)) ; -- on insertion, the source = target by default
          info = "Robots: "   ++ (show . length) rs ++ " Packages: " ++ (show . succ . length) ps in
     GlossWorld (World rs (newPackage:ps)) rSpeeds info

 -- Insert package target
 | (EventKey (MouseButton RightButton) Up _ (x,y))       <- event,
   GlossWorld (World rs ((Package s _):ps)) rSpeeds info <- glossWorld
   = GlossWorld (World rs (Package s (p2 (x,y)):ps)) rSpeeds info

 | otherwise = glossWorld


renderGlossWorld :: GlossWorld Float -> Picture
renderGlossWorld (GlossWorld w _ infoString)
          = Pictures $ (plotDispString infoString):(map Pictures [rbts, srcs, trgts])
                  where rbts  = map plotRobot     (robots w)
                        srcs  = map plotPkgSource (packages w)
                        trgts = map plotPkgTarget (packages w)


plotRobot :: Robot Float-> Picture
plotRobot (Robot initPosn) = (ThickCircle 5 5) # (Translate x y)
                                where (x,y) = unp2 initPosn


-- The hard-constansts were chosen after experimenting
plotPkgSource :: Package Float -> Picture
plotPkgSource (Package s _) = Pictures (map moveXY [Text "s" # scale' 0.1 # Translate (-1.5) (-1.5),
                                                    pkgMarker  # Color (withAlpha 0.5 blue) ])
                                          where (x,y) = unp2 s
                                                moveXY = Translate x y


plotPkgTarget :: Package Float -> Picture
plotPkgTarget (Package _ t) = Pictures (map moveXY [Text "t" # scale' 0.1 # Translate (-0.9) (-1.5),
                                                    pkgMarker # Color (withAlpha 0.5 blue) ])
                                        where (x,y) = unp2 t
                                              moveXY = Translate x y

plotDispString :: String -> Picture
plotDispString infoString = Text infoString # Translate (-600) 650 # Scale 0.5 0.5


-- Shrink a picture uniformly in X and Y directions.
scale':: Float -> Picture -> Picture
scale' stretchVal picture = Scale stretchVal stretchVal picture


-- The circle around 's' and 't' of packages on canvas.
pkgMarker :: Picture
pkgMarker = Circle 10
