# Problem 1

function meshplates(len::F, d::F, n::I) where {I,F<:Real}
    Γ1 = meshline(SVector(F(0.0), F(0.0)), SVector(len, F(0.0)), n) # top plate
    Γ2 = meshline(SVector(F(0.0), F(0.0)), SVector(len, F(0.0)), n) # bottom plate
    translate!(Γ1, SVector(-len / 2, d / 2)) # move top plate
    translate!(Γ2, SVector(-len / 2, -d / 2)) # move bottom plate

    Γ = weld(Γ1, Γ2) # combine meshes

    return Γ
end
