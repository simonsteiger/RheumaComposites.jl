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
struct SDAI <: ContinuousResponse # TODO fields are Any right now, poor for performance!
    t28
    s28
    pga
    ega
    crp
    function SDAI(t28, s28, pga, ega, crp)
        foreach(jc -> Base.isbetween(0, value(jc), 28) || throw(DomainError(jc, "joint counts must be between 0 and 28.")), [t28, s28])
        Base.isbetween(0, value(pga), 100) || throw(DomainError(pga, "VAS global must be between 0 and 100."))
        # TODO add check for ega
        value(crp) >= 0 || throw(DomainError(crp, "CRP must be positive."))
        return new(t28, s28, pga, ega, crp)
    end
end