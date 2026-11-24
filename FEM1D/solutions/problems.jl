include("../FEM1D.jl")

using .FEM1D

using StaticArrays
using LinearAlgebra

##

# Problem 7
function dielectricwindow(x; ε=1.0, window_radius=0.2, window_center=0.5)
    return (abs(x - window_center) < window_radius ? ε : 1.0)
end

# Problem 8
# 8.1
C_DL = 5.0
C_DR = 10.0
n = 10
ε = x -> dielectricwindow(x; ε=4.0, window_radius=0.2, window_center=0.5)

# 8.2
Ω = meshline(SVector(0.0), SVector(1.0), n)
u = lagrangec0d1(Ω)
v = lagrangec0d1(Ω)
op = Laplace(ε)
S = assemble(op, v, u)

# 8.3
vleft = argmin(Ω.vertices) # left boundary vertex
vright = argmax(Ω.vertices)
vertices_ess = vcat(vleft, vright)
vertices_all = 1:numvertices(Ω)
vertices_nat = setdiff(vertices_all, vertices_ess)
S_nat = S[vertices_nat, vertices_nat]
S_ess = S[vertices_nat, vertices_ess]
ϕ_ess = [C_DL, C_DR]

# 8.4
println(
    "Solve system with number of unknows: ", length(vertices_nat), "x", length(vertices_nat)
)
ϕ_nat = S_nat \ (-S_ess * ϕ_ess)
ϕ = zeros(numvertices(Ω))
ϕ[vertices_ess] = ϕ_ess
ϕ[vertices_nat] = ϕ_nat

# Problem 9
using Plots

xcoords = [Ω.vertices[i][1] for i in 1:numvertices(Ω)]
plt = plot(
    xcoords,
    ϕ;
    label  = "ε(x)-Laplace",
    xlabel = "x",
    ylabel = "ϕ",
    marker = :circle,
    title  = "Potential Distribution with dielectric window",
    legend = :topleft,
)

## Problem 10
# Convergence Study
function analyticalsolution(C_DL, C_DR, x; ε=1.0, window_radius=0.2, window_center=0.5)
    # Region I
    if x < window_center - window_radius
        return C_DL + (C_DR - C_DL) * (x)
        # Region II
    elseif window_center - window_radius <= x <= window_center + window_radius
        return C_DL +
               (C_DR - C_DL) / (1 / ε) *
               (window_center - window_radius + (x - (window_center - window_radius)) / ε)
        # Region III
    else
        return C_DL +
               (C_DR - C_DL) * (
            (window_center - window_radius) +
            (2 * window_radius) / ε +
            (x - (window_center + window_radius))
        )
    end
end

nₛ = [10, 20, 40, 80, 160]
errors = zeros(length(nₛ))

function numericalsolution(C_DL, C_DR, n; ε = 4.0, window_radius = 0.2, window_center=0.5)
    Ω = meshline(SVector(0.0), SVector(1.0), n)
    u = lagrangec0d1(Ω)
    v = lagrangec0d1(Ω)

    # Define permittivity function
    εfunc =
        x -> dielectricwindow(
            x; ε=ε, window_radius=window_radius, window_center=window_center
        )

    # Assemble system
    op = Laplace(εfunc)
    S = assemble(op, v, u)

    # Apply boundary conditions
    vleft = argmin(Ω.vertices) # left boundary vertex
    vright = argmax(Ω.vertices) # right boundary vertex
    vertices_ess = vcat(vleft, vright) # essential boundary vertices
    vertices_all = 1:numvertices(Ω) # all vertices
    vertices_nat = setdiff(vertices_all, vertices_ess) # natural boundary vertices
    S_nat = S[vertices_nat, vertices_nat] # natural boundary conditions
    S_ess = S[vertices_nat, vertices_ess] # essential boundary conditions
    ϕ_ess = [C_DL, C_DR]

    # Solve for natural boundary conditions
    ϕ_nat = S_nat \ (-S_ess * ϕ_ess)
    ϕ = zeros(numvertices(Ω)) # full solution vector
    ϕ[vertices_ess] = ϕ_ess
    ϕ[vertices_nat] = ϕ_nat

    return (Ω, ϕ)
end

for (index, n) in enumerate(nₛ)
    (Ω, ϕ_num) = numericalsolution(C_DL, C_DR, n)
    xcoords = [Ω.vertices[i][1] for i in 1:numvertices(Ω)]
    ϕ_ana = [
        analyticalsolution(C_DL, C_DR, x; ε=4.0, window_radius=0.2, window_center=0.5) for
        x in xcoords
    ]
    errors[index] = norm(ϕ_num - ϕ_ana) / norm(ϕ_ana)
end

p = estimate_convergence_order(errors, 1.0 ./ nₛ)
println("Estimated convergence order: ", p)
plt_error = plot(
    1.0 ./ nₛ,
    errors;
    xaxis = :log10,
    marker = :circle,
    xlabel = "Element size h",
    ylabel = "Relative Error",
    title = "Convergence Study",
    legend = false
)