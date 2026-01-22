# Boundary Element Method in 3D
In this lab we will solve integral equations using the Boundary Element Method (BEM) in three-dimensional space. 
We solve for the scattered field for a given incident plane wave interacting with a sphere.

## Integral equations
### EFIE
The Electric Field Integral Equation (EFIE) for a perfectly conducting sphere can be expressed as:
$$ \mathcal{T}\bm j = (jk\mathcal{T}_\text{A} + jk^{-1}\mathcal{T}_\Phi) = \hat{\bm{n}} \times \bm e^\text{i} $$
where $k$ is the wavenumber, $\hat{\bm{n}}$ is the unit normal vector on the surface of the sphere, $\bm e^\text{i}$ is the incident electric field, and $\bm j$ is the unknown surface current density. The operators $\mathcal{T}_\text{A}$ and $\mathcal{T}_\Phi$ are defined as:
$$(\mathcal{T}_\text{A}\bm j)(\bm r) = \hat{\bm{n}} \times \int_{\Gamma} G(\bm r, \bm r')\bm j(\bm r') dS'(\bm r')\,,$$
and 
$$(\mathcal{T}_\Phi\bm j)(\bm r) = \hat{\bm{n}} \times \nabla_\Gamma \int_{\Gamma} G(\bm r, \bm r') \nabla_\Gamma \cdot \bm j(\bm r') dS'(\bm r')\,,$$
where $G(\bm r, \bm r')$ is the free-space Green's function.

### MFIE
The Magnetic Field Integral Equation (MFIE) for a perfectly conducting sphere is given by:
$$ \frac{\mathcal{I}}{2}\bm j + \mathcal{K}\bm j = \hat{\bm{n}} \times \bm h^\text{i} $$
where $\bm h^\text{i}$ is the incident magnetic field, and the operator $\mathcal{K}$ is defined as:
$$(\mathcal{K}\bm j)(\bm r) = -\hat{\bm{n}} \times  \int_{\Gamma} \nabla G(\bm r, \bm r') \times \bm j(\bm r') dS'(\bm r')\,.$$
