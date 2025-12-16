# Problems - BEM2D

## Problem 1: CompScienceMeshes
Add CompScienceMeshes with
```
pkg> dev CompScienceMeshes
``` 
to your Julia environment.
In the tests of CompScienceMeshes you find under `test/primitives/linemeshes/test_curve.jl`
an example for creating line meshes for a two dimensional manifold.

Test this functionality and create a circular line mesh with radius $r=1$. For plotting you find a function in the `src`folder.

## Problem 2:
Install the `BEAST` package and create all operators we need for TM-EFIE and TM-MFIE.
The test file `test/test_hh2d_mie.jl` might be helpful.

## Problem 3:
Create a space of linear basis functions on the line mesh you created in Problem 1.

## Problem 4:
Assemble the TM-EFIE system matrix and analyze the condition number in dependence of the number of basis functions.

## Problem 5:
Compare now the condition number of the TM-EFIE system matrix with and without calderon preconditioning applied.

## Problem 6: 
Solve for both the TM-EFIE and TM-MFIE the system of equations with gmres from the Krylov.jl package and visualize the cross-section and the potential around the cylinder for the TM-EFIE.
For the visualization we need to create an excitation and the `potential` function from the `BEAST` package.
The `test/test_hh2d_mie.jl` as well es the tutorial from the documentation of `BEAST` might be helpful.

## Problem 7:
Compare the computed surface current densities of the TM-EFIE and TM-MFIE.