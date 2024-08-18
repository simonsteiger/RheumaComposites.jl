"""
    BooleanRemission(; tjc, sjc, pga, crp)

Store the components of the original ACR/EULAR Boolean remission.

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` patient's global assessment
- `crp` C-reactive protein

!!! note "Units"
    `pga` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

See also [`isremission`](@ref).
"""
struct BooleanRemission <: BooleanComposite
    components::NTuple{4, Float64}
    names::NTuple{4, Symbol}
    units::NamedTuple
    function BooleanRemission(; tjc, sjc, pga, crp, units=BREM_UNITS)
        components = (; tjc, sjc, pga, crp)
        ucomponents_vals = unitfy(components, units; conversions=BREM_UNITS)
        ucomponents = NamedTuple{keys(components)}(ucomponents_vals)

        valid_joints.([tjc, sjc])
        valid_vas(ucomponents.pga)
        valid_apr(ucomponents.crp)

        names = keys(components)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, BREM_UNITS)
    end
end

"""
    threeitem(root::BooleanRemission)

Change the calculation of Boolean remission to exclude patient global assessment.

Alias for `partial(root::BooleanRemission, [:sjc, :tjc, :crp])`.

See also [`partial`](@ref), [`isremission`](@ref), [`BooleanRemission`](@ref).
"""
threeitem(root::BooleanRemission) = partial(root, [:sjc, :tjc, :crp])

"""
    revised(root::BooleanRemission, offset::NamedTuple)
    revised(root::BooleanRemission; offset::NamedTuple=(; pga=10u"mm"))

Modify the remission thresholds of a composite.

The values passed to `offset` will be added to the default thresholds of `root`.

See also [`isremission`](@ref).
"""
revised(root::BooleanRemission; offset=(; pga=1)) = revised(root, offset)
