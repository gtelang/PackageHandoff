
{-# LANGUAGE NoMonomorphismRestriction #-}
-- | Common Data-Structures and Functions.
module PackageHandoffPrelude where
import Diagrams.Prelude
import qualified Data.Map as Map
-- TODO: Use Liquid Haskell to enforce ≥ 0 at the type level
type Speed    = Double -- | ≥ 0
type Fuel     = Double -- | ≥ 0
type Time     = Double -- | ≥ 0
type PkgIndex = Int    -- | ≥ 0

data Robot = Robot { initPosition :: Point V2 Double, 
                     maxSpeed     :: Speed          ,
                     maxFuel      :: Fuel 
                    } deriving (Show)

data Package = Package { source :: Point V2 Double,
                         target :: Point V2 Double 
                       } deriving (Show)

data World = World { robots      :: [Robot]  ,    
                     packages    :: [Package]    
                   } deriving (Show)

-- | State of the Gloss canvas
data GlossCanvas = GlossCanvas{ currentMode :: Mode, 
                                world       :: World, 
                                schedule    :: Schedule
                              } deriving (Show)

data Mode =   RobotInput    -- ^ Insert Robots onto Canvas        'r 
            | FuelInput     -- ^ Adjust the fuel for each robot.  'f'
            | PackageInput  -- ^ Insert Packages onto the Canvas. 'p'
            | AlgoInput     -- ^ Choose scheduling algorithm.     'a'
            deriving (Show, Eq)

data Link = Link 
           { head :: Point V2 Double         , -- ^ Rendezvous or pick-up point 
             waitTime          :: Time       ,-- ^ Time of waiting at the head
             inTransitPackages :: [PkgIndex] ,-- ^ List of packages carried while moving to head
             givePackagesTo    :: Map.Map PkgIndex [PkgIndex],-- ^ Give packages to specified robots 
             takePackagesFrom  :: Map.Map PkgIndex [PkgIndex] -- ^ Take packages from specified robots
            } deriving (Show)

-- | Schedule for a single robot.
type Trajectory  = [ Link ] 
-- | Schedule for a collection of robots
type Schedule    = [ Trajectory ]
