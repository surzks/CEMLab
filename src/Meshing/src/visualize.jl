# Problem 5
function plotmesh(Ω::LineMesh; kwargs...)
    x = [v[1] for v in Ω.vertices]
    y = [v[2] for v in Ω.vertices]
    scatter(x, y; aspect_ratio=1, legend=false, kwargs...)
    for (i, j) in Ω.segments
        plot!([x[i], x[j]], [y[i], y[j]]; color=:black, lw=2, kwargs...)
    end
    return current()
end

# Homework 6
function plotmesh(Ω::SurfaceMesh; kwargs...)
    x = [v[1] for v in Ω.vertices]
    y = [v[2] for v in Ω.vertices]
    scatter(x, y; aspect_ratio=1, legend=false, kwargs...)
    for (i, j, k) in Ω.faces
        plot!(
            [x[i], x[j], x[k], x[i]],
            [y[i], y[j], y[k], y[i]];
            color=:black,
            lw=1,
            kwargs...,
        )
    end
    return current()
end
