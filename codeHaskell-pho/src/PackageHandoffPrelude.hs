
{- | Common Data-Structures and Functions. -}

{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}
{-# LANGUAGE GADTs                     #-}
module PackageHandoffPrelude where
import Diagrams.Prelude
import qualified Data.Map as Map

type Speed       = Double  -- | ∈ [0,1]
type Fuel        = Double  -- | ∈ [0,∞] 
type RobotIdx    = Int     -- | ≥ 0
type PackageIdx  = Int     -- | ≥ 0 
type PackageList = [PackageIdx]

data Package = Package { source :: Point V2 Double,
                         target :: Point V2 Double 
                       } deriving (Show)

-- TODO: Should we parametrize the Robot data-type depending on what king of points, it starts at? 
-- i.e integer grid points or just the R^2 plane.
data Robot = Robot { idx          :: RobotIdx,
                     initPosition :: Point V2 Double 
                   } deriving (Show) 
 
-- We define Robot Equality based on their indices. 
-- since two Robots are allowed to start at the same position. 
instance Eq Robot where 
   Robot idx1 _ == Robot idx2 _ = (idx1 == idx2)

{- | World consists of only robots and packages. -}
data World = World { robots      :: [ Robot  ] ,    
                     packages    :: [ Package]
                   } deriving (Show) 
             
{- | Load carried across a link of the trajectory. -} 
data Load =  -- Single package load, possibly give to the Robot inside Maybe functor  
             SinglePackage      (   Package     , Maybe Robot )    
             -- Multi-package load, possibly give each to the Robot inside Maybe functor 
           | MultiPackage       [ ( PackageList , Maybe Robot ) ]  
             -- Zero Load, nothing to give!
           | Nil                                                      
             deriving (Show)

 {- | A single link of the trajectory -}
data Link = Link { head            :: Point V2 Double, 
                   load            :: Load, 
                   waitTimeAtHead  :: Double
                 } deriving (Show)

{- | Schedule for a single robot.-} 
data Trajectory  = Trajectory [ Link ]  
                    deriving (Show)

{- | Schedule for a collection of robots. In one-one 
      correspondence with the robots list of the World -}
type Schedule    = [ Trajectory ]
