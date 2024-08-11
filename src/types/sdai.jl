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
    Currently, `pga` and `ega` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

# Categories

- ``\\leq`` $(cont_cutoff.SDAI.low) = Remission
- ``\\leq`` $(cont_cutoff.SDAI.low) = Low
- ``\\leq`` $(cont_cutoff.SDAI.moderate) = Moderate
- ``>`` $(cont_cutoff.SDAI.moderate) = High

# External links

* [SDAI calculator](https://www.mdcalc.com/calc/2194/simple-disease-activity-index-sdai-rheumatoid-arthritis)

See also [`score`](@ref), [`categorise`](@ref), [`isremission`](@ref).
"""
struct SDAI <: ContinuousComposite
    tjc::Int64
    sjc::Int64
    pga::Unitful.AbstractQuantity
    ega::Unitful.AbstractQuantity
    crp::Unitful.AbstractQuantity
    function SDAI(;
        tjc,
        sjc,
        pga::Unitful.AbstractQuantity,
        ega::Unitful.AbstractQuantity,
        crp::Unitful.AbstractQuantity,
    )
        valid_joints.([tjc, sjc])
        valid_vas.([pga, ega])
        valid_apr(crp)
        
        # Must convert because weights do not adjust to measurement
        return new(
            tjc,
            sjc,
            uconvert(units.xdai_vas, pga),
            uconvert(units.xdai_vas, ega),
            uconvert(units.xdai_crp, crp)
        )
    end
end

WeightingScheme(::Type{<:SDAI}) = IsUnweighted()

"Return the evaluator's global assessment."
ega(x::SDAI) = x.ega
crp(x::SDAI) = x.crp
