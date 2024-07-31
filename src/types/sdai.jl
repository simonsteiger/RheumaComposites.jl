"""
    SDAI(; t28, s28, pga, ega, crp)

Store component measures of the Simplified Disease Activity Index, or SDAI.

# Components

- `t28` 28 tender joint count
- `s28` 28 swollen joint count
- `pga` patient's global assessment
- `ega` evaluator's global assessment
- `crp` c-reactive protein

!!! warning "Units"
    Currently, `pga` and `ega` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

# External links

* [SDAI calculator](https://www.mdcalc.com/calc/2194/simple-disease-activity-index-sdai-rheumatoid-arthritis)

See also [`score`](@ref), [`isremission`](@ref).
"""
struct SDAI <: ContinuousComposite
    t28::Int64
    s28::Int64
    pga::Unitful.AbstractQuantity
    ega::Unitful.AbstractQuantity
    crp::Unitful.AbstractQuantity
    function SDAI(;
        t28,
        s28,
        pga::Unitful.AbstractQuantity,
        ega::Unitful.AbstractQuantity,
        crp::Unitful.AbstractQuantity,
    )
        valid_joints.([t28, s28])
        valid_vas.([pga, ega])
        valid_apr(crp)
        
        # Must convert because weights do not adjust to measurement
        return new(
            t28,
            s28,
            uconvert(units.sdai_vas, pga),
            uconvert(units.sdai_vas, ega),
            uconvert(units.sdai_crp, crp)
        )
    end
end

WeightingScheme(::Type{<:SDAI}) = IsUnweighted()

"Return the evaluator's global assessment."
ega(x::SDAI) = x.ega
crp(x::SDAI) = x.crp
