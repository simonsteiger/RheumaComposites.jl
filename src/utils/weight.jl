dict_weights_das28esr = Dict(
    :t28 => (x, t28) -> sqrt(t28) * 0.56,
    :s28 => (x, s28) -> sqrt(s28) * 0.28,
    :pga => (x, pga) -> pga * 0.014,
    :apr => (x, apr) -> log(apr) * 0.7,
)

dict_weights_das28crp = Dict(
    :t28 => (x, t28) -> sqrt(t28) * 0.56,
    :s28 => (x, s28) -> sqrt(s28) * 0.28,
    :pga => (x, pga) -> pga * 0.014,
    :apr => (x, apr) -> log1p(apr) * 0.36,
)

dict_weights = Dict(
    "DAS28ESR" => dict_weights_das28esr,
    "DAS28CRP" => dict_weights_das28crp,
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
weight(x::ContinuousComposite, component::Symbol) = getproperty(x, component)

function weight(x::DAS28, component::Symbol)
    component_value = getproperty(x, component)
    return das28_weights[component](x, component_value)
end

weight(x::T) where {T} = weight(WeightingStyle(T), x)

weight(::IsUnweighted, x::T) where {T} = getproperty.(x, fieldnames(T))
function weight(::IsWeighted, x::T) where {T}
    weights = dict_weights[string(T)]
    weighted_values = map(fieldnames(T)) do component
        component_value = getproperty(x, component)
        weights[component](x, component_value)
    end
    return weighted_values
end
