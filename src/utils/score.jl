"""
    score(c::AbstractComposite; digits=3)

Score a composite and optionally specify the rounding precision.

# Examples

```jldoctest
julia> DAS28ESR(t28=4, s28=2, pga=64u"mm", apr=44u"mg/L") |> score
5.061
```
"""
score(x::AbstractComposite; digits=3) = round(intercept(x) + sum(weight(x)), digits=digits)
