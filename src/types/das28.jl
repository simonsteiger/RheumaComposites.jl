abstract type DAS28 <: ContinuousComposite end

WeightingStyle(::Type{<:DAS28}) = IsWeighted()

"""
    DAS28CRP(t28, s28, pga, apr)

Store component measures of DAS28CRP.

# Components

- 28 tender joint count (`t28`)
- 28 swollen joint count (`s28`)
- patient global assessment (`pga`)
- acute-phase-reactant, here CRP (`apr`)

# Weighing

The components are then weighed according to the following formula:

...

# Example

```julia-repl
julia> DAS28CRP(4, 5, 12, 44)
> DAS28CRP(4.0, 5.0, 12.0, 44.0)
```
"""
struct DAS28CRP <: DAS28
    t28::Int64
    s28::Int64
    pga::Float64
    apr::Float64
    function DAS28CRP(; t28, s28, pga, apr)
        foreach([t28, s28]) do joints
            Base.isbetween(0, joints, 28) || throw(DomainError(joints, "only defined for 0 < joints < 28."))
            Base.isbetween(0, pga, 100) || throw(DomainError(pga, "VAS global must be between 0 and 100.")) # What is more common, 10cm or 100mm?
            apr >= 0 || throw(DomainError(apr, "CRP must be positive."))
        end
        return new(t28, s28, pga, apr)
    end
end

"""
    DAS28ESR(t28, s28, pga, apr)

Store component measures of DAS28ESR.

# Components

- 28 tender joint count (`t28`)
- 28 swollen joint count (`s28`)
- patient global assessment (`pga`)
- acute-phase-reactant, here ESR (`apr`)

# Weighing

The components are then weighed according to the following formula:

...

# Example

```julia-repl
julia> DAS28ESR(4, 5, 12, 44)
> DAS28ESR(4.0, 5.0, 12.0, 44.0)
```
"""
struct DAS28ESR <: DAS28
    t28::Int64
    s28::Int64
    pga::Float64
    apr::Float64
    function DAS28ESR(; t28, s28, pga, apr)
        foreach([t28, s28]) do joints
            Base.isbetween(0, joints, 28) || throw(DomainError(joints, "only defined for 0 < joints < 28."))
            Base.isbetween(0, pga, 100) || throw(DomainError(pga, "VAS global must be between 0 and 100.")) # What is more common, 10cm or 100mm?
            apr >= 0 || throw(DomainError(apr, "ESR must be positive."))
        end
        return new(t28, s28, pga, apr)
    end
end

intercept(x::DAS28CRP) = 0.96
