"""
    BooleanRemission(; tjc, sjc, pga, crp)

Store the components of the original ACR/EULAR Boolean remission.

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` patient's global assessment
- `crp` C-reactive protein

!!! warning "Units"
    Currently, `pga` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

See also [`isremission`](@ref).
"""
struct BooleanRemission <: BooleanComposite
    tjc::Int64
    sjc::Int64
    pga::Unitful.AbstractQuantity
    crp::Unitful.AbstractQuantity
    function BooleanRemission(; tjc, sjc, pga::Unitful.AbstractQuantity, crp::Unitful.AbstractQuantity)
        valid_joints.([tjc, sjc])
        valid_vas(pga)
        valid_apr(crp)
        return new(tjc, sjc, pga, uconvert(units.brem_crp, crp))
    end
end

"""
    threeitem(root::BooleanRemission)

Change the calculation of Boolean remission to exclude patient global assessment.

See also [`isremission`](@ref), [`BooleanRemission`](@ref).
"""
threeitem(root::BooleanRemission) = subset(root, [:sjc, :tjc, :crp])

revised(root::BooleanRemission; offset=(; pga=10u"mm")) = revised(root, offset)

"Return the CRP value."
crp(x::BooleanComposite) = x.crp
