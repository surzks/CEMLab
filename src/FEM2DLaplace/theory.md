# Finite Element Method - Laplace Equation

## Introduction
In this lab we will revisit the finite element method (FEM) for a two-dimensional problem. 
We consider the two-dimensional conducting plate with a potential difference on opposite sides, as depicted in Figure 1.

<div style="text-align:center; margin:-20pt; padding:0;">
  <figure style="display:inline-block; text-align:center; margin:0; padding:0;">
    <div style="margin:0; padding:0; line-height:0;">
      <svg width="520" height="420" viewBox="-0.65 -0.65 1.30 1.30" xmlns="http://www.w3.org/2000/svg" style="display:block; margin:0 auto; padding:0; background-color:transparent;">
        <style>
          .outline { fill: none; stroke: currentColor; stroke-width: 0.01; }
          .boundary2 { fill: black; stroke: currentColor; stroke-width: 0.025; }
          .boundary { fill: black; stroke-dasharray: 0.04, 0.04; stroke: currentColor; stroke-width: 0.025; }
          .label { font-family: Arial, sans-serif; font-size: 0.1px; fill: currentColor; }
          .label_small { font-family: Arial, sans-serif; font-size: 0.07px; fill: currentColor; }
        </style>
        <g transform="scale(1,-1)">
          <!-- Domain boundary -->
          <path class="outline" 
            d="M -0.5 0.5 
               L 0.5 0.5 
               L 0.5 -0.5 
               L 0.0 -0.5 
               A 0.5 0.5 0 0 1 -0.5 0.0 
               L -0.5 0.5 
               Z"/>
          <!-- Dark boundary segments -->
          <path class="boundary" d="M -0.5 0.0 L -0.5 0.5"/>
          <path class="boundary2" d="M 0.0 -0.5 L 0.5 -0.5"/>
          <!-- Labels (flip text back upright) -->
          <text class="label" x="0.3" y="-0.3" transform="scale(1,-1)">Ω</text>
          <text class="label_small" x="-0.63" y="-0.23" transform="scale(1,-1)">Γ₁</text>
          <text class="label_small" x="0.2" y="0.59" transform="scale(1,-1)">Γ₂</text>
        </g>
      </svg>
    </div>
    <figcaption style="color:currentColor; font-style:italic; font-size:0.9em; margin-top:-10px; margin-bottom:40px;">
      Figure 1: Domain Ω with boundary segments Γ₁ and Γ₂.
    </figcaption>
  </figure>
</div>

In this lab we want to solve the 2D Laplace equation
$$\nabla^2 u = 0 \quad \text{in} \,\, \Omega,$$
with the boundary conditions $u = 1$ on $\Gamma_1$, $u = -1$ on $\Gamma_2$, and $\frac{\partial u}{\partial n} = 0$ on the remaining boundary.

## Weak Formulation
To derive the weak formulation we start by multiplying the PDE by a test function $w_i$ and integrate over the domain $\Omega$:
$$\int_\Omega w_i \nabla^2 u \, d\Omega = 0.$$
Next, we integrate by parts and use the identity 
$$\nabla\cdot[w_i(\nabla u)] = \nabla w_i + w_i \nabla^2 u$$
and Gauss's theorem in 2D
$$\int_\Omega \nabla\cdot \bm F \, d\Omega = \int_{\partial \Omega} \bm F \cdot \bm n \, d\Gamma,$$
to obtain
$$\int_\Omega \nabla w_i \cdot \nabla u \, d\Omega - \int_{\partial \Omega} w_i \frac{\partial u}{\partial n} \, d\Gamma = 0.$$
Since we have Dirichlet boundary conditions on $\Gamma_1$ and $\Gamma_2$, the test functions $w_i$ vanish on these boundaries. 
Thus, the boundary integral only remains on the Neumann boundary, where $\frac{\partial u}{\partial n} = 0$. 
Therefore, the weak form reduces to
$$\int_\Omega \nabla w_i \cdot \nabla u \, d\Omega = 0.$$

## Finite Element Discretization
We discretize the potential $u$ using piecewise linear shape functions $\phi_j$ defined on triangular elements:
$$u \approx \sum_{j=1}^{N} u_j \phi_j,$$
where $N$ is the total number of vertices in the mesh, and $u_j$ are the coefficients to be determined.
Substituting this approximation into the weak form and choosing the test functions $w_i$ to be the same shape functions $\phi_i$ (Galerkin ansatz), we obtain obtain a linear system of equations $\bm A \bm u = \bm b$, where the elements are given by
$$A_{ij} = \int_\Omega \nabla \phi_i \cdot \nabla \phi_j \, d\Omega,$$
and
$$b_i = 0.$$
Here, the index $j$ runs over all vertices in the mesh, and $i$ only over those where $u$ is unknown (i.e., not on Dirichlet boundaries).
Therefore the variables can be reordered to collect those where $u$ is known in the vector $\bm u_e$, while $\bm u_n$ contains the unknowns.
The system of equations can then be written as
$$\begin{bmatrix} \bm A_{nn} & \bm A_{ne} \\ \bm A_{en} & \bm A_{ee} \end{bmatrix} \begin{bmatrix} \bm u_n \\ \bm u_e \end{bmatrix} = \begin{bmatrix} \bm 0 \\ \bm 0 \end{bmatrix},$$
which can be rearranged to 
$$\bm A_{nn} \bm u_n = -\bm A_{ne} \bm u_e.$$

## Evaluation of Gradients
The gradients that we have to to be evaluated are with respect to the physical coordinates. 
To compute these, we first compute the gradients with respect to the reference coordinates and then use the inverse of the Jacobian of the mapping from reference to physical space to compute the physical gradients.

Consider the reference triangle with vertices at $(0,0)$, $(1,0)$, and $(0,1)$ and the shape functions defined on this triangle

$$\hat{\phi_1}(\xi, \eta) = 1 - \xi - \eta \\
\hat{\phi_2}(\xi, \eta) = \xi\\
\hat{\phi_3}(\xi, \eta) = \eta\,.$$

The gradients of these shape functions with respect to the reference coordinates $(\xi, \eta)$ given by
$$\nabla_{\text{ref}} \hat{\phi_1} = \begin{bmatrix}-1 \\ -1\end{bmatrix}\,, \quad
\nabla_{\text{ref}} \hat{\phi_2} = \begin{bmatrix}1 \\ 0\end{bmatrix}\,, \quad
\nabla_{\text{ref}} \hat{\phi_3} = \begin{bmatrix}0 \\ 1\end{bmatrix}\,,$$

and the Jacobian matrix $J$ of the transformation from reference to physical space by
$$J = \begin{bmatrix}\frac{\partial x}{\partial \xi} & \frac{\partial x}{\partial \eta} \\ \frac{\partial y}{\partial \xi} & \frac{\partial y}{\partial \eta}\end{bmatrix}.$$

The gradients with respect to the physical coordinates $(x,y)$ are then computed using the relation
$$\nabla \phi = J^{-T} \nabla_{\text{ref}} \hat{\phi},$$
where $J^{-T}$ is the inverse transpose of the Jacobian matrix.
