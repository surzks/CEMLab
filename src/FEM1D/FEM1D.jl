module FEM1D

include("../Meshing/Meshing.jl")
include("../NumericalIntegration/NumericalIntegration.jl")

using .Meshing
using .NumericalIntegration
import .NumericalIntegration: integrate, GaussLegendre, estimate_convergence_order
using StaticArrays
using LinearAlgebra

include("src/assemble.jl")

# Meshing functions
export meshline, numvertices

# NumericalIntegration functions
export estimate_convergence_order

# FEM1D functions
export Laplace, Helmholtz
export lagrangec0d1
export assemble
export SourceFunctional

end
