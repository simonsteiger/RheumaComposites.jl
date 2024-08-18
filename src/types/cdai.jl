"""
    CDAI(; tjc, sjc, pga, ega)

Store component measures of the Clinical Disease Activity Index, or CDAI.

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` patient's global assessment
- `ega` evaluator's global assessment

!!! note "Units"
    `pga` and `ega` must be a length (typically millimeters or centimeters).
    See also [`Unitful.@u_str`](@extref).

# Categories

- ``<`` $(cutoff.CDAI.low) = Remission
- ``\\leq`` $(cutoff.CDAI.low) = Low
- ``\\leq`` $(cutoff.CDAI.moderate) = Moderate
- ``>`` $(cutoff.CDAI.moderate) = High

# External links

* [CDAI calculator](https://www.mdcalc.com/calc/2177/clinical-disease-activity-index-cdai-rheumatoid-arthritis)

See also [`score`](@ref), [`categorise`](@ref), [`isremission`](@ref).
"""
struct CDAI <: ContinuousComposite
    components::NTuple{4, Float64}
    names::NTuple{4, Symbol}
    units::NamedTuple
    function CDAI(; tjc, sjc, pga, ega, units=XDAI_UNITS)
        components = (; tjc, sjc, pga, ega)
        ucomponents_vals = unitfy(components, units; conversions=XDAI_UNITS)
        ucomponents = NamedTuple{keys(components)}(ucomponents_vals)

        valid_joints.([tjc, sjc])
        valid_vas.([ucomponents.pga, ucomponents.ega])

        names = keys(components)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, XDAI_UNITS)
    end
end