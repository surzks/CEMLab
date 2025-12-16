# Problem 6
function integratesingular(
    f::Laplace2D{F},
    ξₛ,
    ξₑ,
    d;
    nearquadstrat=GeneralizedGaussian(; order=3),
    farquadstrat=GaussLegendre(; order=5),
) where {F}
    if ξₛ < 0 && 0 < ξₑ
        I =
            nearquadstrat(x -> f(x, d), F(0), abs(ξₛ)) +
            nearquadstrat(x -> f(x, d), F(0), abs(ξₑ))
    elseif isapprox(ξₛ, F(0)) || isapprox(ξₑ, F(0))
        I = nearquadstrat(x -> f(x, d), F(0), abs(ξₑ - ξₛ))
    else
        I = farquadstrat(x -> f(x, d), ξₛ, ξₑ)
    end

    return I
end
