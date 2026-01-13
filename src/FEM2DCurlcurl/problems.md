# Problems - FEM2DWaveguides

## Problem 1
Similar to the laplace case we need to define our operator and the associated function `integrand()`, `scalartype()`, and `kernelvals()` BEAST requires.
Contrary to the laplace case, our basis functions (Nedelec) are already defined including their curls.

## Problem 2
Generate a 2D rectangular mesh, define the operator, and the basis functions. Nedelec basis functions are defined in BEAST as `BEAST.nedelec()`.
How do we need to discretize such that the boundary conditions are satisfied?

## Problem 3
Solve the eigenvalue problem and remove the null space solutions.

## Problem 4
Compare the eigenvalues with the analytical solution and analyze the convergence behavior.

## Problem 5
Visualize the eigenvectors in a heatmap plot.
