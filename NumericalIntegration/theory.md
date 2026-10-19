  # Numerical Integration — Theory

  ## Introduction
  Numerical integration (quadrature) deals with the computation of definite integrals $I=\int_a^b f(x)\,dx$.
  This document summarizes the main concepts, methods, error estimates and practical advice.

  ## Basic idea
  Split the interval $[a,b]$ into subintervals and locally approximate $f(x)$ by a simple function (constant, polynomial, etc.).
  Integrate the approximation exactly and sum the contributions — this yields a numerical quadrature rule.

  ## Newton–Cotes formulas
  Newton–Cotes uses equally spaced nodes.

  - Rectangle rule (left/right): 
    
    $$F = \frac{b-a}{2}(f(a))\,, \quad F = \frac{b-a}{2}(f(b))$$
    
    Error term: $E_R = \frac{(b-a)^3}{3}f''(\xi)$

  -  Midpoint rule:
     $$F=(b-a)f\bigl(\tfrac{a+b}{2}\bigr)$$
     Error term: $E_M = -\frac{(b-a)^3}{24}f''(\xi)$.

  - Trapezoidal rule:
  
    $$F=\frac{b-a}{2}(f(a)+f(b))$$
  
    Error term: $E_T = -\frac{(b-a)^3}{12}f''(\xi)$.

  - Simpson's rule (parabolic approximation):

    $$F=\frac{b-a}{6}\bigl(f(a)+4f(\tfrac{a+b}{2})+f(b)\bigr)$$

    Error term: $E_S = \frac{(b-a)^5}{2880}f^{(4)}(\xi)$.

### Composite rules:
For the Newton–Cotes rules to be accurate, the step size $h$ needs to be small, which means that the interval of integration $[a,b]$ must be small itself, which is not true most of the time. For this reason, one usually performs numerical integration by splitting $[a,b]$ into smaller subintervals, applying a Newton–Cotes rule on each subinterval, and adding up the results. This is called a composite rule.



## Gaussian Quadrature - Gauss-Legendre

Gauss–Legendre quadrature is the special case of Gaussian quadrature and approximates a function $f(x)$ by weighted polynomial evaluations so that the integral becomes a finite weighted sum.
```math
\int_{-1}^{1} f(x) \,\mathrm{d}x \approx \sum_{i=1}^n w_i \, f(x_i)
```
A Gauss-Legendre rule with $n$ nodes $x_i$ and weights $w_i$ integrates  all polynomials of degree up to $2n-1$ exact.

- The nodes $x_i$ are defined as the roots of the Legendre polynomial $P_n(x)$ of degree $n$ and are in the interior of the integration interval.
- The weights $w_i$ are positive and defined by
```math
w_i = \frac{2}{\bigl(1 - x_i^2\bigr)\bigl(P_n'(x_i)\bigr)^2}.
```

### Error Estimate
If $f$ is sufficiently smooth ($2n$ times continuously differentiable) there exists a point $x_i \in(-1,1)$ such that the quadrature error has the form

```math
  E_n(f) = \int_{-1}^1 f(x)\,dx - \sum_{i=1}^n w_i f(x_i) = C_n\, f^{(2n)}(\xi),
```

where $C_n$ is a constant depending only on $n$ (its exact closed form involves factorials and constants from the Legendre polynomials).
The important point is that the error depends on the $2n$-th derivative of $f$: Gauss–Legendre is extremely accurate for smooth functions.

If functions are non smooth or contain singularities, generalized Gaussian rules ([GeneralizedGaussianQuadrature.jl](https://github.com/JoshuaTetzner/GeneralizedGaussianQuadrature.jl)) or transformations that regularize the integrand have to be used.
 
### Mapping to a general interval
To integrate over an arbitrary interval $[a,b]$ use the affine change of variables

```math
x = \frac{2t-(a+b)}{b-a},\qquad t = \frac{(b-a)x+(b+a)}{2},
```

so that

```math
\int_a^b f(t)\,dt = \frac{b-a}{2} \int_{-1}^1 f\bigl(\tfrac{(b-a)x+(b+a)}{2}\bigr)\,dx \approx \frac{b-a}{2} \sum_{i=1}^n w_i \, f\bigl(\tfrac{(b-a)x_i+(b+a)}{2}\bigr).
```

 
## Convergence
For estimating the order of convergence of a quadrature rule numerically, one can use the formula

```math
p = \frac{\ln \left(\frac{I(h_i)-I(h_{i+1})}{I(h_{i+1})-I(h_{i+2})}\right)}{\ln \left(\frac{h_i}{h_{i+1}}\right)}
```
where $I(h_i)$ is the integral approximation with step size $h_i$.
When using this formula, it is important to ensure that the step sizes $h_i$ are sufficiently small so that the asymptotic regime is reached and the error behaves like $O(h^p)$ and that the step sizes are reduced consistently such that $\frac{h_i}{h_{i+1}}=\frac{h_{i+1}}{h_{i+2}}$.