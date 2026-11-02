include("./../../NumericalIntegration/NumericalIntegration.jl")

using .NumericalIntegration

##
# Problem 2

f(x) = x^2 # inline function in Julia
a = 0.0
b = 1.0
F_analytic = 1 / 3

#include("../../NumericalIntegration/src/newtoncotes.jl")
intrule_midpoint = Midpoint()
F_midpoint = intrule_midpoint(f, a, b)
relerror_midpoint = abs(F_midpoint - F_analytic)
println("Midpoint Rule: F = $F_midpoint, Error = $relerror_midpoint")

##
# Problem 4

for n in [1,2,4,8]
    intrule_compmidpoint = CompositeNewtonCotes(n, Midpoint())
    F_compmidpoint = intrule_compmidpoint(f, a, b)
    relerror_compmidpoint = abs(F_compmidpoint - F_analytic)
    println(
        "Composite Midpoint Rule ($n subintervals): F = $F_compmidpoint, Error = $relerror_compmidpoint")
end
##