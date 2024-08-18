"""
    DAPSA(; tjc, sjc, pga, jpn)

Store component measures of the index for Disease Activity in Psoriatic Arthritis, or DAPSA.

# Components

- `tjc` 66 tender joint count
- `sjc` 68 swollen joint count
- `pga` patient's global assessment
- `jpn` joint pain

!!! note "Units"
    `pga` and `jpn` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

# Categories

- ``\\leq`` $(cutoff.DAPSA.low) = Remission
- ``\\leq`` $(cutoff.DAPSA.low) = Low
- ``\\leq`` $(cutoff.DAPSA.moderate) = Moderate
- ``>`` $(cutoff.DAPSA.moderate) = High

# External links

* [DAPSA calculator](https://www.mdapp.co/disease-activity-in-psoriatic-arthritis-dapsa-calculator-612/)

See also [`score`](@ref), [`categorise`](@ref), [`isremission`](@ref).
"""
struct DAPSA <: ContinuousComposite
    components::NTuple{5, Float64}
    names::NTuple{5, Symbol}
    units::NamedTuple
    function DAPSA(; tjc, sjc, crp, pga, jpn, units=DAPSA_UNITS)
        components = (; tjc, sjc, crp, pga, jpn)
        ucomponents_vals = unitfy(components, units; conversions=DAPSA_UNITS)
        ucomponents = NamedTuple{keys(components)}(ucomponents_vals)

        mapreduce((jc, max) -> valid_joints(jc; max=max), &, [tjc, sjc], [66, 68])
        valid_vas.([ucomponents.pga, ucomponents.jpn])
        valid_apr(crp)

        names = keys(components)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, DAPSA_UNITS)
    end
end
