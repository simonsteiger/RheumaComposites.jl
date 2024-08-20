"""
    weight(x::T) where {T}

Weight a composite score's components according to its weighting scheme.

# Example

```jldoctest
julia> DAS28CRP(tjc=2, sjc=2, pga=54, apr=19) |> weight
(0.7919595949289333, 0.39597979746446665, 0.756, 1.0784636184794367)
```
"""
weight(x::T) where {T} = weight(WeightingScheme(T), x)

weight(x::Partial{N,T}) where {N,T} = weight(WeightingScheme(T), x)

weight(::IsUnweightable, x::T) where {T} = throw(ErrorException("$T is unweightable."))

weight(::IsUnweighted, x::T) where {T} = x.values

map_weights(weights, x) = map((w, v) -> w(v), values(weights), x.values)

weight(::IsWeighted, x::DAS28ESR) = map_weights(weights_das28esr, x)

weight(::IsWeighted, x::DAS28CRP) = map_weights(weights_das28crp, x)

weight(::IsWeighted, x::BASDAI) = map_weights(weights_basdai, x)

#=
# TODO Decide if we want to allow partial continuous composites
# If so, needs tests
weight(::IsWeighted, x::Partial{N,DAS28ESR}) where {N} = map_weights(weights_das28esr, x)
weight(::IsWeighted, x::Partial{N,DAS28CRP}) where {N} = map_weights(weights_das28crp, x)
=#
