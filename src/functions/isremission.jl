function isremission(::Type{T}, x::AbstractComposite) where {T<:ContinuousComposite}
    cut = getproperty(cont_cutoff_funs, _typename(T))
    return cut.remission(score(x))
end

_check(component, x) = getproperty(bool_cutoff_funs, component)(x)

_check(component, x, offset) = getproperty(bool_cutoff_funs, component)(x; offset=offset)

function isremission(::Type{<:BooleanComposite}, x)
    return mapreduce(component -> _check(component, x), &, components(x))
end

function isremission(::Type{<:Partial{N, <:BooleanComposite}}, x) where {N}
    return mapreduce(component -> _check(component, root(x)), &, components(x))
end

function isremission(::Type{<:Revised{<:BooleanComposite}}, x)
    offset_components = propertynames(offset(x))
    out = mapreduce(&, components(x)) do compo
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
    isremission(x::AbstractComposite)

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
isremission(x::AbstractComposite) = isremission(typeof(x), x)

"""
    isremission(::Type{T}, s::Real) where {T<:ContinuousComposite}

Check whether a composite fulfils remission criteria.

# Examples

```jldoctest
julia> isremission(DAS28ESR, 3.9)
false
```
"""
function isremission(::Type{T}, s::Real) where {T<:ContinuousComposite}
    cut = getproperty(cont_cutoff_funs, Symbol(T))
    return cut.remission(s)
end
