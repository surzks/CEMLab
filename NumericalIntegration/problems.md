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

