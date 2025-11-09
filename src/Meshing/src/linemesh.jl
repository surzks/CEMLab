# Problem 1
struct LineMesh{D,I,F} <: Mesh{D}
    vertices::Vector{SVector{D,F}}
    segments::Vector{Tuple{I,I}}
end

# Problem 4
function meshline(start_point::SVector{D,F}, end_point::SVector{D,F}, n::I) where {I,D,F}
    vertices = collect(range(start_point; stop=end_point, length=n))
    segments = [(i, i + 1) for i in 1:(n - 1)]
    return LineMesh{D,I,F}(vertices, segments)
end

# Homework 1
function meshcurve(radius::F, length::F, n::I) where {I,F}
    θ = length / radius
    vertices = [
        SVector(radius * cos(t), radius * sin(t)) for t in range(0; stop=θ, length=n)
    ]
    segments = [(i, i + 1) for i in 1:(n - 1)]
    return LineMesh{2,I,F}(vertices, segments)
end

numvertices(Ω::LineMesh) = length(Ω.vertices)
numsegments(Ω::LineMesh) = length(Ω.segments)
