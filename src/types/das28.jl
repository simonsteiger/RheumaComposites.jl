abstract type DAS28 <: ContinuousComposite end

WeightingScheme(::Type{<:DAS28}) = IsWeighted()

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
    pga::Unitful.AbstractQuantity
    apr::Unitful.AbstractQuantity
    function DAS28CRP(;
        t28,
        s28,
        pga::Unitful.AbstractQuantity,
        apr::Unitful.AbstractQuantity,
    )
        valid_joints.([t28, s28])
        valid_vas(pga)
        valid_apr(apr)
        
        # Must convert because weights do not adjust to measurement
        return new(
            t28,
            s28,
            uconvert(units.das28_vas, pga),
            uconvert(units.das28_crp, apr)
        )
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
    pga::Unitful.AbstractQuantity
    apr::Unitful.AbstractQuantity
    function DAS28ESR(;
        t28,
        s28,
        pga::Unitful.AbstractQuantity,
        apr::Unitful.AbstractQuantity,
    )
        valid_joints.([t28, s28])
        valid_vas(pga)
        valid_apr(apr)
        return new(
            t28,
            s28,
            uconvert(units.das28_vas, pga),
            uconvert(units.das28_esr, apr)
        )
    end
end

intercept(x::DAS28CRP) = 0.96
