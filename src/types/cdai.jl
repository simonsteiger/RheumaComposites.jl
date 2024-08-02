"""
    CDAI(; t28, s28, pga, ega)

Store component measures of the Clinical Disease Activity Index, or CDAI.

# Components

- `t28` 28 tender joint count
- `s28` 28 swollen joint count
- `pga` patient's global assessment
- `ega` evaluator's global assessment

!!! warning "Units"
    Currently, `pga` and `ega` must be a length (typically millimeters or centimeters).
    See also [`Unitful.@u_str`](@extref).

# External links

* [CDAI calculator](https://www.mdcalc.com/calc/2177/clinical-disease-activity-index-cdai-rheumatoid-arthritis)

See also [`score`](@ref), [`isremission`](@ref).
"""
struct CDAI <: ContinuousComposite
    t28::Int64
    s28::Int64
    pga::Unitful.AbstractQuantity
    ega::Unitful.AbstractQuantity
    function CDAI(;
        t28,
        s28,
        pga::Unitful.AbstractQuantity,
        ega::Unitful.AbstractQuantity,
    )
        valid_joints.([t28, s28])
        valid_vas.([pga, ega])
        
        # Must convert because weights do not adjust to measurement
        return new(
            t28,
            s28,
            uconvert(units.xdai_vas, pga),
            uconvert(units.xdai_vas, ega),
        )
    end
end

WeightingScheme(::Type{<:CDAI}) = IsUnweighted()

"Return the evaluator's global assessment."
ega(x::CDAI) = x.ega
