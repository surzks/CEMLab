include("./../NumericalIntegration.jl")

using .NumericalIntegration

##
# Homework 3
f(x) = x^4
a = 0.0
b = 1.0
F_analytic = 1 / 5

for n in [2, 4, 8, 16]
    intrule_midpoint = CompositeNewtonCotes(n, Midpoint())
    F_midpoint = intrule_midpoint(f, a, b)
    relerror_midpoint = abs(F_midpoint - F_analytic) / abs(F_analytic)
    println("Composite Midpoint Rule ($n subintervals): Error = $relerror_midpoint")

    intrule_trapezoidal = CompositeNewtonCotes(n, Trapezoidal())
    F_trapezoidal = intrule_trapezoidal(f, a, b)
    relerror_trapezoidal = abs(F_trapezoidal - F_analytic) / abs(F_analytic)
    println("Composite Trapezoidal Rule ($n subintervals): Error = $relerror_trapezoidal")

    intrule_simpson = CompositeNewtonCotes(n, Simpson())
    F_simpson = intrule_simpson(f, a, b)
    relerror_simpson = abs(F_simpson - F_analytic) / abs(F_analytic)
    println("Composite Simpson's Rule ($n subintervals): Error = $relerror_simpson")
end