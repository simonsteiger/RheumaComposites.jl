"""
    CDAI(; tjc, sjc, pga, ega[; units])

Store component measures of the Clinical Disease Activity Index, or CDAI.

Optionally specify the units for each component using [`Unitful.@u_str`](@extref).

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` (cm) patient's global assessment
- `ega` (cm) evaluator's global assessment

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
    values::NTuple{4, Float64}
    names::NTuple{4, Symbol}
    units::NamedTuple
    function CDAI(; tjc, sjc, pga, ega, units=XDAI_UNITS)
        ntvals = (; tjc, sjc, pga, ega)
        uvals = unitfy(ntvals, units; conversions=XDAI_UNITS)
        ucomponents = NamedTuple{keys(ntvals)}(uvals)

        valid_joints.([tjc, sjc])
        valid_vas.([ucomponents.pga, ucomponents.ega])

        names = keys(ntvals)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, XDAI_UNITS)
    end
end