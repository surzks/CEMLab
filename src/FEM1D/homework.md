# Homework - FEM1D

In this homework, we will solve a boundary value problem with a homogeneous ordinary differential equation, firstly by hand followed by coding it up. This should help clear up any confusion regarding the steps involved in FEM1D.

## Problem 1
Let us consider the following 1D boundary value problem:
$$ u(x)'' + k^2 u(x) = 0 \quad \text{for } x \in (0,1.2)\,, $$
with boundary conditions $u(0) = 0$ and $u'(1.2) = 1$.

This is a special ODE and has a name. Can you guess what it is?

We would like to solve this problem using a mesh with 3 elements of constant length 0.4 and lagrange basis functions of order 1.

Notice how the boundary conditions are different from what we saw in the tutorial. The first boundary condition is a Dirichlet boundary condition, while the second one is a Neumann boundary condition.

Can you guess the number of unknowns in the resulting linear system?

Draw a sketch of the mesh and the basis functions.

## Problem 2 
Derive the weak formulation of the above boundary value problem using a Galerkins approach.
Start by multiplying a test function $v$ and then integrate by parts
Finally, write the weak formulation in terms of lagrange basis functions of order 1.

**Hint: The Neumann boundary condition should be incorporated in the weak formulation.**

## Problem 3
Compute the integrals over each element to obtain the local system matrices.

**Hint: There are a total of 3 elements with 2 basis functions each. You will need to compute a total of 12 integrals. There are ways to reduce the number of integrals you need to compute. Can you think of any?**

## Problem 4
Assemble the system matrix by combining the local system matrices. You should obtain a 4x4 matrix.

## Problem 5:
Apply the boundary conditions to obtain a 3x3 system matrix. Solve the resulting linear system to obtain the solution vector.

## Problem 6:
Let's code it up! Just like how we defined the `Laplace` operator in the tutorial, define a struct with the name of this ODE. 
The value $k$ can be stored as a constant. 
Also define its corresponding `integrand` function.

Note: Here you will need to perform the integration over each element using numerical integration using Gaussian quadrature. What order of quadrature will you need to use?

## Problem 7:
Just like we did in the tutorial, create the mesh, define the trial and test functions using lagrange basis functions of order 1, and assemble the system matrix. Apply the boundary conditions and just like in the analytical solution the Neumann boundary condition should be handled as a vector on the right hand side.

## Problem 8:

Finally, derive, implement, and compare with the analytical solution. Increase k to 400. What do you observe? If the error is large, what could be the reason?

Now you can use FEM in you daily life! :)
