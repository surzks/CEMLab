module Meshing

using StaticArrays
using Plots

# Problem 1
abstract type Mesh{D} end

include("src/linemesh.jl")
include("src/visualize.jl")

# Problem 2
function translate!(Ω::Mesh{D}, v::SVector{D, F}) where {D,F}
    for i in eachindex(Ω.vertices)
        Ω.vertices[i] += v
    end
end

# Problem 3
function weld(Ω1::LineMesh{D,I,F}, Ω2::LineMesh{D,I,F}) where {D,I,F}
    new_vertices = vcat(Ω1.vertices, Ω2.vertices)
    new_segments = vcat(
        Ω1.segments,
        [(s[1] + length(Ω1.vertices), s[2] + length(Ω1.vertices)) for s in Ω2.segments],
    )

    return LineMesh{D,I,F}(new_vertices, new_segments)
end

export LineMesh, meshline
export weld, plotmesh

end