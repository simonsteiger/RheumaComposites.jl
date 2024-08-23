"""
    SDAI(; tjc, sjc, pga, ega, crp[; units])

Store component measures of the Simplified Disease Activity Index, or SDAI.

Optionally specify the units for each component using [`Unitful.@u_str`](@extref).

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` (cm) patient's global assessment
- `ega` (cm) evaluator's global assessment
- `crp` (mg/dL) c-reactive protein

# Categories

- ``\\leq`` $(cutoff.SDAI.low) = Remission
- ``\\leq`` $(cutoff.SDAI.low) = Low
- ``\\leq`` $(cutoff.SDAI.moderate) = Moderate
- ``>`` $(cutoff.SDAI.moderate) = High

# External links

* [SDAI calculator](https://www.mdcalc.com/calc/2194/simple-disease-activity-index-sdai-rheumatoid-arthritis)

See also [`score`](@ref), [`categorise`](@ref), [`isremission`](@ref).
"""
struct SDAI <: ContinuousComposite
    values::NTuple{5, Float64}
    names::NTuple{5, Symbol}
    units::NamedTuple
    function SDAI(; tjc, sjc, pga, ega, crp)
        ntvals = (; tjc, sjc, pga, ega, crp)
        uvals = unitfy(ntvals, XDAI_UNITS)
        ucomponents = NamedTuple{keys(ntvals)}(uvals)

        valid_joints.([tjc, sjc])
        valid_vas.([ucomponents.pga, ucomponents.ega])
        valid_apr(ucomponents.crp)

        names = keys(ntvals)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, XDAI_UNITS)
    end
end
