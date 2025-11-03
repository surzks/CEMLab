# Problem 10
function estimate_convergence_order(Ih::Vector{Float64}, h::Vector{Float64})
    @assert length(Ih) == length(h) "Ih and h must have the same length"
    @assert length(Ih) >= 3 "At least three integral approximations are required to estimate convergence order"
    n = length(Ih)
    p_estimates = Float64[]
    for i in 1:(n - 2)
        numerator = log(abs((Ih[i] - Ih[i + 1]) / (Ih[i + 1] - Ih[i + 2])))
        denominator = log(h[i] / h[i + 1])
        push!(p_estimates, numerator / denominator)
    end
    return p_estimates
end
