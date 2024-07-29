"""
    BooleanRemission(; t28, s28, pga, crp)

Store the components of the original ACR/EULAR Boolean remission.

See also [`isremission`](@ref), [`revised`](@ref), [`threeitem`](@reg).
"""
struct BooleanRemission <: BooleanComposite
    t28::Int64
    s28::Int64
    pga::Unitful.AbstractQuantity
    crp::Unitful.AbstractQuantity
    function BooleanRemission(; t28, s28, pga::Unitful.AbstractQuantity, crp::Unitful.AbstractQuantity)
        valid_joints.([t28, s28])
        valid_vas(pga)
        valid_apr(crp)
        return new(t28, s28, pga, uconvert(units.brem_crp, crp))
    end
end

"Return the CRP value."
crp(x::BooleanComposite) = x.crp
