include("../../NumericalIntegration/NumericalIntegration.jl")
include("../BEM2D.jl")
using .NumericalIntegration
using .BEM2D
using LinearAlgebra

## Problem 4: BEM - Integration

op = Laplace2D{Float64}()
rule = GeneralizedGaussian(; order=4)
Fnum = rule(x -> op(0, x), 0.0, 1.0)
F = 1 / (2π * 8.854187817e-12) * (log(1) - 1)

## Problem 7: BEM - Solution

Γ = meshplates(1.0, 1.0, 100)

op = Laplace2D{Float64}()
X = PointSpace(Γ)
Y = PatchSpace(Γ)

A = assemble(
    op,
    X,
    Y;
    nearquadstrat=GeneralizedGaussian(; order=4),
    farquadstrat=GaussLegendre(; order=4),
)

ϕ = zeros(Float64, size(A, 2))
ϕ[1:(length(ϕ) ÷ 2)] .= 0.5
ϕ[((length(ϕ) ÷ 2) + 1):end] .= -0.5

σ = A \ ϕ

q = zeros(Float64, size(A, 1))
for s in 1:length(Y)
    q[s] = σ[s] * BEM2D.lensegment(Y, s)
end

C = sum(q[1:(length(q) ÷ 2)])
