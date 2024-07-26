# FIXME Should these Dicts be NamedTuples? Probably only a speed buff?
weightfuns_das28esr = (
    t28=(x, t28) -> sqrt(t28) * 0.56,
    s28=(x, s28) -> sqrt(s28) * 0.28,
    pga=(x, pga) -> pga * 0.014,
    apr=(x, apr) -> log(apr) * 0.7,
)

weightfuns_das28crp = (
    t28=(x, t28) -> sqrt(t28) * 0.56,
    s28=(x, s28) -> sqrt(s28) * 0.28,
    pga=(x, pga) -> pga * 0.014,
    apr=(x, apr) -> log1p(apr) * 0.36,
)

weightfuns = (
    DAS28ESR=weightfuns_das28esr,
    DAS28CRP=weightfuns_das28crp,
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

weight(::IsUnweighted, x::T) where {T} = getproperty.(Ref(x), fieldnames(T))

function weight(::IsWeighted, x::T) where {T}
    weightfuns_t = getproperty(weightfuns, Symbol(T))
    weighted_values = map(fieldnames(T)) do component
        component_value = getproperty(x, component)
        weight_t = getproperty(weightfuns_t, component)
        weight_t(x, component_value)
    end
    return weighted_values
end
