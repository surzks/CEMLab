include("../src/plotting.jl")

## Problem 1
using CompScienceMeshes
using StaticArrays
using PlotlyJS

curve(t) = SVector(cos(t), sin(t))
msh = meshcurve(curve, 0.025; tend=Float64(2π))
#plotlinemesh(msh)

## Problem 2
using BEAST

ε0 = 8.854187821e-12
μ0 = 4π * 1e-7
c0 = 1 / sqrt(ε0 * μ0)
η0 = sqrt(μ0 / ε0)

f = 300e6
λ = c0 / f
k = 2π / λ

##

𝒱 = Helmholtz2D.singlelayer(; alpha=im * k * η0, wavenumber=k)
𝒦ᵀ = Helmholtz2D.doublelayer_transposed(; wavenumber=k)
𝒲 = Helmholtz2D.hypersingular(; wavenumber=k)
ℐ = BEAST.Identity()

## Problem 3

X = lagrangec0d1(msh)

## Problem 4
using LinearAlgebra

quadstrat = BEAST.DoubleNumSauterQstrat(4, 5, 5, 5, 5, 5)

V = assemble(𝒱, X, X; quadstrat=quadstrat)
cond(V)

## Problem 5

W = assemble(𝒲, X, X; quadstrat=quadstrat)
cond(W * V)

G = Matrix(assemble(ℐ, X, X))
Gi = inv(G)
cond(Gi * W * Gi * V)

## Problem 6

using Krylov

Ez_pw_inc = Helmholtz2D.planewave(;
    amplitude=1.0, wavenumber=k, direction=SVector(1.0, 0.0)
)
ez_pw_inc = assemble(DirichletTrace(Ez_pw_inc), X)

(j_TMEFIE_pw, stats) = Krylov.gmres(V, ez_pw_inc; verbose=1)

pts = meshcircle(3.0, 0.3).vertices
Ez_pw_sca_num = -potential(HH2DSingleLayerNear(𝒱), pts, j_TMEFIE_pw, X; type=ComplexF64)
plot(abs.(Ez_pw_sca_num))

##

xs = range(-3; stop=3, length=50);
ys = range(-3; stop=3, length=50);
gridpoints = [point(x, y) for y in ys, x in xs];
Esc = -potential(HH2DSingleLayerNear(𝒱), gridpoints, j_TMEFIE_pw, X; type=ComplexF64)
Ein = Ez_pw_inc.(gridpoints);
hm = heatmap(; x=xs, y=ys, z=norm.(Esc + Ein)', colorscale="Viridis")
plot(hm)

##

TM_MFIE = 0.5 * assemble(ℐ, X, X) + assemble(𝒦ᵀ, X, X; quadstrat=quadstrat)

cond(TM_MFIE)

##

Ht_pw_inc = -1.0 / (im * 2 * pi * f * μ0) * curl(Ez_pw_inc)
ht_pw_inc = -assemble(TangentTrace(Ht_pw_inc), X)

(j_TMMFIE_pw, stats) = Krylov.gmres(TM_MFIE, ht_pw_inc; verbose=1)

norm(j_TMEFIE_pw - j_TMMFIE_pw) / norm(j_TMEFIE_pw)
