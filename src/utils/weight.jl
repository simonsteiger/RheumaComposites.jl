weights_das28esr = (
    tjc=tjc -> sqrt(tjc) * 0.56,
    sjc=sjc -> sqrt(sjc) * 0.28,
    pga=pga -> pga * 0.014,
    apr=apr -> log(apr) * 0.7,
)

weights_das28crp = (
    tjc=tjc -> sqrt(tjc) * 0.56,
    sjc=sjc -> sqrt(sjc) * 0.28,
    pga=pga -> pga * 0.014,
    apr=apr -> log1p(apr) * 0.36,
)

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

weight(::IsUnweightable, x::T) where {T} = throw(ErrorException("$(typeof(x)) type is unweightable."))

weight(::IsUnweighted, x::T) where {T} = ustrip.(getproperty.(Ref(x), fieldnames(T)))

function map_weights(weights, x)
    weighted_values = map(fieldnames(typeof(x))) do component
        component_value = ustrip(getproperty(x, component))
        component_weight = getproperty(weights, component)
        component_weight(component_value)
    end
    return weighted_values
end

function weight(::IsWeighted, x::DAS28CRP)
    weights = weights_das28crp
    weighted_values = map_weights(weights, x)
    return weighted_values
end

function weight(::IsWeighted, x::DAS28ESR)
    weights = weights_das28esr
    weighted_values = map_weights(weights, x)
    return weighted_values
end
