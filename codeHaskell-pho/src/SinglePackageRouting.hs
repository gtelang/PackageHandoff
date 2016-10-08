{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeFamilies              #-}
{-# LANGUAGE PatternGuards             #-}
{-# LANGUAGE TypeApplications          #-}
module SinglePackageRouting where

import PackageHandoffPrelude
import Diagrams.Prelude hiding (blue)
import Graphics.Gloss.Interface.Pure.Game

type Speed = Double
type Time  = Double

-- A Wrapper around world which includes auxiliary information like velocity etc.
-- This auxiliary information will be specific to the variant of the problem we are solving.
-- TODO: Add Schedule.
data World' a = World' { world       :: World a, -- This is the core-input consisting of robots and packages.
                         robotSpeeds :: [Speed] -- Depending on the problem this information, may or may not be there
                       } deriving (Show)

-- The <- is critical! For both event and world, since it represents some kind of IO event
-- Also you just discovered the lens problem! Why did you have to unpack so much!
-- This event-handler is going to represent the real meat of the code.
-- You can now fuse the event and world, thing with pattern matching and boolean 
-- conditions. And yes, currying is lovely!
-- The more events you add, the more branches will there be
-- Possible there will be sub-branching too!
-- generate random colors within the branches too!
handleEvent :: Event -> World' Float -> World' Float
handleEvent event world'
       -- Left Mouse Button (Down) :: Insert robot onto canvas. Default speed is 1.0:
       -- TODO: Clears existing schedule
       -- TODO: Generate a random hash-key sha1 as a unique id.
       | (EventKey (MouseButton LeftButton) Down _ (x,y)) <- event,
         World' (World robots' packages') robotSpeeds'           <- world' = let  newRobot = Robot 16 (p2 (x,y)) in
                                                                          World' (World (newRobot:robots') packages') (1.0:robotSpeeds')
       -- Right Mouse Button (Down) :: Insert package source/target onto
       -- canvas in successive-pairs TODO: Make new empty schedule
       | (EventKey (MouseButton RightButton) Down _ (x,y)) <- event,
         World' (World robots' packages') robotSpeeds'           <- world' = let  newPackage = Package (p2 (x,y)) (p2 (x,y)) in
                                                                          World' (World robots' (newPackage:packages')) robotSpeeds'
       -- Select one or more robots or packages for moving/resizing velocity.
       -- TODO: Make new empty schedule: Use dumb point-location.
       | (EventKey (MouseButton RightButton) Up _ (x,y)) <- event,
          World' (World robots' ((Package source' _):packages')) robotSpeeds' <- world' = World' (World robots' (Package source' (p2 (x,y)):packages')) robotSpeeds'
       -- Do nothing
       | otherwise = world'

-- TODO: Critical: For good visualization, you need good pictures!
-- Generate pictures individually. And then glue them together with
-- this function.
renderWorld' :: World' Float -> Picture
renderWorld' (World' world' _) = Pictures $ map Pictures [map plotRobot (robots world'), map plotSourceOfPackage (packages world'), map plotTargetOfPackage (packages world')]

plotRobot :: Robot Float-> Picture
plotRobot (Robot _ initPosn) = (ThickCircle 5 5) # (Translate x y)
                                where (x,y) = unp2 initPosn 

plotSourceOfPackage :: Package Float -> Picture
plotSourceOfPackage (Package source' _) = Pictures (map moveXY [Text "s" , Circle 5 # Color (withAlpha 0.5 blue) ])
                                         where (x,y) = unp2 source' -- unpack Diagrams point
                                               moveXY = Translate x y

plotTargetOfPackage :: Package Float -> Picture
plotTargetOfPackage (Package _ target') = Pictures (map moveXY [Text "t" , Circle 5 # Color (withAlpha 0.5 blue) ])
                                         where (x,y) = unp2 target' -- unpack Diagrams point
                                               moveXY = Translate x y

-- Delete selected elements. If the source is deleted, its 
       -- corresponding target is deleted too 
       -- TODO: Make new empty schedule.
       --  otherwise = world'
       -- Increase velocity of selected elements if they are robots. 
       -- TODO: Make new empty schedule
       -- otherwise = world'
       -- Depending on the key-press run the corresponding scheduler. 
       -- and generate schedule 
       -- TODO: Add this field to World. and generate new schedule.
       -- otherwise = world'
