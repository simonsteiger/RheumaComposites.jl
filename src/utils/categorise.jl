"""
    categorise(x::ContinuousComposite)

Convert `x` to a discrete value.

# Examples

```jldoctest
julia> DAS28ESR(t28=4, s28=5, pga=12u"mm", apr=44u"mm/hr") |> categorise
"Moderate"
```

    categorise(::Type{SDAI}, v)

Convert `v` to a discrete value using `SDAI` thresholds.

The same functionality exists for other `ContinuousComposites`.

See also [`DAS28ESR`](@ref), [`DAS28CRP`](@ref).

# Examples

```jldoctest
julia> categorise(SDAI, 3.6)
"Low"
```
"""
function categorise(::Type{DAS28CRP}, v)
    out = v < 2.4 ? "Remission" :
          v <= 2.9 ? "Low" :
          v <= 4.6 ? "Moderate" :
          "High"
    return out
end

function categorise(::Type{DAS28ESR}, v)
    out = v < 2.6 ? "Remission" :
          v <= 3.2 ? "Low" :
          v <= 5.1 ? "Moderate" :
          "High"
    return out
end

function categorise(::Type{SDAI}, v)
    out = v < 3.3 ? "Remission" :
          v <= 11.0 ? "Low" :
          v <= 26.0 ? "Moderate" :
          "High"
    return out
end

categorise(x::ContinuousComposite) = categorise(typeof(x), score(x))

categorise(x::Faceted{<:ContinuousComposite}) = categorise(typeof(x.c0), score(x.c0))
