# Problems - Numerical Integration

## Problem 1: Implement the Midpoint Rule
Implement the midpoint rule for numerical integration. Implement a functor `Midpoint` that is a subtype of `NewtonCotesRule` that computes the integral of a function `f` over an interval `[a, b]` using the midpoint rule.

## Problem 2: Test the Midpoint Rule
Test your implementation of the midpoint rule by integrating a simple function, such as $f(x) = x^2$, over the interval $[0, 1]$. Compare the result with the exact value of the integral.

## Problem 3 : Composite Midpoint Rule
Extend your implementation to support the composite midpoint rule. This involves dividing the interval `[a, b]` into `n` subintervals and applying the midpoint rule on each subinterval. Implement a functor `CompositeNewtonCotes` that is a subtype of `IntegrationRule` that takes a `NewtonCotesRule` and an integer `n` as parameters.
The functor should compute the integral of a function `f` over an interval `[a, b]` using the specified Newton-Cotes rule applied to `n` subintervals.

## Problem 4: Test the Composite Midpoint Rule
Test your implementation of the composite midpoint rule by integrating a simple function, such as $f(x) = x^2$, over the interval $[0, 1]$ using different values of `n` (e.g., `n = 1, 2, 4, 8`). Compare the results with the exact value of the integral and observe how the accuracy improves as `n` increases.

## Problem 5: Error Analysis
Consider the integral 

$$I = \int_0^1 x^2 \cos(10x^2) \, dx.$$

How many quadrature points are required to accurately evaluate this and other integrals with a similar form using the midpoint rule? Why? Is there a quadrature rule that could accurately evaluate this integral using a few points or only one point? Why or why not?

### Solution    
*The integral $I = \int_0^1 x^2 \cos(10x^2) \, dx$ is a highly oscillatory integral due to the presence of the cosine function with a rapidly changing argument $10x^2$.
To accurately evaluate this integral using the midpoint rule, a large number of quadrature points would be required.
This is because the midpoint rule approximates the function by evaluating it at the midpoint of each subinterval, and for highly oscillatory functions, the function can change significantly within small intervals. 
Therefore, to capture the oscillations accurately, we need to use a finer partition of the interval $[0, 1]$, which means increasing the number of quadrature points independent of the integration rule which is used.
However, there are quadrature rules that can handle oscillatory integrals more efficiently. One such rule is the Gaussian quadrature, specifically designed to integrate polynomials and certain classes of functions with high accuracy using a small number of points.*

## Problem 6: Implement Gauss-Legendre Quadrature
Implement the Gauss-Legendre quadrature method for numerical integration. Create a functor `GaussLegendre` that is a subtype of `IntegrationRule` and holds the quadrature points and weights given a order `n` as a parameter. 
The functor computes the integral of a function `f` over an interval `[-1, 1]` using the Gauss-Legendre quadrature method. 

**Hint: Use the `FastGaussQuadrature` package to obtain the quadrature points and weights.** 

## Problem 7: Derive the Mapping for a General Interval
Derive the affine transformation that maps the interval $[-1, 1]$ to an arbitrary interval $[a, b]$. 
### Solution
*Assume a linear relation of the form:*
$$x = \alpha \xi + \beta$$
*where $\xi \in [-1, 1]$ is the reference variable, $x \in [a, b]$ is the target variable, $\alpha, \beta$ are constants to be determined.
We require:*
$$
\begin{cases}
\xi = -1 \implies x = a, \\
\xi = 1 \implies x = b.
\end{cases}
$$
*Substituting these gives:*
$$
\begin{aligned}
a &= -\alpha + \beta, \\
b &= \alpha + \beta.
\end{aligned}
$$
*Add the two equations:*
$$a + b = 2\beta \implies \boxed{\beta = \frac{a + b}{2}}.$$

*Subtract the first from the second:*

$$b - a = 2\alpha \implies \boxed{\alpha = \frac{b - a}{2}}.$$
$$\boxed{x = \frac{b - a}{2}\,\xi + \frac{a + b}{2}}$$

*To express $\xi$ in terms of $x$:*

$$\boxed{\xi = \frac{2x - (a + b)}{b - a}}.$$

*When changing variables in an integral:*

$$dx = \frac{b - a}{2}\, d\xi.$$

*Therefore:*

$$
\int_a^b f(x)\,dx
= \int_{-1}^{1} f\!\left(\frac{b - a}{2}\xi + \frac{a + b}{2}\right) \frac{b - a}{2}\, d\xi.
$$


## Problem 8: Gauss-Legendre Quadrature on a General Interval
Extend your implementation of the Gauss-Legendre quadrature to handle integration over an arbitrary interval `[a, b]`. Modify the functor `GaussLegendre` such that it takes the function `f` and the interval `[a, b]` as parameters and performs the necessary change of variables to map the interval `[-1, 1]` to `[a, b]`.

## Problem 9: Test the Gauss-Legendre Quadrature
Test your implementation of the Gauss-Legendre quadrature by integrating the function
$$f(x) = x^2 \cos(10x^2)$$
over the interval `[0, 1]` using different orders (e.g., `n = 2, 3, 4`). Compare the results with the analytical value of the integral.

## Problem 10: Convergence Analysis
Implement a function that estimates the order of convergence `p` following the formula given in the theory section.

## Problem 11: Compare Different Quadrature Rules
Compare the performance of the midpoint rule, composite midpoint rule, and Gauss-Legendre quadrature for integrating the function
$$f(x) = x^2 \cos(10x^2)$$
over the interval `[0, 1]`. Analyze the accuracy and convergence of each method as the number of quadrature points or order increases.