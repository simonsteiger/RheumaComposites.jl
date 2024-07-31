"""
    score(c::ContinuousComposite; digits=3)

Score a composite and optionally specify the rounding precision.

# Examples

```jldoctest
julia> DAS28ESR(t28=4, s28=2, pga=64u"mm", apr=44u"mm/hr") |> score
5.061
```
"""
score(x::ContinuousComposite; digits=3) = round(intercept(x) + sum(weight(x)), digits=digits)

score(x::Faceted{<:ContinuousComposite}; digits=3) = score(x.c0; digits=digits)
