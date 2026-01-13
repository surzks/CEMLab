using BEAST
using CompScienceMeshes
using StaticArrays
using SparseArrays
using LinearAlgebra
using PlotlyJS

#include("../FEM2D.jl")
#using .FEM2D

## Problem 3
geopath = pwd() * "/src/FEM2DLaplace/solutions/fem2dgeometry.geo"
meshpath = pwd() * "/src/FEM2DLaplace/solutions/fem2dgeometry.msh"
run(`gmsh -2 $geopath -setnumber delx 0.08 -format msh2 -o $meshpath`)
# other option "-clmax $meshparam" instead of delx near the points

## Problem 4
Ω = CompScienceMeshes.read_gmsh_mesh("$meshpath"; physical="domain", dimension=2)
Γ1 = CompScienceMeshes.read_gmsh_mesh("$meshpath"; physical="bottom", dimension=1) # Dirichlet 1
Γ2 = CompScienceMeshes.read_gmsh_mesh("$meshpath"; physical="left", dimension=1) # Dirichlet 2

PlotlyJS.plot(CompScienceMeshes.wireframe(Ω))

## Problem 5
vertind_Ω = [el[1] for el in skeleton(Ω, 0).faces]
vertind_Γ1 = [el[1] for el in skeleton(Γ1, 0).faces]
vertind_Γ2 = [el[1] for el in skeleton(Γ2, 0).faces]
# free:
vertind_F = setdiff(vertind_Ω, vertind_Γ1, vertind_Γ2)

## Problem 6
X_Γ1 = lagrangec0d1(msh, vertind_Γ1, Val{3});
X_Γ2 = lagrangec0d1(msh, vertind_Γ2, Val{3});
X_F = lagrangec0d1(msh, vertind_F, Val{3});

## Problem 7
O = grad_grad_Ω(1.0) # constant material parameter over the entire Domain
S_FF = assemble(O, X_F, X_F)
S_FΓ1 = assemble(O, X_F, X_Γ1)
S_FΓ2 = assemble(O, X_F, X_Γ2)

## Problem 8
Φ_Γ1 = 1.0
Φ_Γ2 = -1.0
u_Γ1 = Φ_Γ1 * ones(length(X_Γ1.fns))
u_Γ2 = Φ_Γ2 * ones(length(X_Γ2.fns))

b = -S_FΓ1 * u_Γ1 - S_FΓ2 * u_Γ2
u_F = S_FF \ b

## Problem 9
X = lagrangec0d1(msh, vcat(vertind_F, vertind_Γ1, vertind_Γ2), Val{3});
gX = gradient(X);
u = vcat(u_F, u_Γ1, u_Γ2) # same order as above!

## Problem 10
fcr, geo = facecurrents(u, X)
fcr, geo = facecurrents(u, X)
PlotlyJS.plot(patch(geo, fcr))

fcr_, geo_ = facecurrents(u, gX)
PlotlyJS.plot(patch(geo_, norm.(fcr_)))
