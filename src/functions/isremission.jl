_check(component, x) = getproperty(bool_cutoff_funs, component)(x)

_check(component, x, offset) = getproperty(bool_cutoff_funs, component)(x; offset=offset)

function isremission(::Type{<:BooleanComposite}, x)
    return mapreduce(component -> _check(component, x), &, x.names)
end

# We might be able to use a similar strategy as in `weight`
# So it might not be necessary to drop the cutoff_funs tuple and mapreduce
function isremission(::Type{<:Partial{N, <:BooleanComposite}}, x) where {N}
    return mapreduce(component -> _check(component, root(x)), &, x.names)
end

function isremission(::Type{<:Revised{<:BooleanComposite}}, x)
    offset_components = propertynames(offset(x))
    out = mapreduce(&, x.names) do compo
        if compo in offset_components
            compo_offset = getproperty(offset(x), compo)
            _check(compo, root(x), compo_offset)
        else
            _check(compo, root(x))
        end
    end
    return out
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
