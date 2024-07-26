abstract type AbstractComposite end
abstract type ContinuousComposite <: AbstractComposite end
abstract type BooleanComposite <: AbstractComposite end
abstract type ModifiedComposite <: AbstractComposite end

t28(x::AbstractComposite) = x.t28
s28(x::AbstractComposite) = x.s28
pga(x::AbstractComposite) = x.pga
apr(x::AbstractComposite) = x.apr
t28(x::T) where {T<:ModifiedComposite} = t28(x.c0)
s28(x::T) where {T<:ModifiedComposite} = s28(x.c0)
pga(x::T) where {T<:ModifiedComposite} = pga(x.c0)
apr(x::T) where {T<:ModifiedComposite} = apr(x.c0)

abstract type WeightingScheme end
struct IsUnweightable <: WeightingScheme end
struct IsUnweighted <: WeightingScheme end
struct IsWeighted <: WeightingScheme end

WeightingScheme(::Type) = IsUnweightable()

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
