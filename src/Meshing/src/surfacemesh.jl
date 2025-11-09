# Homework 2
struct SurfaceMesh{D,I,F} <: Mesh{D}
    vertices::Vector{SVector{D,F}}
    faces::Vector{NTuple{3,I}}  # assuming triangular faces
end

#Homework 3
function meshrectangle(a::F, b::F, na::I, nb::I) where {I,F}
    vertices = [
        SVector(x, y, 0.0) for y in range(0; stop=b, length=nb + 1),
        x in range(0; stop=a, length=na + 1)
    ]
    vertices = vec(vertices)
    faces = NTuple{3,I}[]
    for j in 0:(nb - 1)
        for i in 0:(na - 1)
            v1 = i + j * (na + 1) + 1
            v2 = (i + 1) + j * (na + 1) + 1
            v3 = i + (j + 1) * (na + 1) + 1
            v4 = (i + 1) + (j + 1) * (na + 1) + 1
            push!(faces, (v1, v2, v3))
            push!(faces, (v2, v4, v3))
        end
    end
    return SurfaceMesh{3,I,F}(vertices, faces)
end
