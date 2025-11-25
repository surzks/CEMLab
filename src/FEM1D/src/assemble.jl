# Problem 2
abstract type Operator end

struct Laplace <: Operator
    ε::Function
end

#Problem 12
struct Poisson <: Operator
    ε::Function
    ρ::Function
end

# Homework 6
struct Helmholtz <: Operator
    k::Float64
end

# Problem 3
abstract type Space end

struct Shape{F}
    segmentid::Int # number of the segment
    refid::Int # local number of the shape function
    coeff::F # coefficient of the shape function (usually 1.0)
end

struct LagrangeBasis{D,C,NF,M,F,P} <: Space
    mesh::M
    fns::Vector{Vector{Shape{F}}}
    pos::Vector{P}
end

scalartype(::Vector{SVector{D,F}}) where {D,F} = F

function LagrangeBasis{D,C,NF}(
    mesh::M, fns::Vector{Vector{Shape{F}}}, pos::Vector{P}
) where {D,C,NF,M,F,P}
    return LagrangeBasis{D,C,NF,M,F,P}(mesh, fns, pos)
end

numshapefns_per_element(::LagrangeBasis{D,C,NF,M,F,P}) where {D,C,NF,M,F,P} = NF

# Problem 4
function lagrangec0d1(Ω::LineMesh{1,I,F}) where {I,F}
    NF = 2 # number of shape functions per element

    fns = Vector{Vector{Shape{F}}}(undef, NF * numsegments(Ω)) # 2 shape fns per segment
    pos = Vector{SVector{1,F}}(undef, NF * numsegments(Ω)) # 1 vertex per shape fn

    for (segmentid, segment) in enumerate(Ω.segments)
        v1, v2 = segment
        x1, x2 = Ω.vertices[v1], Ω.vertices[v2]

        # Shape functions for linear elements
        fns[NF * segmentid - 1] = [Shape(segmentid, 1, 1.0)] # ϕ1(x) = x - x2 / h
        fns[NF * segmentid] = [Shape(segmentid, 2, 1.0)] # ϕ2(x) = x - x1 / h

        # Positions of the vertices
        pos[NF * segmentid - 1] = x1
        pos[NF * segmentid] = x2
    end

    return LagrangeBasis{1,0,NF}(Ω, fns, pos)
end

# Problem 6
grad(ϕ, x1, x2) = (ϕ[1].refid == 1 ? -1.0 : 1.0) / (x2 - x1)

integrand(op::Laplace, ϕi, ϕj, x1, x2) =
    op.ε((x1 + x2) / 2.0) * dot(grad(ϕi, x1, x2), grad(ϕj, x1, x2)) * (x2 - x1)

# Homework Problem 7
function integrand(op::Helmholtz, ϕi, ϕj, x1, x2)
    f(x, x1, x2, refid) = (refid == 1 ? (x2 - x) / (x2 - x1) : (x - x1) / (x2 - x1))
    return dot(grad(ϕi, x1, x2), grad(ϕj, x1, x2)) * (x2 - x1) -
           op.k^2 * integrate(
        (ξ) -> f(ξ, x1, x2, ϕi[1].refid) * f(ξ, x1, x2, ϕj[1].refid),
        x1,
        x2,
        GaussLegendre(; order=5),
    )
end

function cellinteractions!(segment, Se, op::Operator, v::Space, u::Space)
    x1 = v.mesh.vertices[segment[1]][1]
    x2 = v.mesh.vertices[segment[2]][1]

    for i in 1:numshapefns_per_element(v)
        for j in 1:numshapefns_per_element(u)
            Se[i, j] = integrand(op, v.fns[i], u.fns[j], x1, x2)
        end
    end

    return Se
end

# Problem 12
abstract type Functional{T} end

struct SourceFunctional{T,F} <: Functional{T}
    field::F
end

SourceFunctional(f::F) where {F} = SourceFunctional{Float64,F}(f)

(s::SourceFunctional)(x::SVector{D,T}) where {D,T} = s.field(x)

function integrand(field::Function, ϕi, x1, x2)
    f(x, x1, x2, refid) = (refid == 1 ? (x2 - x) / (x2 - x1) : (x - x1) / (x2 - x1))
    return NumericalIntegration.integrate(
        (ξ) -> field(ξ) * f(ξ, x1, x2, ϕi[1].refid),
        x1,
        x2,
        NumericalIntegration.GaussLegendre(; order=5),
    )
end

function cellinteractions!(segment, Me, field::SourceFunctional, v::Space)
    x1 = v.mesh.vertices[segment[1]][1]
    x2 = v.mesh.vertices[segment[2]][1]

    for i in 1:numshapefns_per_element(v)
        Me[i] = integrand(field.field, v.fns[i], x1, x2)
    end

    return Me
end

function assemble(rhs::SourceFunctional, v::Space)
    M = zeros(scalartype(v.pos), length(v.mesh.vertices))
    Me = zeros(scalartype(v.pos), numshapefns_per_element(v))

    for segment in v.mesh.segments
        cellinteractions!(segment, Me, rhs, v)
        segment = collect(segment)
        M[segment] .+= Me
    end

    return M
end

# Problem 5
function assemble(op::Operator, v::Space, u::Space)
    S = zeros(scalartype(v.pos), length(v.mesh.vertices), length(u.mesh.vertices))
    Se = zeros(scalartype(v.pos), numshapefns_per_element(v), numshapefns_per_element(u))

    for segment in v.mesh.segments
        cellinteractions!(segment, Se, op, v, u)
        segment = collect(segment)
        S[segment, segment] .+= Se
    end

    return S
end
