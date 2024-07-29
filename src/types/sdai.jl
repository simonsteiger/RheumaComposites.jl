"""
    SDAI(; t28, s28, pga, ega, crp)

Store component measures of the Simplified Disease Activity Index, or SDAI.

See also [`score`](@ref), [`isremission`](@ref).

# Example

```jldoctest
julia> SDAI(t28=4, s28=5, pga=12u"mm", ega=5u"mm", crp=44u"mg/L")
SDAI
[...]
```

# External links

* [SDAI calculator](https://www.mdcalc.com/calc/2194/simple-disease-activity-index-sdai-rheumatoid-arthritis)
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

ega(x::SDAI) = x.ega
crp(x::SDAI) = x.crp
