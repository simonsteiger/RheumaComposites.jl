"""
    categorise(::Type{T}, s::Real) where {T<:ContinuousComposite}

Convert score `s` to a discrete value using `T`'s thresholds.

# Examples

```jldoctest
julia> categorise(SDAI, 3.6)
"low"
```
"""
function categorise(::Type{DAS28ESR}, s::Real)
    s < DAS28ESR_REMISSION ? "remission" :
    s <= DAS28ESR_LOW ? "low" :
    s <= DAS28ESR_MODERATE ? "moderate" :
    "high"
end

function categorise(::Type{DAS28CRP}, s::Real)
    s < DAS28CRP_REMISSION ? "remission" :
    s <= DAS28CRP_LOW ? "low" :
    s <= DAS28CRP_MODERATE ? "moderate" :
    "high"
end

function categorise(::Type{SDAI}, s::Real)
    s < SDAI_REMISSION ? "remission" :
    s <= SDAI_LOW ? "low" :
    s <= SDAI_MODERATE ? "moderate" :
    "high"
end

function categorise(::Type{CDAI}, s::Real)
    s < CDAI_REMISSION ? "remission" :
    s <= CDAI_LOW ? "low" :
    s <= CDAI_MODERATE ? "moderate" :
    "high"
end

function categorise(::Type{DAPSA}, s::Real)
    s < DAPSA_REMISSION ? "remission" :
    s <= DAPSA_LOW ? "low" :
    s <= DAPSA_MODERATE ? "moderate" :
    "high"
end

function categorise(::Type{BASDAI}, s::Real)
    s < DAPSA_REMISSION ? "remission" :
    "non-remission"
end

"""
    categorise(x::ContinuousComposite)

Convert `x` to a discrete value.

# Examples

```jldoctest
julia> DAS28ESR(tjc=4, sjc=5, pga=12, apr=44) |> categorise
"moderate"
```
"""
categorise(x::ContinuousComposite) = categorise(typeof(x), score(x))

"""
    categorise(x::Faceted{<:ContinuousComposite})

Convert the `root` composite of `x` to a discrete value.
"""
categorise(x::Faceted{<:ContinuousComposite}) = categorise(typeof(x.root), score(x.root))
