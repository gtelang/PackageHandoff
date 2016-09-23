
{-# LANGUAGE UnicodeSyntax #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

{- | Data-structures and routines common to all 
     package-handoff problem variants.
-}
module PackageHandoffPrelude where
import Diagrams.Prelude
import qualified Data.Map as Map

-- | The global world state is always in one of these four modes
data Mode =   RobotInput    -- ^ Click points on the canvas to place robots
            | FuelInput     -- ^ Adjust the fuel for each robot with the scroll wheel. 
            | PackageInput  -- ^ Click source, target in pairs. 
            | AlgoInput     -- ^ Choose scheduling algorithm
            deriving (Show, Eq)

-- TODO: Use Liquid Haskell to enforce these simple properties
type Speed          = Double -- | ≥ 0
type Fuel           = Double -- | ≥ 0
type Time           = Double -- | ≥ 0
type PackageIndex   = Int    -- | ≥ 0 

type Robots         = [ Robot ]
type Packages       = [ Package ] 
type RobotSchedule  = [ ScheduleSegment ] -- | Schedule for a single robot.
type Schedules      = [ RobotSchedule   ] -- | Schedule for a collection of robots
type PackageIndices = [ PackageIndex ]

-- | Carrier Vehicles
data Robot = Robot { initPosition :: Point V2 Double, 
                     maxSpeed     :: Speed          ,
                     maxFuel      :: Fuel 
                    } deriving (Show)

-- | Items to transport
data Package = Package { source :: Point V2 Double,
                         target :: Point V2 Double 
                       } deriving (Show)

-- | A List of these records makes up the schedule for one robot. Corresponds to one 
-- segment inside the robot's piecewise linear trajectory.
data ScheduleSegment = ScheduleSegment 
                       { head              :: Point V2 Double   , -- ^ Rendezvous or pick-up point for a package
                         inTransitPackages :: PackageIndices    , -- ^ List of packages carried while moving to head
                         waitTime          :: Double            , -- ^ Time of waiting at the head
                         givePackagesTo    :: Map.Map PackageIndex PackageIndices,  -- ^ Give packages to specified robots 
                         takePackagesFrom  :: Map.Map PackageIndex PackageIndices   -- ^ Take packages from specified robots
                       } deriving (Show)

-- | Container for the world state as we interact with the Gloss Canvas. 
-- Keeps store of the world data-while interacting with Gloss. 
-- This data-structure is used principally in Gloss functions
data World = World { currentMode :: Mode    ,
                     robots      :: Robots  ,
                     packages    :: Packages,
                     globalSchedule :: Schedules 
                   } deriving (Show)
