"""
    decompose(x::ContinuousComposite; digits=3)

Return the proportion to which each component contributes to the composite's score.

Optionally specify the number of digits to round the results to.

See also [`score`](@ref).

# Examples

```jldoctest
julia> SDAI(t28=4, s28=5, pga=16u"mm", ega=12u"mm", crp=3u"mg/L") |> decompose
(t28 = 0.331, s28 = 0.413, pga = 0.132, ega = 0.099, crp = 0.025)
```

    decompose(x::Faceted{<:ContinuousComposite}; digits=3)

Return the proportion to which each facet contributes to the composite's score.

# Examples

```jldoctest
julia> c0 = DAS28ESR(t28=4, s28=5, pga=14u"mm", apr=12u"mm/hr");

julia> faceted(c0, (objective=[:s28, :apr], subjective=[:t28, :pga])) |> decompose
(objective = 0.474, subjective = 0.525)
```
"""
function decompose(x::ContinuousComposite; digits=3)
    ratios = round.(weight(x) ./ sum(weight(x)), digits=digits)
    fields = fieldnames(typeof(x))
    return NamedTuple{fields}(ratios)
end

function decompose(x::Faceted{<:ContinuousComposite}; digits=3)
    c0 = x.c0
    facets = propertynames(x.facets)
    fields_per_facet = getproperty.(Ref(x.facets), facets)
    decomp = decompose(c0; digits=digits)
    sum_per_facet = mapreduce(fields -> getproperty.(Ref(decomp), fields), +, fields_per_facet)
    return NamedTuple{facets}(sum_per_facet)
end
