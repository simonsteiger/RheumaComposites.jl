"""
    categorise(x::ContinuousComposite)

Convert `x` to a discrete value.

# Examples

```jldoctest
julia> DAS28ESR(tjc=4, sjc=5, pga=12u"mm", apr=44u"mm/hr") |> categorise
"Moderate"
```
"""
function categorise(::Type{DAS28ESR}, v)
    out = v < cont_cutoff.DAS28ESR.remission ? "Remission" :
          v <= cont_cutoff.DAS28ESR.low ? "Low" :
          v <= cont_cutoff.DAS28ESR.moderate ? "Moderate" :
          "High"
    return out
end

function categorise(::Type{DAS28CRP}, v)
    out = v < cont_cutoff.DAS28CRP.remission ? "Remission" :
          v <= cont_cutoff.DAS28CRP.low ? "Low" :
          v <= cont_cutoff.DAS28CRP.moderate ? "Moderate" :
          "High"
    return out
end

function categorise(::Type{SDAI}, v)
    out = v < cont_cutoff.SDAI.remission ? "Remission" :
          v <= cont_cutoff.SDAI.low ? "Low" :
          v <= cont_cutoff.SDAI.moderate ? "Moderate" :
          "High"
    return out
end

function categorise(::Type{CDAI}, v)
    out = v < cont_cutoff.CDAI.remission ? "Remission" :
          v <= cont_cutoff.CDAI.low ? "Low" :
          v <= cont_cutoff.CDAI.moderate ? "Moderate" :
          "High"
    return out
end

categorise(x::ContinuousComposite) = categorise(typeof(x), score(x))

"""
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
categorise(x::Faceted{<:ContinuousComposite}) = categorise(typeof(x.root), score(x.root))
