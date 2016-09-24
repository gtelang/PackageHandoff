# Packagehandoff

This repository contains programs written in Haskell and C++ to solve Package handoff problems: think of a taxi-service co-ordinating its fleet of cabs to transport passengers calling in from different points of the map to their destinations. Or consider [Amazon drones](https://www.youtube.com/watch?v=gFj5SCdSYQg) with limited battery capcacity and varying maximum speeds working together to deliver multiple packages from warehouses to customers.

More detailed introductory notes on this class of problems can be found in 
**PackageHandoff.html**.  

All of the library code has been weaved into
[PackageHandoff.org](https://github.com/gtelang/packagehandoff/blob/master/PackageHandoff.org)  and tangled inside [codeHaskell-pho](https://github.com/gtelang/packagehandoff/tree/master/codeHaskell-pho). 

## Prerequisites for Installation
The code has been developed on an Ubuntu 14.04 machine. So I presume the procedure described below will best work on Linux
systems. How these instructions work need to be modified for Windows and Mac OSX, I cannot say yet. 

Before installing *packagehandoff*  
 * [Stack](https://docs.haskellstack.org/en/stable/README/) 
 * GCC
 * [GLPK] (https://www.gnu.org/software/glpk/)
 * [CGAL] (http://www.cgal.org/)
 
## Installation 

#### The Haskell part
Having installed the prerequisites, navigate to **codeHaskell-pho**, open up a shell-prompt and type
```zsh
[../codeHaskell-pho]: stack build
```
Then sit back and enjoy a mojito! Stack will take care of fetching the appropriate haskell-related library dependencies (even the GHC compiler) if they have not been installed on your machine. **This process can take upto 30-40 mins if you did not have the [Haskell platform](https://www.haskell.org/platform/) installed already**

### The C++ part
Navigate to **codeHaskell-pho/src** and type make. Some light editing might be required to the /Makefile/ depending especially on where the gcc executable and the *.so* and *.hpp* files of CGAL might be on your machine. For that, you might find the bash commands `which gcc` and **`locate libCGAL`** handy. 
