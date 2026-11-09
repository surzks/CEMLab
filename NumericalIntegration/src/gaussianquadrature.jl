using FastGaussQuadrature

# Problem 6
struct GaussLegendre{F} <: IntegrationRule
    points::Vector{F}
    weights::Vector{F}
end

function GaussLegendre(; order::Int=3)
    x, w = gausslegendre(order) # function from library
    return GaussLegendre(x, w) # our struct
end

# Problem 8
function (rule::GaussLegendre)(f::Function, a::F, b::F) where{F}
    return (b - a) / 2 * dot(rule.weights, f.((b - a) * rule.points / 2 .+ (a + b) / 2))
end