include("../FEM1D.jl")

using .FEM1D

using StaticArrays
using LinearAlgebra
##

# Homework 7:
k = 20.0
n = 400

start_point = SVector(0.0)
end_point = SVector(1.2)

Ω = meshline(start_point, end_point, n)
u = lagrangec0d1(Ω)
v = lagrangec0d1(Ω)
op = Helmholtz(k)
S = assemble(op, v, u)

# Add the boundary conditions
vleft = argmin(Ω.vertices) # left boundary vertex
vright = argmax(Ω.vertices) # right boundary vertex
vertices_ess = [vleft]
vertices_all = 1:numvertices(Ω) # all vertices
vertices_nat = setdiff(vertices_all, vertices_ess) # natural boundary vertices

# Incorporate Neumann BC into RHS vector
b = zeros(numvertices(Ω))
b[vright] += 1.0

S_nat = S[vertices_nat, vertices_nat] # natural boundary conditions
S_ess = S[vertices_nat, vertices_ess] # essential boundary conditions
b_nat = b[vertices_nat]

u_ess = [0.0]
println(
    "Solve system with number of unkowns: ", length(vertices_nat), "x", length(vertices_nat)
)

u_nat = S_nat \ (b_nat - S_ess * u_ess) # solve for natural boundary conditions
u = zeros(numvertices(Ω)) # full solution vector
u[vertices_ess] = u_ess
u[vertices_nat] = u_nat

##
# Homework 8:

using Plots
xcoords = [Ω.vertices[i][1] for i in 1:numvertices(Ω)]
plt = plot(
    xcoords,
    u;
    label  = "u(x)",
    xlabel = "x",
    ylabel = "u",
    title  = "1D Helmholtz Equation Solution",
)

# Compare with analytical solution
l = end_point[1]
u_analytical(x) = 1 / (k * cos(k * l)) * sin(k * x)

u_exact = [u_analytical(xcoords[i]) for i in 1:length(xcoords)]

plot!(plt, xcoords, u_exact; label="u_exact(x)", linestyle=:dash)
