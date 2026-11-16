# Problems-FEM1D

## Problem 1: 
Consider the following boundary value problem (BVP):
$$\nabla \cdot (\varepsilon(x) \nabla u(x)) = 0\,,$$
where $u(0) = C_\text{DL}$ and $u(1) = C_\text{DR}$.

Derive the FEM weak formulation of the above equation.

## Problem 2:

Create a struct for Laplace operator and store the permittivity $\varepsilon$ as a function.

## Problem 3:

To create function spaces for our test and trial functions, create a struct `Shape` such that it stores the following information:
- segment index
- reference index
- coefficient

Create an abstract type `Space`. As a subtype of `Space`, create a type `LagrangeBasis` that stores the following information:
- differentiability, continuity, number of shape functions per element
- mesh
- shape functions
- positions of the shape functions

Also define a utility function `numshapefns_per_element` to return the number of shape functions per element.

## Problem 4:

Next, to define a basis, define a function `lagrangebasisc0d1` that takes in the mesh and returns a `LagrangeBasis` object with linear basis functions.

## Problem 5:

Write a function `assemble` that takes in a mesh and returns the system matrix.

## Problem 6:

Define a function `cellinteractions!` that computes and returns the local system matrix. For this, we will need to define a function `integrand` that computes the integrand of the weak formulation.

## Problem 7:
With all the utility functions setup, let us now return to the problem at hand. Write a function `dielectricwindow` that
- accepts the position $x$
- accepts the keyword arguments $\varepsilon$ = 1.0, window_radius = 0.2, window_center = 0.5
- returns the permittivity $\varepsilon(x)$ as a function of position $x$.

## Problem 8:

Solve the Dirichlet boundary value problem
1. set $C_\text{DL}$ = 5, $C_\text{DR}$ = 10 number of elements = 10 (also permittivity $\varepsilon$ as a keyword argument).
2. Create the mesh, define the trial and test functions, and assemble the system matrix.
3. Apply boundary conditions.
4. Obtain the solution vector by solving the system of solutions.

## Problem 9:

Plot the solution against the mesh nodes using the Plots package.