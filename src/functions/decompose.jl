"""
    decompose(x::ContinuousComposite; digits=3)

Return the proportion to which each component contributes to the composite's score.

Optionally specify the number of digits to round the results to.

See also [`score`](@ref).

# Examples

```jldoctest
julia> SDAI(tjc=4, sjc=5, pga=16u"mm", ega=12u"mm", crp=3u"mg/L") |> decompose
(tjc = 0.331, sjc = 0.413, pga = 0.132, ega = 0.099, crp = 0.025)
```
"""
function decompose(x::ContinuousComposite; digits=3)
    ratios = round.(weight(x) ./ sum(weight(x)), digits=digits)
    return Dict{Symbol, Float64}(Pair.(x.names, ratios))
end

"""
    decompose(x::Faceted{<:ContinuousComposite}; digits=3)

Return the proportion to which each facet contributes to the composite's score.

# Examples

```jldoctest
julia> root = DAS28ESR(tjc=4, sjc=5, pga=14u"mm", apr=12u"mm/hr");

julia> faceted(root, (objective=[:sjc, :apr], subjective=[:tjc, :pga])) |> decompose
(objective = 0.474, subjective = 0.525)
```
"""
function decompose(x::Faceted{<:ContinuousComposite}; digits=3)
    root = x.root
    facets = keys(x.facets)
    fields_per_facet = values(x.facets)
    decomp = decompose(root; digits=digits)
    # FIXME Speed: looped `getindex` slows this down a lot, how to do better?
    sum_per_facet = mapreduce(fields -> getindex.(Ref(decomp), fields), +, fields_per_facet)
    return Dict{Symbol, Float64}(Pair.(facets, sum_per_facet))
end
