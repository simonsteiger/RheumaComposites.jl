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
isremission(::Type{DAS28ESR}, x) = score(x) < cont_cutoff.DAS28ESR.remission
isremission(::Type{DAS28CRP}, x) = score(x) < cont_cutoff.DAS28CRP.remission

isremission(::Type{SDAI}, x) = score(x) <= cont_cutoff.SDAI.remission
isremission(::Type{CDAI}, x) = score(x) <= cont_cutoff.CDAI.remission

isremission(::Type{PGA}, x) = x.value <= 10.0u"mm"
isremission(::Type{SJC}, x) = x.value == 0

_check(component, x) = getproperty(bool_cutoff_funs, component)(x)

_check(component, x, offset) = getproperty(bool_cutoff_funs, component)(x; offset=offset)

function isremission(::Type{<:BooleanComposite}, x)
    return mapreduce(component -> _check(component, x), &, components(x))
end

function isremission(::Type{<:Subset{N, <:BooleanComposite}}, x) where {N}
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

isremission(x::AbstractComposite) = isremission(typeof(x), x)
isremission(x::AbstractComponent) = isremission(typeof(x), x)
