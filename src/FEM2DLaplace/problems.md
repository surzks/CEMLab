# Problems-FEM2D

## Problem 1
Define an operator `grad_grad` which represents the Laplace Operator and stores a scalar $\alpha$. 
To make this operator work with `BEAST.jl`, also define the integrand of the operator, which computes $\alpha \nabla \phi_i \cdot \nabla \phi_j$ for given shape functions $\phi_i$ and $\phi_j$, the function `scalartype` returning the type of the resulting matrix elements, and the function `kernelvals` which in this case returns a `nothing`.

## Problem 2
Overwrite the functor of `f::BEAST.LagrangeRefSpace{T,1,3}` to return the shape function, the curl, and the gradient.

## Problem 3 - GMSH
If you have GMSH installed, and added to your PATH, you can use run() to call prompt commands from Julia. You first need to mesh the provided geometry file `fem2dgeometry.geo`. the created `.msh` file can then be read by `CompScienceMeshes.read_gmsh_mesh`.

## Problem 4
Read the provided geometry and store the mesh. Plot the mesh and understand the boundaries, especially $\Gamma_1$ and $\Gamma_2$.

## Problem 5
The faces and edges of the mesh are 2D and 1D simplices, which can be accessed using the `skeleton` function in `BEAST.jl`.
Access the free vertices, the vertices on $\Gamma_1$, and those on $\Gamma_2$ separately and store them.

## Problem 6
Using the extracted vertices as the test functions and the mesh as the trial functions build a `lagrangec0d1` basis of type `Val{3}`.

## Problem 7
Assign the operator and assemble the 3 matrices.

## Problem 8
Enforce boundary conditions and solve the matrix equation to compute the solution at the free vertices after having enforced the boundary conditions.

## Problem 9
Construct the total space by concatenating all the vertices and compute the gradient.

## Problem 10
Compute the potential using the `facecurrents` function from `BEAST.jl` and plot the result.
