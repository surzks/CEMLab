# Boundary Element Method - Electrostatics
In the previous labs, we have used the Finite Element Method (FEM) to solve differential equations.
Identical problems can also be described using integral equations, which can be solved using the Boundary Element Method (BEM).

In the case of electrostatics, we have introduced the Possion's equation 
$$\nabla^2 \phi = -\frac{\rho}{\epsilon_0},$$
where $\phi$ is the electric potential, $\rho$ is the charge density and $\epsilon_0$ is the permittivity of free space.
This is the differential equation formulation. 
The solution of Poisson’s equation in free space can be constructed by superposing the contributions $\phi(\bm r) = q/4\pi \varepsilon_0 |\bm r - \bm r'|$ from all point charges $q = \rho_\nu d V$ located at positions $\bm r'$:
$$\phi(\bm r) = \frac{1}{\varepsilon_0} \mathcal{S} \rho.$$

If the potential $\phi$ is known  this can be seen as an integral equation for the charge density $\rho$.

This integral equation is suited for problems such as capacitance calculations, where the potential is known on the the conducting boundaries and charges only occur on these boundaries, such as a plate capacitor such as depicted in Figure 1.

<div style="text-align: center; margin-top: -30px;">
  <figure style="display: inline-block; text-align: center; margin: 0;">
    <svg width="600" height="300" xmlns="http://www.w3.org/2000/svg">
      <!-- Top plate -->
      <line x1="100" y1="80" x2="500" y2="80" stroke="white" stroke-width="2" />
      <!-- Bottom plate -->
      <line x1="100" y1="220" x2="500" y2="220" stroke="white" stroke-width="2" />
      <line x1="105" y1="90" x2="105" y2="210" stroke="white" stroke-dasharray="3,3" 
        marker-start="url(#arrowStart)" marker-end="url(#arrowEnd)"/>
      <text x="75" y="155" fill="white" font-family="serif" font-style="italic" font-size="18">a</text>
      <!-- Width w arrows (top) -->
      <line x1="105" y1="70" x2="495" y2="70" stroke="white" stroke-dasharray="3,3" 
            marker-start="url(#arrowStart)" marker-end="url(#arrowEnd)" /> 
      <text x="300" y="60" fill="white" font-family="serif" font-style="italic" font-size="16">w</text>
      <!-- Width w arrows (bottom) -->
      <line x1="105" y1="230" x2="495" y2="230" stroke="white" stroke-dasharray="3,3" 
            marker-start="url(#arrowStart)" marker-end="url(#arrowEnd)" />
      <text x="300" y="250" fill="white" font-family="serif" font-style="italic" font-size="16">w</text>
      <!-- Labels on right -->
      <text x="520" y="85" fill="white" font-family="serif" font-style="italic" font-size="16">+V/2, +Q</text>
      <text x="520" y="225" fill="white" font-family="serif" font-style="italic" font-size="16">−V/2, −Q</text>
      <!-- Arrow marker definition -->
    <defs>
    <!-- Left-pointing arrowhead -->
    <marker id="arrowStart" markerWidth="10" markerHeight="10" refX="4" refY="3" orient="auto">
      <path d="M9,0 L9,6 L0,3 z" fill="white" />
    </marker>
    <!-- Right-pointing arrowhead -->
    <marker id="arrowEnd" markerWidth="10" markerHeight="10" refX="5" refY="3" orient="auto">
      <path d="M0,0 L0,6 L9,3 z" fill="white" />
    </marker>
  </defs>
    </svg>
    <figcaption style="color: white; font-style: italic; font-size: 0.9em; margin-top:-50px;margin-bottom:40px;">
      Figure 1: Parallel plate capacitor.
    </figcaption>
  </figure>
</div>


As an alternative to solving Laplace's equation in the entire domain, we can calculate the charges $\rho_s$ on the conductors by solving the integral equation

$$\frac{1}{\varepsilon_0} \mathcal{V}\rho = \phi_\text{spec}(\bm r)\,. $$

In the 2D case the surface integral reduces to a line integral, that is
$$-\frac{1}{2\pi \varepsilon_0} \int_{\Gamma } \rho(\bm r')\ln |\bm r - \bm r'| d\ell' = \phi_\text{spec}(\bm r)\,. $$

## FEM Solutions
The charge distribution $\rho$ can be approximated using $N$, in this case, constant basis functions $s_k(\bm r)$, similar to the FEM:
$$\rho(\bm r) \approx \sum_{k=1}^N \rho_k s_k(\bm r)\,.$$
For convenience, we introduce the potential created by the basis functions:
$$\phi_k(\bm r) = \int G(\bm r , \bm r') s_k(\bm r') d\ell' \,.$$
Then, the approximate potential is given by
$$\bar{\phi}(\bm r) = \sum_{k=1}^N a_k \phi_k(\bm r)\,.$$
### Testing Procedure
We want to enforce the condition $\bar{\phi}(\bm r) = \phi_\text{spec}(\bm r)$ ont he conducting surfaces where the potential is known; that is, minimize the residual $r = \sum_k a_k\phi_k- \phi_\text{spec}$.
Typically, this is done using a Galerkin approach, where we choose weighting functions $w_j$, $j=1,\ldots,N$, and enforce the condition
$$\int_\Gamma w_j(\bm r) [ \bar{\phi}(\bm r) - \phi_\text{spec}(\bm r) ] d l = 0\,.$$

For the sake of simplicity, we will use in this lab the point matching, also known as collocation and the Nystrom method, where we choose the weighting functions as Dirac delta functions centered at the midpoints of each element. This leads to the condition
$$\bar{\phi}(\bm r_i) = \phi_\text{spec}(\bm r_i)\,, \quad i=1,\ldots,N\,,$$
where $\bm r_i$ are the collocation points.

### Integration 
We divide the conducting plates into elements $x' \in [x_i, x_{i+1}]$ and use piecewise constant basis functions to represent the charge density. The testing is done at the midpoints of each element $x_{\text{test}, i} = (x_i + x_{i+1})/2$.
To get the potential from a piecewise constant charge distribution, we need to evaluate integrals of the form
$$ I(\xi_s, \xi_e, d) = -\frac{1}{2\pi \varepsilon_0} \int_{\xi_s}^{\xi_e} \ln \sqrt{x^2 + d^2} \, dx \,,$$
where $d$ is the distance in the perpendicular direction from the element to the point where the potential is evaluated.

### System of Equations
Using the above definitions, we can write the system of equations to be solved as
$$\sum_{k=1}^N \rho_k \phi_k(\bm r_i) = \phi_\text{spec}(\bm r_i)\,, \quad i=1,\ldots,N\,.$$
This can be written in matrix form as
$$\bm A \boldsymbol{\rho} = \boldsymbol{\phi}_\text{spec}\,,$$
where $\bm{A}$ is the potential matrix, $\boldsymbol{\rho}$ is the vector of unknown charges and $\boldsymbol{\phi}_\text{spec}$ is the vector of specified potentials at the collocation points.
