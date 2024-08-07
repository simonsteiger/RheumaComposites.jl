cut = (
    DAS28ESR=(
        remission=2.6,
        low=3.2,
        moderate=5.1,
    ),
    DAS28CRP=(
        remission=2.4,
        low=2.9,
        moderate=4.6,
    ),
    SDAI=(
        remission=3.3,
        low=11.0,
        moderate=26.0,
    ),
    CDAI=(
        remission=2.8,
        low=10.0,
        moderate=22.0,
    )
)

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
    out = v < cut.DAS28ESR.remission ? "Remission" :
          v <= cut.DAS28ESR.low ? "Low" :
          v <= cut.DAS28ESR.moderate ? "Moderate" :
          "High"
    return out
end

function categorise(::Type{DAS28CRP}, v)
    out = v < cut.DAS28CRP.remission ? "Remission" :
          v <= cut.DAS28CRP.low ? "Low" :
          v <= cut.DAS28CRP.moderate ? "Moderate" :
          "High"
    return out
end

function categorise(::Type{SDAI}, v)
    out = v < cut.SDAI.remission ? "Remission" :
          v <= cut.SDAI.low ? "Low" :
          v <= cut.SDAI.moderate ? "Moderate" :
          "High"
    return out
end

function categorise(::Type{CDAI}, v)
    out = v < cut.CDAI.remission ? "Remission" :
          v <= cut.CDAI.low ? "Low" :
          v <= cut.CDAI.moderate ? "Moderate" :
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
categorise(x::Faceted{<:ContinuousComposite}) = categorise(typeof(x.c0), score(x.c0))
