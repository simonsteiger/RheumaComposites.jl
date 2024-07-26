"""
    SDAI(t28, s28, pga, ega, crp)

Store component measures of Simplified Disease Activity Index, or SDAI.

# Components

- 28 tender joint count (`t28`)
- 28 swollen joint count (`s28`)
- patient global assessment (`pga`)
- evaluator global assessment (`ega`)
- C-reactive protein in mg/L (`crp`)

# Weighing

The SDAI is the sum of all unweighted components.

# Example

```julia-repl
julia> SDAI(4, 5, 12, 5, 44)
> SDAI(4.0, 5.0, 12.0, 5.0, 44.0)
```
"""
struct SDAI <: ContinuousComposite
    t28::Int64
    s28::Int64
    pga::Unitful.AbstractQuantity
    ega::Unitful.AbstractQuantity
    crp::Unitful.AbstractQuantity
    function SDAI(; t28, s28, pga::Unitful.AbstractQuantity, ega::Unitful.AbstractQuantity, crp::Unitful.AbstractQuantity)
        foreach([t28, s28]) do joints
            Base.isbetween(0, joints, 28) || throw(DomainError(joints, "only defined for 0 < joints < 28."))
        end
        Base.isbetween(0units.sdai_vas, units.sdai_vas(pga), 10units.sdai_vas) || throw(DomainError(units.sdai_vas(pga), "only defined for 0 cm < pga < 10 cm."))
        Base.isbetween(0units.sdai_vas, units.sdai_vas(ega), 10units.sdai_vas) || throw(DomainError(units.sdai_vas(pga), "only defined for 0 cm < ega < 10 cm."))
        units.sdai_crp(crp) >= 0units.sdai_crp || throw(DomainError(units.sdai_crp(crp), "ESR must be positive."))
        return new(t28, s28, units.sdai_vas(pga), units.sdai_vas(ega), units.sdai_crp(crp))
    end
end

WeightingScheme(::Type{<:SDAI}) = IsUnweighted()

ega(x::SDAI) = x.ega
crp(x::SDAI) = x.crp
