# H1: Initialization of arrays
using Test

A = zeros(Int, 100, 100)

for i in axes(A, 1)
    for j in axes(A, 2)
        A[i, j] = i + j
    end
end

@test A[2, 3] == 5
@test A[20, 40] == 60

##

# H2: Iterative updating
function propagate!(v::Vector{I}) where I
    vc = copy(v)
    i = 0
    while i < 100
        if minimum(v) == 1
            return i
        end
        i += 1
        for i in eachindex(v)
            if vc[i] == 1
                if i > 1 && i < length(v)
                    v[i-1] = 1
                    v[i+1] = 1
                elseif i == 1
                    v[2] = 1
                elseif i == length(v)
                    v[end-1] = 1
                end
            end
        end
        vc .= v
    end

    if i == 100
        return "failed"
    end

end

v = zeros(Int, 100)
v[[25, 75]] .= 1
propagate!(v)

##

# H3: Pythagorean triples
struct triplet
    a::Int64
    b::Int64
    c::Int64
end

function sumtriplets(x::triplet)
    return x.a + x.b + x.c
end

N = 500

triplets = triplet[] # empty vector of type triplet

squares = [i^2 for i in 1:N] # first N square numbers
for (i, p) in enumerate(squares)
    for (j, q) in enumerate(squares[i:end])
        if (p + q) ∈ squares
            append!(triplets, [triplet(i, i + j - 1, findfirst(squares .== p + q))])
        end
    end
end

@test sumtriplets(triplet(1, 2, 3)) == 6
for i in eachindex(triplets)
    @test triplets[i].a^2 + triplets[i].b^2 == triplets[i].c^2
end

triplets[findfirst(sumtriplets.(triplets) .== 1000)]