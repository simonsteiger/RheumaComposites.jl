isremission(::Type{BooleanRemission}, x) = all(<=(1), x.values)

# Both functions below are easy to generalise to other BooleanComposites
# by mapping cutoffs, too (for BooleanRemission, e.g., [1, 1, 1, 1])
function isremission(::Type{<:Partial{N,BooleanRemission}}, x) where {N}
    return mapreduce(c -> c <= 1, &, x.values)
end

function isremission(::Type{<:Revised{BooleanRemission}}, x)
    return mapreduce((o, c) -> c <= 1 + o, &, x.offsets, (values ∘ root)(x))
end

function isremission(::Type{<:Partial{N,<:Revised{BooleanRemission}}}, x) where {N}
    active_components = x.names
    root_components = root(root(x)).names
    active_idx = [component in active_components for component in root_components]
    active_offsets = root(x).offsets[active_idx]
    return mapreduce((o, c) -> c <= 1 + o, &, active_offsets, values(x))
end

"""
    isremission(::Type{T}, s::Real) where {T<:ContinuousComposite}

Check whether a composite fulfils remission criteria.

# Examples

```jldoctest
julia> isremission(DAS28ESR, 3.9)
false
```
"""
isremission(::Type{DAS28ESR}, x) = x < DAS28ESR_REMISSION

isremission(::Type{DAS28CRP}, x) = x < DAS28CRP_REMISSION

isremission(::Type{SDAI}, x) = x <= SDAI_REMISSION

isremission(::Type{CDAI}, x) = x <= CDAI_REMISSION

isremission(::Type{DAPSA}, x) = x <= DAPSA_REMISSION

isremission(::Type{BASDAI}, x) = x < BASDAI_REMISSION

"""
    isremission(x::AbstractComposite)

Check whether a composite fulfils remission criteria.

# Examples

```jldoctest
julia> DAS28ESR(tjc=4, sjc=5, pga=44u"mm", apr=23u"mm/hr") |> isremission
false
julia> BooleanRemission(tjc=1, sjc=0, pga=1.4u"cm", crp=0.4u"mg/dL") |>
       revised |>
       isremission
true
```
"""
isremission(x::AbstractComposite) = isremission(typeof(x), x)

isremission(x::ContinuousComposite) = isremission(typeof(x), score(x))
