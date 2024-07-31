"""
    BooleanRemission(; t28, s28, pga, crp)

Store the components of the original ACR/EULAR Boolean remission.

# Components

- `t28` 28 tender joint count
- `s28` 28 swollen joint count
- `pga` patient's global assessment
- `crp` C-reactive protein

!!! warning "Units"
    Currently, `pga` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

See also [`isremission`](@ref).
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
