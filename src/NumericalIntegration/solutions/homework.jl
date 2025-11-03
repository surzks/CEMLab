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

##
# Homework 4
for n in [2, 4, 8, 16]
    intrule_gausslegendre = GaussLegendre(; order=n)
    F_gausslegendre = intrule_gausslegendre(f, a, b)
    relerror_gausslegendre = abs(F_gausslegendre - F_analytic) / abs(F_analytic)
    println("Gauss-Legendre Quadrature (order $n): Error = $relerror_gausslegendre")
end

##
# Homework 5
f(x) = log(x)
a = 0.0
b = 1.0
F_analytic = -1.0

for n in [2, 4, 8, 16, 32, 64]
    intrule_gausslegendre = GaussLegendre(; order=n)
    F_gausslegendre = intrule_gausslegendre(f, a, b)
    relerror_gausslegendre = abs(F_gausslegendre - F_analytic) / abs(F_analytic)
    println("Gauss-Legendre Quadrature (order $n): Error = $relerror_gausslegendre")
end
