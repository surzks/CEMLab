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
