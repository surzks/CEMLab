include("gqlog.jl")

# BEM1D - Problem 4
struct GeneralizedGaussian{F} <: IntegrationRule
    points::Vector{F}
    weights::Vector{F}
end

function GeneralizedGaussian(; order::Int=3)
    x, w = generalizedquadrature(order)
    return GeneralizedGaussian(Float64.(x), Float64.(w))
end

function (rule::GeneralizedGaussian)(f::Function, a::F, b::F) where {F}
    return (b - a) * dot(rule.weights, f.(rule.points .* (b - a) .+ a))
end
