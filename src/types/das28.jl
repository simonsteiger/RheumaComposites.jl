"""
    DAS28 <: ContinuousComposite

Abstract type for DAS28 subtypes.

See also [`DAS28ESR`](@ref), [`DAS28CRP`](@ref).
"""
abstract type DAS28 <: ContinuousComposite end

WeightingScheme(::Type{<:DAS28}) = IsWeighted()

# TODO add weighting formula to docstring
"""
    DAS28CRP(; tjc, sjc, pga, apr)

Store the component measures of the DAS28CRP.

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` patient's global assessment
- `apr` active phase reactant, here CRP

!!! note "Units"
    `pga` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

# Categories

- ``<`` $(cutoff.DAS28CRP.low) = Remission
- ``\\leq`` $(cutoff.DAS28CRP.low) = Low
- ``\\leq`` $(cutoff.DAS28CRP.moderate) = Moderate
- ``>`` $(cutoff.DAS28CRP.moderate) = High

# External links

* [DAS28 calculator](https://www.4s-dawn.com/DAS28/)

See also [`score`](@ref), [`categorise`](@ref), [`isremission`](@ref).
"""
struct DAS28CRP <: DAS28
    components::NTuple{4, Float64}
    names::NTuple{4, Symbol}
    units::NamedTuple
    function DAS28CRP(; tjc, sjc, pga, apr, units=DAS28CRP_UNITS)
        components = (; tjc, sjc, pga, apr)
        ucomponents_vals = unitfy(components, units; conversions=DAS28CRP_UNITS)
        ucomponents = NamedTuple{keys(components)}(ucomponents_vals)

        valid_joints.([tjc, sjc])
        valid_vas(ucomponents.pga)
        valid_apr(ucomponents.apr)

        names = keys(components)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, DAS28CRP_UNITS)
    end
end

"""
    DAS28ESR(; tjc, sjc, pga, apr)

Store the component measures of the DAS28ESR.

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` patient's global assessment
- `apr` active phase reactant, here ESR

!!! note "Units"
    `pga` must be a length (typically millimeters or centimeters) and `apr` must be a rate (typically mm/hr).
    See also [`Unitful.@u_str`](@extref).

# Categories

- ``<`` $(cutoff.DAS28ESR.low) = Remission
- ``\\leq`` $(cutoff.DAS28ESR.low) = Low
- ``\\leq`` $(cutoff.DAS28ESR.moderate) = Moderate
- ``>`` $(cutoff.DAS28ESR.moderate) = High

# External links

- [DAS28 calculator](https://www.4s-dawn.com/DAS28/)

See also [`score`](@ref), [`categorise`](@ref), [`isremission`](@ref).
"""
struct DAS28ESR <: DAS28
    components::NTuple{4, Float64}
    names::NTuple{4, Symbol}
    units::NamedTuple
    function DAS28ESR(; tjc, sjc, pga, apr, units=DAS28ESR_UNITS)
        components = (; tjc, sjc, pga, apr)
        ucomponents_vals = unitfy(components, units; conversions=DAS28ESR_UNITS)
        ucomponents = NamedTuple{keys(components)}(ucomponents_vals)

        valid_joints.([tjc, sjc])
        valid_vas(ucomponents.pga)
        valid_apr(ucomponents.apr)

        names = keys(components)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, DAS28ESR_UNITS)
    end
end

intercept(x::DAS28CRP) = 0.96
