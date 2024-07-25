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
    pga::Float64
    ega::Float64
    crp::Float64
    function SDAI(; t28, s28, pga, ega, crp)
        foreach([t28, s28]) do joints
            Base.isbetween(0, joints, 28) || throw(DomainError(joints, "only defined for 0 < joints < 28."))
        end
        Base.isbetween(0, pga, 10) || throw(DomainError(pga, "VAS global must be between 0 and 10.")) # What is more common, 10cm or 100mm?
        Base.isbetween(0, ega, 10) || throw(DomainError(ega, "evaluator global must be between 0 and 10.")) # What is more common, 10cm or 100mm?
        crp >= 0 || throw(DomainError(crp, "CRP must be positive."))
        return new(t28, s28, pga, ega, crp)
    end
end