# Finte Element Method-1D

## Introduction
In this lab we will introduce the finite element method (FEM), a numerical technique for solving partial differential equations (PDEs) over complex geometries. For the sake of simplicity we consider a 1D problem, where we derive given the PDE the weak formulation, construct basis functions, assemble the system matrix, and apply boundary conditions.

## Partial Differential Equation
We consider the second-order ordinary differential equation 
$$\nabla \cdot (\varepsilon(x) \nabla u(x)) = 0,$$
defined on the interval $[0, 1]$ with boundary conditions $u(0) = C_\text{DL}$ and $u(1) = C_\text{DR}$, where $\varepsilon(x)$ is the permittivity function.

## Weak Formulation
To solve a boundary value problem using FEM, the weak formulation has to be derived. 

The following steps outline the derivation of the weak formulation:
1. **Multiply by a Test Function**: Multiply both sides of the differential equation by a test function $v(x)$ that vanishes at the boundaries (i.e., $v(0) = 0$ and $v(1) = 0$).
2. **Integrate Over the Domain**: Integrate the resulting equation over the domain.
3. **Apply Integration by Parts**: Use integration by parts to transfer the derivative from $u(x)$ to $v(x)$. The boundary term vanishes due to the choice of test functions.
4. **Final Weak Formulation**: The weak formulation of the problem is to find $u(x)$ such that:
   $$\int_0^1 \varepsilon(x) \nabla u(x) \nabla v(x) \, dx = 0,$$
   for all test functions $v(x)$.

## Basis Functions
In FEM, we approximate the solution $u(x)$ using a finite set of basis functions. Commonly used basis functions in 1D are piecewise linear functions, also known as Lagrange basis functions. These functions are defined over each element of the mesh and have the following properties:
- They are equal to 1 at their associated node and 0 at all other nodes.
- They are continuous across element boundaries.


<svg viewBox="-1.2 -1.2 7 2.8" xmlns="http://www.w3.org/2000/svg">
  <style>
    svg {
      background-color: white;
    }
    line, path {
      stroke: black;
    }
    text {
      fill: black;
    }
  </style>
  <!-- Axes -->
  <line x1="0" y1="1" x2="5" y2="1" stroke-width="0.02" stroke-dasharray="0.1 0.1"/>
  <line x1="0" y1="1" x2="1" y2="1" stroke-width="0.06" />
  <line x1="3" y1="1" x2="5" y2="1" stroke-width="0.06" />
  <line x1="0" y1="1.3" x2="5" y2="1.3" stroke-width="0.02"/>
  <line x1="0" y1="-0.75" x2="0" y2="1.3" stroke-width="0.02" />
  <!-- Basis functions -->
  <g fill="none" stroke-width="0.02">
    <path d="M 0 0 L 1 1 L 2 0 L 3 1 L 4 0 L 5 1" stroke-dasharray="0.1 0.1"/>
    <path d="M 0 1 L 1 0 L 1 0 L 2 1 L 3 0 L 4 1 L 5 0" stroke-dasharray="0.1 0.1"/>
    <path d="M 1 1 L 2 0 L 3 1" stroke-width="0.08" />
  </g>
  <!-- Axis labels -->
  <g font-size="0.2px" text-anchor="middle">
    <text x="-0.2" y="0">1</text>
    <text x="0" y="1.5">0</text>
    <text x="1" y="1.5">1</text>
    <text x="2" y="1.5">2</text>
    <text x="3" y="1.5">3</text>
    <text x="4" y="1.5">4</text>
    <text x="5" y="1.5">5</text>
    <text x="2.5" y="1.8" font-size="0.25px">x</text>
  </g>
  <!-- Y-axis label -->
  <text x="-0.7" y="0.3" transform="rotate(-90 -0.7,0.3)" 
        font-size="0.25px" text-anchor="middle">
    Basis function
  </text>
</svg>


Using the Galerkin method, where the test functions are chosen to be the same as the basis functions, the weak form expressed in terms of these basis functions is expressed as

$$ \sum_{i,j}^N u_j \int_0^1 \varepsilon(x) \nabla \phi_j(x) \nabla \phi_i(x) \, dx = 0, $$

where $u_j$ are the coefficients to be determined, $N$ is the number of basis functions, and $\phi_i(x)$ are the basis functions.

## Assembly of the System Matrix
To solve the above weak form, we need to assemble the system matrix. This involves computing the entries of the matrix using the basis functions and the permittivity function. The entries of the system matrix $\mathcal{S}$ are given by

$$ \mathcal{S}_{ij} = \int_0^1 \varepsilon(x) \nabla \phi_j(x) \nabla \phi_i(x) \, dx. $$

The assembly process involves iterating over each element in the mesh, computing the local matrix for that element (cell interactions), and then adding it to the global system matrix.

## Enforcing Boundary Conditions
To incorporate the Dirichlet boundary conditions into the system, we modify the system matrix and the right-hand side vector. This typically involves setting the rows and columns corresponding to the boundary nodes to enforce the specified values of $u(0)$ and $u(1)$. This splits the solution into known and unknown parts, which in a block form can be represented as

$$
\begin{bmatrix}
   \mathcal{S}_{\text{NN}} & \mathcal{S}_{\text{NE}} \\
   \mathcal{S}_{\text{EN}} & \mathcal{S}_{\text{EE}}
\end{bmatrix}\,
\begin{bmatrix}
   u_{\text{N}} \\
   u_{\text{E}}
\end{bmatrix} =
\begin{bmatrix}
   0 \\
   0
\end{bmatrix}\,,
$$
where the subscripts N and E denote the natural (unknown) and essential (known) parts of the solution, respectively. After applying the boundary conditions, we solve for the unknown coefficients $u_{\text{N}}$:
$$ \mathcal{S}_{\text{NN}} u_{\text{N}} = -\mathcal{S}_{\text{NE}} u_{\text{E}}.$$

When the RHS of the equation is not zero, as in the case of the Poisson equation; the RHS vector also needs to be assembled. For the Poisson equation given by the following equation
$$\nabla \cdot (\varepsilon(x) \nabla u(x)) = \rho(x)\,,$$
the equivalent weak form becomes
$$\int_0^1 \varepsilon(x) \nabla u(x) \nabla v(x) \, dx = \int_0^1 \rho(x) v(x) \, dx\,.$$
The right-hand side vector entries are given by
$$ b_j = \int_0^1 \rho(x) \phi_j(x) \, dx\,.$$

The matrix equation then becomes
$$ \mathcal{S_\text{NN}} u_\text{N} = \mathbf b - \mathcal{S_\text{NE}} u_\text{E}\,.$$

## Solving the System
Once the system matrix and the right-hand side vector are assembled and boundary conditions are applied, we can solve the resulting linear system to obtain the coefficients $u_j$. The total solution $u(x)$ can then be constructed by combining these coefficients with the known boundary values.

## Validation and Convergence
To validate the FEM implementation, we can compare the numerical solution with an analytical solution to the problem considered in `problems.md`, given by the expression
$$ u(x) = C_\text{DL} + \frac{C_\text{DR} - C_\text{DL}}{\int_0^1 \frac{1}{\varepsilon(t)} \, dt} \int_0^x \frac{1}{\varepsilon(t)} \, dt. $$

To derive the solution, start from the differential equation given and integrate it once to get
$$ \varepsilon(x) \nabla u(x) = C_1\,, $$
where $C_1$ is a constant. Rearranging gives
$$ \nabla u(x) = \frac{C_1}{\varepsilon(x)}\,. $$
Applying a change of variable from $x$ to $t$ and integrating from 0 to $x$ yields
$$ u(x) - u(0) = C_1 \int_0^x \frac{1}{\varepsilon(t)} \, dt\,. $$
Using the boundary condition at $x=1$ to solve for $C_1$ gives
$$ C_1 = \frac{C_\text{DR} - C_\text{DL}}{\int_0^1 \frac{1}{\varepsilon(t)} \, dt}\,. $$
Substituting back into the expression for $u(x)$ gives the final solution.
Let $w_\text{c}$ be the window center, $w_\text{r}$ be the window radius, and $\varepsilon_w$ be the permittivity inside the window. Then the analytical solution can be expressed as
$$
u(x) = 
\begin{cases}
   C_\text{DL} + (C_\text{DR} - C_\text{DL}) x \quad & x < w_\text{c} - w_\text{r} \\
   C_\text{DL} + \frac{C_\text{DR} - C_\text{DL}}{1/\varepsilon_w} ( w_\text{c} - w_\text{r} + \frac{x - (w_\text{c} - w_\text{r})}{\varepsilon_w} ) \quad & w_\text{c} - w_\text{r} \leq x < w_\text{c} + w_\text{r} \\
   C_\text{DR} + (C_\text{DL} - C_\text{DR}) (w_\text{c} - w_\text{r} + \frac{2w_\text{r}}{\varepsilon_w} + x - (w_\text{c} + w_\text{r})) \quad & x \geq w_\text{c} + w_\text{r}
\end{cases}
$$

By refining the mesh with a geometric progression for the mesh size, we can study the convergence behavior of the FEM solution and ensure its accuracy.
