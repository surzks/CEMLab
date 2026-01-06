module FEM2D

using BEAST
using StaticArrays
using LinearAlgebra
using CompScienceMeshes

include("src/BEASTgrad.jl")

export grad_grad_Ω

end
