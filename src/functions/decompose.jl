"""
    decompose(x::ContinuousComposite; digits=3)

Return the proportion to which each component contributes to the composite's score.

Optionally specify the number of digits to round the results to.

See also [`score`](@ref).

# Examples

```jldoctest
julia> SDAI(tjc=4, sjc=5, pga=1.6u"cm", ega=1.2u"cm", crp=3u"mg/dL") |> decompose
Dict{Symbol, Float64} with 5 entries:
  :tjc => 0.27
  :ega => 0.081
  :sjc => 0.338
  :pga => 0.108
  :crp => 0.203
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
Dict{Symbol, Float64} with 2 entries:
  :subjective => 0.357
  :objective  => 0.642
```
"""
function decompose(x::Faceted{<:ContinuousComposite}; digits=3)
    root = x.root
    facets = keys(x.facets)
    fields_per_facet = values(x.facets)
    decomp = decompose(root; digits=digits)
    # FIXME Speed: looped `getindex` slows this down a lot, how to do better?
    sum_per_facet = map(fields -> sum(getindex.(Ref(decomp), fields)), fields_per_facet)
    return Dict{Symbol, Float64}(Pair.(facets, sum_per_facet))
end
