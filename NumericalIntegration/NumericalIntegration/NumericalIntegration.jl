module NumericalIntegration

using LinearAlgebra

abstract type IntegrationRule end

include("src/newtoncotes.jl")
include("src/gaussianquadrature.jl")
include("src/convergence.jl")

function integrate(f::Function, a::F, b::F, rule::IntegrationRule) where {F}
    return rule(f, a, b)
end

export Midpoint, Trapezoidal, Simpson, CompositeNewtonCotes
export GaussLegendre
export estimate_convergence_order
end
