include("../Meshing.jl")
using .Meshing

##
# Homework 1

using StaticArrays

Ω1 = meshcurve(1.0, π / 2, 5)
plotmesh(Ω1; showvertices=true, aspect_ratio=:equal)

Ω2 = meshcurve(1.0, π / 2, 5)
Meshing.translate!(Ω2, SVector(1.0, 0.0))
plotmesh(Ω2; showvertices=true, aspect_ratio=:equal)

Ω = Meshing.weld(Ω1, Ω2)
plotmesh(Ω; showvertices=true, aspect_ratio=:equal)

##
# Homework 2-6
Ω1 = meshrectangle(1.0, 1.0, 5, 5)
plotmesh(Ω1; showvertices=true, aspect_ratio=:equal)

Ω2 = meshrectangle(1.0, 1.0, 5, 5)
Meshing.translate!(Ω2, SVector(1.0, 0.0, 1.0))
plotmesh(Ω2; showvertices=true, aspect_ratio=:equal)

Ω = Meshing.weld(Ω1, Ω2)
plotmesh(Ω; showvertices=true, aspect_ratio=:equal)
