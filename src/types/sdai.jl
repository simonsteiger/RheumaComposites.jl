"""
    SDAI(; tjc, sjc, pga, ega, crp)

Store component measures of the Simplified Disease Activity Index, or SDAI.

# Components

- `tjc` 28 tender joint count
- `sjc` 28 swollen joint count
- `pga` patient's global assessment
- `ega` evaluator's global assessment
- `crp` c-reactive protein

!!! note "Units"
    `pga` and `ega` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

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
    components::NTuple{5, Float64}
    names::NTuple{5, Symbol}
    units::NamedTuple
    function SDAI(; tjc, sjc, pga, ega, crp, units=XDAI_UNITS)
        components = (; tjc, sjc, pga, ega, crp)
        ucomponents_vals = unitfy(components, units; conversions=XDAI_UNITS)
        ucomponents = NamedTuple{keys(components)}(ucomponents_vals)

        valid_joints.([tjc, sjc])
        valid_vas.([ucomponents.pga, ucomponents.ega])
        valid_apr(ucomponents.crp)

        names = keys(components)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, XDAI_UNITS)
    end
end
