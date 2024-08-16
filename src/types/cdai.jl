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
    tjc::Int64
    sjc::Int64
    pga::Unitful.AbstractQuantity
    ega::Unitful.AbstractQuantity
    function CDAI(;
        tjc,
        sjc,
        pga::Unitful.AbstractQuantity,
        ega::Unitful.AbstractQuantity,
    )
        valid_joints.([tjc, sjc])
        valid_vas.([pga, ega])
        
        # Must convert because weights do not adjust to measurement
        return new(
            tjc,
            sjc,
            uconvert(units.xdai_vas, pga),
            uconvert(units.xdai_vas, ega),
        )
    end
end
