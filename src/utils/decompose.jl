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
"""
function decompose(x::ContinuousComposite; digits=3)
    ratios = round.(weight(x) ./ sum(weight(x)), digits=digits)
    fields = fieldnames(typeof(x))
    return NamedTuple{fields}(ratios)
end
