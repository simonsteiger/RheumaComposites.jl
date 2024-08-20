"""
    score(c::ContinuousComposite; digits=3)

Score a composite and optionally specify the rounding precision.

# Examples

```jldoctest
julia> DAS28ESR(tjc=4, sjc=2, pga=64, apr=44) |> score
5.061
```
"""
score(x::ContinuousComposite; digits=3) = round(intercept(x) + sum(weight(x)), digits=digits)

score(x::Partial{<:ContinuousComposite}; digits=3) = round(intercept(x) + sum(weight(x)), digits=digits)

score(x::Faceted{<:ContinuousComposite}; digits=3) = score(x.root; digits=digits)
