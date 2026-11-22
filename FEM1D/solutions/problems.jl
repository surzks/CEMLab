include("../FEM1D.jl")

using .FEM1D

using StaticArrays
using LinearAlgebra

##

# Problem 7
function dielectricwindow(x; ε=1.0, window_radius=0.2, window_center=0.5)
    return (abs(x - window_center) < window_radius ? ε : 1.0)
end