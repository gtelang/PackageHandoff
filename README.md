# Packagehandoff

This repository contains programs written in Haskell and C++ to solve Package handoff problems: think of a taxi-service co-ordinating its fleet of cabs to transport passengers calling in from different points of the map to their destinations. Or consider [Amazon drones](https://www.youtube.com/watch?v=gFj5SCdSYQg) with limited battery capcacity and varying maximum speeds working together to deliver multiple packages from warehouses to customers.

More detailed introductory notes on this class of problems can be found in 
**PackageHandoff.html**.  

All of the library code has been weaved into
[PackageHandoff.org](https://github.com/gtelang/packagehandoff/blob/master/PackageHandoff.org)  and tangled inside [codeHaskell-pho](https://github.com/gtelang/packagehandoff/tree/master/codeHaskell-pho). 

## Installation
The code has been developed on an Ubuntu 14.04 machine. So I presume the procedure described below will best work on Linux
systems. All bets are off for Windows/Mac OS. :-) 

### Prerequisites
You will need  
 * [Stack](https://docs.haskellstack.org/en/stable/README/) 
 * GCC
 * [GLPK] (https://www.gnu.org/software/glpk/)
