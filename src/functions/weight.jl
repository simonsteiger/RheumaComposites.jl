"""
    weight(x::T) where {T}

Weight a composite score's components according to its weighting scheme.

# Example

```jldoctest
julia> DAS28CRP(tjc=2, sjc=2, pga=54u"mm", apr=19u"mg/L") |> weight
(0.7919595949289333, 0.39597979746446665, 0.756, 1.0784636184794367)
```
"""
weight(x::T) where {T} = weight(WeightingScheme(T), x)
weight(x::Subset{N,T}) where {N,T} = weight(WeightingScheme(T), x)

weight(::IsUnweightable, x::T) where {T} = throw(ErrorException("$(typeof(x)) type is unweightable."))

weight(::IsUnweighted, x::T) where {T} = ustrip.(getproperty.(Ref(x), components(x)))

function map_weights(weights, x)
    component_values = ustrip.(getproperty.(Ref(x), components(x)))
    component_weights = getproperty.(Ref(weights), components(x))
    return map((w, v) -> w(v), component_weights, component_values)
end

weight(::IsWeighted, x::DAS28ESR) = map_weights(weights_das28esr, x)
weight(::IsWeighted, x::DAS28CRP) = map_weights(weights_das28crp, x)
weight(::IsWeighted, x::Subset{DAS28ESR}) = map_weights(weights_das28esr, x)
weight(::IsWeighted, x::Subset{DAS28CRP}) = map_weights(weights_das28crp, x)

weight(::IsWeighted, x::BASDAI) = map_weights(weights_basdai, x)
