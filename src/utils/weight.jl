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
weight(x::Subset{T}) where {T} = weight(WeightingScheme(T), x)

weight(::IsUnweightable, x::T) where {T} = throw(ErrorException("$(typeof(x)) type is unweightable."))

weight(::IsUnweighted, x::T) where {T} = ustrip.(getproperty.(Ref(x), fieldnames(T)))

function map_weights(weights, x)
    weighted_values = map(components(x)) do component
        component_value = ustrip(getproperty(root(x), component))
        component_weight = getproperty(weights, component)
        component_weight(component_value)
    end
    return weighted_values
end

function weight(::IsWeighted, x::DAS28)
    weights = x isa DAS28ESR ? weights_das28esr : weights_das28crp
    weighted_values = map_weights(weights, x)
    return weighted_values
end

function weight(::IsWeighted, x::Subset{<:DAS28})
    weights = root(x) isa DAS28ESR ? weights_das28esr : weights_das28crp
    weighted_values = map_weights(weights, x)
    return weighted_values
end
