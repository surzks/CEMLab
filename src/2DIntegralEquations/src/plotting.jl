using PlotlyJS
using CompScienceMeshes

function plotlinemesh(msh::Mesh)
    verts = msh.vertices
    segs = msh.faces

    xs = Float64[]
    ys = Float64[]

    for (i, j) in segs
        vi = verts[i]
        vj = verts[j]
        push!(xs, vi[1], vj[1], NaN)
        push!(ys, vi[2], vj[2], NaN)
    end

    plt = plot(
        scatter(; x=xs, y=ys, mode="lines+markers", name="segments"),
        Layout(; xaxis=attr(; scaleanchor="y"), yaxis=attr(; scaleratio=1)),
    )

    return display(plt)
end
