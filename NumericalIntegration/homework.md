# Homework - Numerical Integration

## Homework 1: Implement Trapezoidal Rule
Add the trapezoidal rule for numerical integration to `newton-cotes.jl`. Implement a functor `Trapezoidal` that is a subtype of `NewtonCotesRule` that computes the integral of a function `f` over an interval `[a, b]` using the trapezoidal rule.

## Homework 2: Implement Simpson's Rule
Add Simpson's rule for numerical integration to `newton-cotes.jl`. Implement a functor `Simpson` that is a subtype of `NewtonCotesRule` that computes the integral of a function `f` over an interval `[a, b]` using Simpson's rule.

## Homework 3: Compare the Rules
Compare the accuracy of the midpoint rule, trapezoidal rule, and Simpson's rule by integrating a simple function, such as $f(x) = x^4$, over the interval $[0, 1]$. Use different step sizes and observe how the error decreases as the step size decreases.

## Homework 4: Compare the Newton-Cotes and Gauss-Legendre Rules
Compare the accuracy of the Composite Newton-Cotes rules (midpoint, trapezoidal, Simpson's) with the Gauss-Legendre quadrature by integrating a simple function, such as $f(x) = x^4$, over the interval $[0, 1]$. Use different orders for the Gauss-Legendre quadrature and different step sizes for the Newton-Cotes rules.

## Homework 5: Analyze Gauss-Legendre Quadrature
Analyze the performance of the Gauss-Legendre quadrature by integrating a function with known singularities or discontinuities, such as $f(x) = \log(x)$ over the interval $[0, 1]$. Observe how the accuracy of the Gauss-Legendre quadrature is affected by the presence of singularities or discontinuities in the integrand.