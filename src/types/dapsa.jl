"""
    DAPSA(; tjc, sjc, pga, jpn[; units])

Store component measures of the index for Disease Activity in Psoriatic Arthritis, or DAPSA.

Optionally specify the units for each component using [`Unitful.@u_str`](@extref).

# Components

- `tjc` 66 tender joint count
- `sjc` 68 swollen joint count
- `pga` (cm) patient's global assessment
- `jpn` (cm) joint pain

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
    values::NTuple{5, Float64}
    names::NTuple{5, Symbol}
    units::NamedTuple
    function DAPSA(; tjc, sjc, crp, pga, jpn)
        ntvals = (; tjc, sjc, crp, pga, jpn)
        uvals = unitfy(ntvals, DAPSA_UNITS)
        ucomponents = NamedTuple{keys(ntvals)}(uvals)

        mapreduce((jc, max) -> valid_joints(jc; max=max), &, [tjc, sjc], [66, 68])
        valid_vas.([ucomponents.pga, ucomponents.jpn])
        valid_apr(crp)

        ntnames = keys(ntvals)
        vals = ustrip.(values(ucomponents))
        return new(vals, ntnames, DAPSA_UNITS)
    end
end
