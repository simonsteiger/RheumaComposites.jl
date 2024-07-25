abstract type AbstractComposite end
abstract type ContinuousComposite <: AbstractComposite end
abstract type BooleanComposite <: AbstractComposite end

# Do we need this at all?
abstract type WeightingStyle end
struct IsWeighted <: WeightingStyle end
struct IsUnweighted <: WeightingStyle end

WeightingStyle(::Type) = IsUnweighted()

"""
    intercept(x::ContinuousComposite)

Return the intercept of a ContinuousComposite `x`.
This defaults to zero if no intercept is defined for this specific Composite.

# Example

```julia-repl
julia> intercept(DAS28ESR(4, 5, 12, 44))
> 0.0
```

    intercept(x::DAS28CRP)

Return the intercept of a DAS28CRP `x`.

# Example

```julia-repl
julia> intercept(DAS28CRP(4, 5, 12, 44))
> 0.96
```
"""
intercept(x::ContinuousComposite) = 0.0

function Base.show(io::IO, ::MIME"text/plain", x::AbstractComposite)
    header = @bold string(typeof(x))
    fields = map(fieldnames(typeof(x))) do component
        "$((uppercase ∘ string)(component)): $(getproperty(x, component))"
    end
    print(io, join([header, fields...], "\n  "))
end
