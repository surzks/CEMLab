# Problem 1
struct curl_curl_Ω{T,U} <: BEAST.LocalOperator
    α::T
    μ::U
end

function BEAST.integrand(localop::curl_curl_Ω, kerneldata, x, f, g)
    dfx = f.curl
    dgx = g.curl

    Tx = 1 / kerneldata.μ

    α = localop.α

    return α * dot(dfx, Tx * dgx)
end

struct KernelValsFEMLocalOperator{U}
    μ::U
end

function BEAST.kernelvals(localop::curl_curl_Ω, p)
    μ = localop.μ

    return KernelValsFEMLocalOperator(μ)
end

BEAST.scalartype(localop::curl_curl_Ω) = typeof(localop.α)
