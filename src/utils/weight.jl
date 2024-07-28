weights_das28esr = (
    t28=t28 -> sqrt(t28) * 0.56,
    s28=s28 -> sqrt(s28) * 0.28,
    pga=pga -> pga * 0.014,
    apr=apr -> log(apr) * 0.7,
)

weights_das28crp = (
    t28=t28 -> sqrt(t28) * 0.56,
    s28=s28 -> sqrt(s28) * 0.28,
    pga=pga -> pga * 0.014,
    apr=apr -> log1p(apr) * 0.36,
)

"""
    weight(c::T, v::Symbol)

Calculate the degree to which score `s` is made up of component `v`. The weighed components of `s` sum to 1.

# Example

```julia-repl
julia> weight(DAS28CRP(4, 5, 12, 44), :pga)
> 0.168
```
"""
weight(x::T) where {T} = weight(WeightingScheme(T), x)

weight(::IsUnweightable, x::T) where {T} = throw(ErrorException("$(typeof(x)) type is unweightable."))

weight(::IsUnweighted, x::T) where {T} = ustrip.(getproperty.(Ref(x), fieldnames(T)))

function _map_weights(weights, x)
    weighted_values = map(fieldnames(typeof(x))) do component
        component_value = ustrip(getproperty(x, component))
        component_weight = getproperty(weights, component)
        component_weight(component_value)
    end
    return weighted_values
end

function weight(::IsWeighted, x::DAS28CRP)
    weights = weights_das28crp
    weighted_values = _map_weights(weights, x)
    return weighted_values
end

function weight(::IsWeighted, x::DAS28ESR)
    weights = weights_das28esr
    weighted_values = _map_weights(weights, x)
    return weighted_values
end
