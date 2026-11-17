abstract type Operator end

struct Laplace <: Operator
    ε::Function
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

scalartype(::Vector{SVector{D,F}}) where {D, F} = F
numshapefns_per_element(::LagrangeBasis{D,C,NF,M,F,P}) where {D,C,NF,M,F,P} = NF

# Problem 4
function lagrangec0d1(Ω::LineMesh{1,I,F}) where {I,F}
    NF = 2

    fns = Vector{Vector{Shape{F}}}(undef, NF * numsegments(Ω)) # 2 shape fns per segement
    pos = Vector{SVector{1, F}}(undef, NF * numsegments(Ω)) # 1 vertex per shape function

    for (segmentid, segment) in enumerate(Ω.segments)
        v1, v2 = segment
        x1 , x2 = Ω.vertices[v1], Ω.vertices[v2]

        # Shape function for linear elements
        fns[NF * segmentid - 1] = [Shape(segmentid, 1, 1.0)]
        fns[NF * segmentid] = [Shape(segmentid, 2, 1.0)]
        
        # Positions of the vertices
        pos[NF * segmentid - 1] = x1
        pos[NF * segmentid] = x2
    end

    return LagrangeBasis{1,0,NF}(Ω, fns, pos)
end

# Problem 6
grad(λ, x1, x2) = (λ[1].refid == 1 ? -1.0 : 1.0) / (x2 - x1)

integrand(op::Laplace, λi, λj, x1, x2) = 
    op.ε((x1 + x2) / 2.0)  * dot(grad(λi, x1, x2), grad(λj, x1, x2)) * (x2 - x1)

function cellinterations!(segment, Se, op::Operator, v::Space, u::Space)
    x1 = v.mesh.vertices[segment[1]][1]
    x2 = v.mesh.vertices[segment[2]][2]

    for i in 1:numshapefns_per_element(v)
        for j in 1:numshapefns_per_element(u)
            Se[i, j] = integrand(op, v.fns[i], u.fns[j], x1, x2)
        end
    end
end

# Problem 5
function assemble(op::Operator, v::Space, u::Space)
    S = zeros(scalartype(v.pos), length(v.mesh.vertices), length(u.mesh.vertices))
    Se = zeros(scalartype(v.pos), numshapefns_per_element(v), numshapefns_per_element(u))

    for segment in v.mesh.segments
        cellinterations!(segment, Se, op, v, u)
        segment = collect(segment) # tuple to indices
        S[segment, segment] .+= Se
    end
    return S
end