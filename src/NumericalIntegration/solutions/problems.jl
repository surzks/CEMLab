include("./../../NumericalIntegration/NumericalIntegration.jl")

using .NumericalIntegration

##

# Problem 2
f(x) = x^2
a = 0.0
b = 1.0
F_analytic = 1 / 3

intrule_midpoint = Midpoint()
F_midpoint = intrule_midpoint(f, a, b)
relerror_midpoint = abs(F_midpoint - F_analytic) / abs(F_analytic)
println("Midpoint Rule: F = $F_midpoint, Error = $relerror_midpoint")

##

# Problem 4
for n in [1, 2, 4, 8]
    intrule_compmidpoint = CompositeNewtonCotes(n, Midpoint())
    F_compmidpoint = intrule_compmidpoint(f, a, b)
    relerror_compmidpoint = abs(F_compmidpoint - F_analytic) / abs(F_analytic)
    println(
        "Composite Midpoint Rule ($n subintervals): F = $F_compmidpoint, Error = $relerror_compmidpoint",
    )
end

##

# Problem 9
f(x) = x^2 * cos(10 * x^2)
F_analytic = −0.03925821571649867

for n in 2:10
    intrule_gausslegendre = GaussLegendre(order=n)
    F_gausslegendre = intrule_gausslegendre(f, a, b)
    relerror_gausslegendre = abs(F_gausslegendre - F_analytic) / abs(F_analytic)
    println(
        "Gauss-Legendre Quadrature (order $n): F = $F_gausslegendre, Error = $relerror_gausslegendre",
    )
end

##

# Problem 11
f(x) = x^2 * cos(10 * x^2)
F_analytic = −0.03925821571649867
hs = [0.1, 0.05, 0.025, 0.0125, 0.00625]
Ih_compmidpoint = Float64[]
Ih_compsimpson = Float64[]
Ih_gausslegendre = Float64[]
for h in hs
    n_subintervals = Int((b - a) / h)

    intrule_compmidpoint = CompositeNewtonCotes(n_subintervals, Midpoint())
    F_compmidpoint = intrule_compmidpoint(f, a, b)
    push!(Ih_compmidpoint, F_compmidpoint)

    intrule_compsimpson = CompositeNewtonCotes(n_subintervals, Simpson())
    F_compsimpson = intrule_compsimpson(f, a, b)
    push!(Ih_compsimpson, F_compsimpson)

    order_gauss = n_subintervals
    intrule_gausslegendre = GaussLegendre(order=order_gauss)
    F_gausslegendre = intrule_gausslegendre(f, a, b)
    push!(Ih_gausslegendre, F_gausslegendre)
end

p_compmidpoint = estimate_convergence_order(Ih_compmidpoint, hs)
p_compsimpson = estimate_convergence_order(Ih_compsimpson, hs)
p_gausslegendre = estimate_convergence_order(Ih_gausslegendre, hs)
println("Estimated convergence orders:")
println("Composite Midpoint Rule: p ≈ ", p_compmidpoint)
println("Composite Simpson's Rule: p ≈ ", p_compsimpson)
println("Gauss-Legendre Quadrature: p ≈ ", p_gausslegendre)
