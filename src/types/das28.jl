"""
    DAS28 <: ContinuousComposite

Abstract type for DAS28 subtypes.

See also [`DAS28ESR`](@ref), [`DAS28CRP`](@ref).
"""
abstract type DAS28 <: ContinuousComposite end

WeightingScheme(::Type{<:DAS28}) = IsWeighted()

# TODO add weighting formula to docstring
"""
    DAS28CRP(; tjc, sjc, pga, apr[; units])

Store the component measures of the DAS28CRP.

Optionally specify the units for each component using [`Unitful.@u_str`](@extref).

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` (cm) patient's global assessment
- `apr` (mg/L) active phase reactant, here CRP

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
    values::NTuple{4, Float64}
    names::NTuple{4, Symbol}
    units::NamedTuple
    function DAS28CRP(; tjc, sjc, pga, apr, units=DAS28CRP_UNITS)
        ntvals = (; tjc, sjc, pga, apr)
        uvals = unitfy(ntvals, units; conversions=DAS28CRP_UNITS)
        ucomponents = NamedTuple{keys(ntvals)}(uvals)

        valid_joints.([tjc, sjc])
        valid_vas(ucomponents.pga)
        valid_apr(ucomponents.apr)

        names = keys(ntvals)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, DAS28CRP_UNITS)
    end
end

"""
    DAS28ESR(; tjc, sjc, pga, apr[; units])

Store the component measures of the DAS28ESR.

Optionally specify the units for each component using [`Unitful.@u_str`](@extref).

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` (cm) patient's global assessment
- `apr` (mm/hr) active phase reactant, here ESR

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
    values::NTuple{4, Float64}
    names::NTuple{4, Symbol}
    units::NamedTuple
    function DAS28ESR(; tjc, sjc, pga, apr, units=DAS28ESR_UNITS)
        ntvals = (; tjc, sjc, pga, apr)
        uvals = unitfy(ntvals, units; conversions=DAS28ESR_UNITS)
        ucomponents = NamedTuple{keys(ntvals)}(uvals)

        valid_joints.([tjc, sjc])
        valid_vas(ucomponents.pga)
        valid_apr(ucomponents.apr)

        names = keys(ntvals)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, DAS28ESR_UNITS)
    end
end

intercept(x::DAS28CRP) = 0.96
