include("../FEM2DCurlcurl.jl")
using .FEM2DCurlcurl
using BEAST
using PlotlyJS
using LinearAlgebra
using CompScienceMeshes

function analyticalk(m, n; a=1.0, b=1.0)
    return sqrt((m * pi / a)^2 + (n * pi / b)^2)
end

a = 1.0
b = 1.0
h = 0.025
msh = meshrectangle(a, b, h);

# finde and eliminate the boundary edges
bnd = boundary(msh)
edges = submesh(!in(bnd), skeleton(msh, 1))
# create basisfunctions only on the passed edges of the mesh -> TE case
N = BEAST.nedelec(msh, edges)
op = curl_curl_Ω(1.0, 1.0)
S = assemble(op, N, N)
M = assemble(BEAST.Identity(), N, N)

k2, V = eigen(Matrix(S), Matrix(M))
correctidcs = Int[]
for i in eachindex(k2)
    if !isapprox(k2[i], 0.0; atol=1e-10)
        push!(correctidcs, i)
    end
end

fcr, geo = facecurrents(V[:, correctidcs[1]], N)
f = zeros(Float64, length(fcr))
for i in eachindex(fcr)
    f[i] = sum(fcr[i][1:3])
end

PlotlyJS.plot(patch(geo, f))

## convergence analysis

a = 1.0
b = 1.0

lowesteigenvalues = Float64[]
hs = [0.1, 0.05, 0.025]

for h in hs
    msh = meshrectangle(a, b, h)

    # finde and eliminate the boundary edges
    bnd = boundary(msh)
    edges = submesh(!in(bnd), skeleton(msh, 1))
    # create basisfunctions only on the passed edges of the mesh -> TE case
    N = BEAST.nedelec(msh, edges)
    op = curl_curl_Ω(1.0, 1.0)
    S = assemble(op, N, N)
    M = assemble(BEAST.Identity(), N, N)

    k2, V = eigen(Matrix(S), Matrix(M))
    correctidcs = Int[]
    for i in eachindex(k2)
        if !isapprox(k2[i], 0.0; atol=1e-10)
            push!(correctidcs, i)
        end
    end
    push!(lowesteigenvalues, sqrt(k2[correctidcs[1]]))
end

estimate_convergence_order(lowesteigenvalues, hs)
# ___
