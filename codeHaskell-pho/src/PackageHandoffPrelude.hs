
{-# LANGUAGE NoMonomorphismRestriction #-}
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

data GlossCanvas = GlossCanvas{ currentMode :: Mode, 
                                world       :: World, 
                                schedule    :: Schedule
                              } deriving (Show)

data Mode =   RobotInput    -- ^ Insert Robots onto the Canvas ('r','R') 
            | FuelInput     -- ^ Adjust the fuel for each robot. ('f','F')
            | PackageInput  -- ^ Insert Packages onto the Canvas. ('p','P')
            | AlgoInput     -- ^ Choose scheduling algorithm from the menu on the command-prompt. ('a','A')
            deriving (Show, Eq)

data ScheduleSegment = ScheduleSegment 
                       { head              :: Point V2 Double   , -- ^ Rendezvous or pick-up point 
                         inTransitPackages :: [PkgIndex]        , -- ^ List of packages carried by a robot while moving to head
                         waitTime          :: Double            , -- ^ Time of waiting at the head
                         givePackagesTo    :: Map.Map PkgIndex [PkgIndex],  -- ^ Give packages to specified robots 
                         takePackagesFrom  :: Map.Map PkgIndex [PkgIndex]   -- ^ Take packages from specified robots
                       } deriving (Show)

type Trajectory  = [ ScheduleSegment ] -- | Schedule for a single robot.
type Schedule    = [ Trajectory ] -- | Schedule for a collection of robots
