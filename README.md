
# Packagehandoff

This repository contains programs written in Haskell and C++ to solve Package handoff problems: think of a taxi-service co-ordinating its fleet of cabs to transport passengers calling in from different points of the map to their destinations. Or consider [Amazon drones](https://www.youtube.com/watch?v=gFj5SCdSYQg) with limited battery capcacity and varying maximum speeds working together to deliver packages to customers from warehouses.

More detailed introductory notes on this class of problems can be found in 
**PackageHandoff.html**.  

All of the library code has been weaved into
[PackageHandoff.org](https://github.com/gtelang/packagehandoff/blob/master/PackageHandoff.org) and tangled inside [codeHaskell-pho](https://github.com/gtelang/packagehandoff/tree/master/codeHaskell-pho). 

The following installations instructions should work on any Linux distro. The code was written using on an Ubuntu 14.04 machine.

## Prerequisites
Before installing **packagehandoff**  you will need
 * [Stack](https://docs.haskellstack.org/en/stable/README/) 
 * [GCC-6](http://askubuntu.com/a/746480) 
     * sudo add-apt-repository ppa:ubuntu-toolchain-r/test 
     * sudo apt-get update
     * sudo apt-get install gcc-6 g++-6
    The installed gcc executable will be named `gcc-6`.
 * [GLPK] (https://www.gnu.org/software/glpk/)
 * [CGAL] (http://www.cgal.org/)
 * [Emacs] (https://www.gnu.org/software/emacs/) (Only for editing and tangling library code inside `PackageHandoff.org` ) 

## Install 

####  *The C++ part*
Having installed the prerequisites, navigate to **codeHaskell-pho/src** and type **`make`**. Light editing might be required to the `Makefile` depending especially on where the gcc executable and the *.so* and *.hpp* files of CGAL might be on your machine. For that, you might find the bash commands **`which gcc-6`** and **`locate libCGAL`** useful. 

#### *The Haskell part*
Go up one level into **codeHaskell-pho**, and type

```zsh
 stack build
```

Now sit back and enjoy a mojito! Stack will take care of fetching the appropriate Haskell libraries (even the Haskell compiler GHC!) if they have not been installed on your machine and then compiling the `.hs` packagehandoff source-code inside `src` and `app`. **This process can take upto 30-40 mins if you did not have the [Haskell platform](https://www.haskell.org/platform/) installed already**

## Build and Run

That long build process you just witnessed, was due to the many dependencies needed by your computer. If you make changes to the existing library code in **PackgeHandoff.org** or write your own `Main.hs` file inside *codeHaskell-pho/app*, type **`stack build`** at the command prompt to re-compile.  

`codeHaskell-pho/app` contains `Main.hs` which creates a [Gloss](http://gloss.ouroborus.net/) canvas onto which you can interactively insert robots, adjust their fuel, place packages and use one of the algorithms displayed at the command prompty to generate and then animate the schedule. To execute the executable for this `Main.hs` function type **`stack exec main`** at the command-prompt. 

All "`Main.hs`-type" files (i.e. those with `main::IO ()` functions) go into `app`. These files are constantly in flux depending on the computational experiment; hence they are developed separately with their own literate files inside `app` .   
## Editing the Library Code

If you want to add  new algorithms or bug-fixes to existing code inside `PackageHandoff.org`, do the editing with Emacs and tangle the file with `C-c C-v t`.
