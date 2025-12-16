
# Problem 2
struct Laplace2D{F} end

(g::Laplace2D{F})(x, y) where {F} = F(-1 / (2π * 8.854187817) * log(sqrt(x^2 + y^2)))

# Problem 3
struct PointSpace{D,F}
    colpts::Vector{SVector{D,F}}
end

function PointSpace(Ω::LineMesh{D,I,F}) where {D,I,F}
    colpts = [0.5 * (Ω.vertices[e[1]] + Ω.vertices[e[2]]) for e in Ω.segments]
    return PointSpace{D,F}(colpts)
end

(ps::PointSpace)(s::Int) = ps.colpts[s]

Base.length(ps::PointSpace) = Base.length(ps.colpts)

struct PatchSpace{D,I,F}
    mesh::LineMesh{D,I,F}
end

function (ps::PatchSpace)(s::Int)
    return ps.mesh.vertices[ps.mesh.segments[s][1]],
    ps.mesh.vertices[ps.mesh.segments[s][2]]
end

Base.length(ps::PatchSpace) = numsegments(ps.mesh)
lensegment(ps::PatchSpace, s::Int) = norm(
    ps.mesh.vertices[ps.mesh.segments[s][2]] - ps.mesh.vertices[ps.mesh.segments[s][1]]
)

# Problem 5
function assemble(
    operator::Laplace2D{F},
    testspace::PointSpace{D,F},
    trialspace::PatchSpace{D,I,F};
    nearquadstrat=GeneralizedGaussian(; order=4),
    farquadstrat=GaussLegendre(; order=5),
) where {D,I,F}
    A = zeros(F, length(testspace), length(trialspace))

    for s in 1:length(trialspace)
        rₛ, rₑ = trialspace(s)
        for t in 1:length(testspace)
            rₒ = testspace(t)
            s_rel = dot((rₒ - rₛ), (rₑ - rₛ)) / norm(rₑ - rₛ)^2
            d2 = abs(norm(rₒ - rₛ)^2 - (dot((rₒ - rₛ), (rₑ - rₛ))^2) / norm(rₑ - rₛ)^2)
            ξₛ = -s_rel * lensegment(trialspace, s)
            ξₑ = (1 - s_rel) * lensegment(trialspace, s)

            A[t, s] = integratesingular(
                operator,
                ξₛ,
                ξₑ,
                sqrt(d2);
                nearquadstrat=nearquadstrat,
                farquadstrat=farquadstrat,
            )
        end
    end
    return A
end
