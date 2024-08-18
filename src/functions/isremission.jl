_check(component, x) = getproperty(bool_cutoff_funs, component)(x)

_check(component, x, offset) = getproperty(bool_cutoff_funs, component)(x; offset=offset)

isremission(::Type{BooleanRemission}, x) = all(<=(1), x.components)

# Both functions below are easy to generalise to other BooleanComposites
# by mapping cutoffs, too (for BooleanRemission, e.g., [1, 1, 1, 1])
function isremission(::Type{<:Partial{BooleanRemission}}, x)
    included_components = getindex(components(x), x.indices)
    return mapreduce(c -> c <= 1, &, included_components)
end

function isremission(::Type{<:Revised{N,BooleanRemission}}, x) where {N}
    return mapreduce((o, c) -> c <= 1 + o, &, x.offsets, components(x))
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
isremission(::Type{DAS28ESR}, x) = score(x) < DAS28ESR_REMISSION

isremission(::Type{DAS28CRP}, x) = score(x) < DAS28CRP_REMISSION

isremission(::Type{SDAI}, x) = score(x) <= SDAI_REMISSION

isremission(::Type{CDAI}, x) = score(x) <= CDAI_REMISSION

isremission(::Type{DAPSA}, x) = score(x) <= DAPSA_REMISSION

isremission(::Type{BASDAI}, x) = score(x) < BASDAI_REMISSION

"""
    isremission(x::T) where {T<:AbstractComposite}

Check whether a composite fulfils remission criteria.

# Examples

```jldoctest
julia> DAS28ESR(tjc=4, sjc=5, pga=44u"mm", apr=23u"mm/hr") |> isremission
false
julia> BooleanRemission(tjc=1, sjc=0, pga=14u"mm", crp=0.4u"mg/dl") |>
       revised |>
       isremission
true
```
"""
isremission(x::T) where {T<:AbstractComposite} = isremission(T, x)
