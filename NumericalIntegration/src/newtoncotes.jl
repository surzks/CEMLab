# Problem 1
abstract type NewtonCotesRule end

struct Midpoint <: NewtonCotesRule end

function (::Midpoint)(f::Function, a::T, b::T) where {T}
    return (b - a) * f((a + b) / 2)
end

# Homework 1
struct Trapezoidal <: NewtonCotesRule end

function (::Trapezoidal)(f::Function, a::T, b::T) where {T}
    return (b - a) / 2 * (f(a) + f(b))
end

# Homework 2
struct Simpson <: NewtonCotesRule end

function (::Simpson)(f::Function, a::T, b::T) where {T}
    return (b - a) / 6 * (f(a) + 4 * f((a + b) / 2) + f(b))
end

# Problem 3
struct CompositeNewtonCotes <: IntegrationRule
    nsubintervals::Int
    rule::NewtonCotesRule
end

function (intrule::CompositeNewtonCotes)(f::Function, a::T, b::T) where {T}
    h = (b - a) / intrule.nsubintervals
    F = 0.0
    for i in 0:(intrule.nsubintervals - 1)
        F += intrule.rule(f, a + i * h, a + (i + 1) * h)
    end

    return F
end
