# Problems-FEM1D

## Problem 1: 
Consider the following boundary value problem (BVP):
$$\nabla \cdot (\varepsilon(x) \nabla u(x)) = 0\,,$$
where $u(0) = C_\text{DL}$ and $u(1) = C_\text{DR}$.

Derive the FEM weak formulation of the above equation.

### Solution
*1. **Multiply by a Test Function**: Multiply both sides of the differential equation by a test function* $v(x)$ *that vanishes at the boundaries* (i.e., $v(0) = 0$ and $v(1) = 0$).

*2. **Integrate Over the Domain**: Integrate the resulting equation over the domain* $[0, 1]$:
   $$\int_0^1 v(x) \nabla \cdot (\varepsilon(x) \nabla u(x)) \, dx = 0\,.$$
*3. **Apply Integration by Parts**: Use integration by parts to transfer the derivative from* $u(x)$ *to* $v(x)$:
   $$-\int_0^1 \varepsilon(x) \nabla u(x) \nabla v(x) \, dx + \left[ v(x) \varepsilon(x) \nabla u(x) \right]_0^1 = 0\,.$$
   *The boundary term vanishes due to the choice of test functions.*

*4. **Final Weak Formulation**: The weak formulation of the problem is to find* $u(x)$ *such that*
   $$\int_0^1 \varepsilon(x) \nabla u(x) \nabla v(x) \, dx = 0\,,$$
   *for all test functions* $v(x)$ *in the appropriate function space. Find* $u(x)$ *in the same function space.*

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

## Problem 10:

The analytical solution to the above boundary value problem is given by
$$ u(x) = C_\text{DL} + \frac{C_\text{DR} - C_\text{DL}}{\int_0^1 \varepsilon(t) \, dt} \int_0^x \varepsilon(t) \, dt\,.$$

The derivation of the solution can be found in the `theory.md` file.

Implement a converge study of the error of the numerical solution with respect to the analytical solution by varying the number of elements in the mesh. Use the `estimate_covergence_order` function. Plot the error against the number of elements. Does it converge?

## Problem 11:

For a slight change, consider the Poisson equation
$$ \nabla \cdot (\varepsilon(x) \nabla u(x)) = \rho(x)\, $$
with the same boundary conditions as before.

Derive the FEM weak formulation of the above equation.

### Solution
*Following similar steps as in Problem 1, we have:*
$$\int_0^1 \varepsilon(x) \nabla u(x) \nabla v(x) \, dx = \int_0^1 \rho(x) v(x) \, dx\,.$$


## Problem 12:
We notice that we will need to modify our `Laplace` struct to account for the charge density $\rho(x)$. Create a new struct `Poisson` that is a subtype of `Laplace` and stores the charge density as a function of position x.

## Problem 13:
Notice that the LHS of our weak formulation remains unchanged. However, to account for the non-zero RHS, the assembly routine of the RHS vector needs to be modified. Write a function `cellinteractions!` that computes and returns the local RHS vector.

## Problem 14:
With all the utility functions setup, implement the same routine again to solve the Poisson equation with the following specifications:
1. Set the charge density $\rho(x) = 10$
2. set $C_\text{DL} = 5$, $C_\text{DR} = 10$ number of elements = 10 (also permittivity $\varepsilon$ and charge density $\rho$ as keyword arguments).
3. Create the mesh, define the trial and test functions, and assemble the system matrix and load vector.
4. Apply boundary conditions.
5. Obtain the solution vector by solving the system of solutions.