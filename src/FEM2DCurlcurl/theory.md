# Finite Element Method - Curl-curl Equation

## Introduction
In this lab we will apply the finite element method (FEM) to solve the Curl-curl equation, which arises in various fields such as acoustics, electromagnetics, and wave propagation. 
We will focus on a rectangular waveguide structure and analyze its modal properties.

<div style="text-align:center; margin:-20pt; padding:0;">
  <figure style="display:inline-block; text-align:center; margin:20pt; padding:0;">
    <div style="margin:0; padding:0; line-height:0;">
        <svg width="300" height="220" viewBox="0 0 300 220"
            xmlns="http://www.w3.org/2000/svg">
        <!-- White background -->
        <rect x="0" y="5" width="280" height="200" fill="white"/>
        <!-- Rectangle (domain) -->
        <rect x="60" y="40" width="180" height="120"
                fill="none"
                stroke="black"
                stroke-width="2"/>
        <!-- Interior label Ω -->
        <text x="150" y="105"
                text-anchor="middle"
                dominant-baseline="middle"
                font-size="24">
            Ω
        </text>
        <!-- Boundary label Γ -->
        <text x="150" y="30"
                text-anchor="middle"
                font-size="20">
            Γ
        </text>
        <!-- Side length a (bottom) -->
        <line x1="60" y1="175" x2="240" y2="175"
                stroke="black"/>
        <line x1="60" y1="170" x2="60" y2="180"
                stroke="black"/>
        <line x1="240" y1="170" x2="240" y2="180"
                stroke="black"/>
        <text x="150" y="195"
                text-anchor="middle"
                font-size="16">
            a
        </text>
        <!-- Side length b (left) -->
        <line x1="35" y1="40" x2="35" y2="160"
                stroke="black"/>
        <line x1="30" y1="40" x2="40" y2="40"
                stroke="black"/>
        <line x1="30" y1="160" x2="40" y2="160"
                stroke="black"/>
        <text x="20" y="105"
                text-anchor="middle"
                dominant-baseline="middle"
                font-size="16">
            b
        </text>
        </svg>
    </div>
    <figcaption style="color:currentColor; font-style:italic; font-size:0.9em; margin-top:0px; margin-bottom:20px;">
      Figure 1: Rectangle with side lengths a and b, boundary Γ, and interior Ω.
    </figcaption>
  </figure>
</div>


The Curl-curl equation in $\Omega$ and can be expressed as
$$\nabla\times (\mu^{-1} \nabla\times \bm E_\text{t}) = -k^2 \bm E_\text{t},$$
where $\bm E_\text{t}$ is the electric field, $k$ the wave number related to the frequency of the wave, and $\mu$ the permeability in $\Omega$.
For a rectangular waveguide with a PEC boundary $\Gamma$, we know that for the electric field, the tangential component must vanish on the boundary, leading 
$$ \hat{\bm n} \times (\mu^{-1}\bm E_\text{t})  = 0 \quad \text{on } \Gamma,$$
where $\hat{\bm n}$ is the outward normal vector on the boundary.

## Weak Formulation
To derive the weak formulation we start by multiplying the PDE by a test function $\bm w_i$ and integrate over the domain $\Omega$:
$$\int_\Omega (\nabla\times (\mu^{-1} \nabla \times \bm E_\text{t})) \cdot \bm w_i \,\text{d}\Omega= -k^2 \int_\Omega \bm E_\text{t} \cdot \bm w_i\,\text{d}\Omega$$
Next we use the vector identity
$$\nabla \cdot (\bm A \times \bm B) = \bm B \cdot (\nabla \times \bm A) - \bm A \cdot (\nabla \times \bm B)$$
and Gauss's theorem 
$$\int_\Omega \nabla\cdot \bm F \, d\Omega = \int_{\partial \Omega} \bm F \cdot \bm n \, d\Gamma,$$
to obtain
$$\int_\Omega \mu^{-1}(\nabla \times \bm w_i) \cdot (\nabla \times \bm E_\text{t}) \, d\Omega - \int_{\partial \Omega} (\bm n \times \bm E_\text{t}) \cdot (\nabla \times \bm w_i) \, d\Gamma = -k^2 \int_\Omega \bm E_\text{t} \cdot \bm w_i \, d\Omega.$$
with the boundary integral vanishing due to the PEC boundary condition, we arrive at the weak form:
$$\int_\Omega \mu^{-1}(\nabla \times \bm w_i) \cdot (\nabla \times \bm E_\text{t}) \, d\Omega = -k^2 \int_\Omega \bm E_\text{t} \cdot \bm w_i \, d\Omega.$$

## Finite Element Discretization
We expand the field variable $\bm u$ using vectorial shape functions $\bm N_j$ defined on triangular elements:
$$\bm u \approx \sum_{j=1}^{N_e} u_j \bm N_j,$$
where $N_e$ is the total number of edges in the mesh, and $u_j$ are the coefficients to be determined.
Substituting this approximation into the weak form and choosing the test functions $\bm w_i$ to be the same shape functions $\bm N_i$ (Galerkin ansatz), we obtain obtain a linear system of equations 
$$\bm S \bm u = -k^2 \bm M \bm u,$$
where 
$$S_{ij} = \int_\Omega \mu^{-1}(\nabla \times \bm N_i) \cdot (\nabla \times \bm N_j) \, d\Omega,$$
and
$$M_{ij} = \int_\Omega \bm N_i \cdot \bm N_j \, d\Omega.$$
This is a generalized eigenvalue problem, which can be solved for the eigenvalues $k^2$ and the corresponding eigenvectors $\bm u$ representing the modal fields in the waveguide.