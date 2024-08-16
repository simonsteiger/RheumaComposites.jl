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
    tjc::Int64
    sjc::Int64
    crp::Unitful.AbstractQuantity
    pga::Unitful.AbstractQuantity
    jpn::Unitful.AbstractQuantity
    function DAPSA(;
        tjc,
        sjc,
        crp::Unitful.AbstractQuantity,
        pga::Unitful.AbstractQuantity,
        jpn::Unitful.AbstractQuantity,
    )
        mapreduce((jc, max) -> valid_joints(jc; max=max), &, [tjc, sjc], [66, 68])
        valid_vas.([pga, jpn])
        valid_apr(crp)
        
        # Must convert because weights do not adjust to measurement
        return new(
            tjc,
            sjc,
            uconvert(units.xdai_crp, crp),
            uconvert(units.xdai_vas, pga),
            uconvert(units.xdai_vas, jpn),
        )
    end
end

WeightingScheme(::Type{<:DAPSA}) = IsUnweighted()
