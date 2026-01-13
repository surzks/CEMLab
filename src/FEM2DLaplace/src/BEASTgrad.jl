# Problem 1
# define a local operator: α * ∫_Ω ∇Φ*∇Φ dx
struct grad_grad_Ω{T} <: BEAST.LocalOperator
    α::T
end
function BEAST.integrand(localop::grad_grad_Ω, kerneldata, x, f, g)
    return localop.α * dot(f.grad, g.grad)
end
BEAST.scalartype(localop::grad_grad_Ω) = typeof(localop.α)
BEAST.kernelvals(localop::grad_grad_Ω, x) = nothing

# Problem 2
#= Overwrite the function in BEAST to have grad=...
    (Not best practice! This is a temporary solution!) =#
function (f::BEAST.LagrangeRefSpace{T,1,3})(t) where {T}
    u, v, w, = barycentric(t)

    j = jacobian(t)
    p = t.patch
    σ = sign(BEAST.dot(BEAST.normal(t), BEAST.cross(p[1] - p[3], p[2] - p[3])))

    tu = tangents(t, 1)
    tv = tangents(t, 2)
    tc = BEAST.cross(tu, tv)
    J = @SMatrix [
        tu[1] tv[1] tc[1]
        tu[2] tv[2] tc[2]
        tu[3] tv[3] tc[3]
    ]
    invJT = inv(transpose(J))

    gr1 = SVector{3,T}(1.0, 0.0, 0.0)
    gr2 = SVector{3,T}(0.0, 1.0, 0.0)
    gr3 = SVector{3,T}(-1.0, -1.0, 0.0)

    return SVector(
        (value=u, curl=σ * (p[3] - p[2]) / j, grad=invJT * gr1),
        (value=v, curl=σ * (p[1] - p[3]) / j, grad=invJT * gr2),
        (value=w, curl=σ * (p[2] - p[1]) / j, grad=invJT * gr3),
    )
end
