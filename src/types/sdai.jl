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
