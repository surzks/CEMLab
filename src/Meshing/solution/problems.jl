include("./../Meshing.jl")
using .Meshing

##
# Problem 1-5
using StaticArrays
Ω1 = meshline(1.0, 5)
plotmesh(Ω1; showvertices=true)

Ω2 = meshline(1.0, 5)
Meshing.translate!(Ω2, SVector(1.0, 0.0))
plotmesh(Ω2; showvertices=true)

Ω = Meshing.weld(Ω1, Ω2)
plotmesh(Ω; showvertices=true)
