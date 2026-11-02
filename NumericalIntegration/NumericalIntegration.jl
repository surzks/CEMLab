module NumericalIntegration

using LinearAlgebra

abstract type IntegrationRule end

include("src/newtoncotes.jl")

function integrate(f::Function, a::F, b::F, rule::IntegrationRule) where {F}
    return rule(f, a, b)
end

export Midpoint, CompositeNewtonCotes

end