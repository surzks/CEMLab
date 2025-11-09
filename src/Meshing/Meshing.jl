module Meshing

using StaticArrays
using Plots

# Problem 1
abstract type Mesh{D} end

include("src/linemesh.jl")
include("src/surfacemesh.jl")
include("src/visualize.jl")

# Problem 2
function translate!(Ω::Mesh{D}, v::SVector{D,F}) where {D,F}
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

# Homework 5
function weld(Ω1::SurfaceMesh{D,I,F}, Ω2::SurfaceMesh{D,I,F}) where {D,I,F}
    new_vertices = vcat(Ω1.vertices, Ω2.vertices)
    new_faces = vcat(
        Ω1.faces,
        [
            (
                f[1] + length(Ω1.vertices),
                f[2] + length(Ω1.vertices),
                f[3] + length(Ω1.vertices),
            ) for f in Ω2.faces
        ],
    )
    return SurfaceMesh{D,I,F}(new_vertices, new_faces)
end

export Mesh, LineMesh, SurfaceMesh, meshline, meshcurve
export meshrectangle, translate!, weld, numvertices, numsegments, plotmesh
end
