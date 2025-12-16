module BEM2D

using StaticArrays
using LinearAlgebra

include("../NumericalIntegration/NumericalIntegration.jl")
include("../Meshing/Meshing.jl")
using .NumericalIntegration
using .Meshing

include("src/integralop.jl")
include("src/meshing.jl")
include("src/singularitytreatment.jl")

export meshplates
export Laplace2D, PointSpace, PatchSpace, assemble

end
