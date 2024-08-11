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

# TODO rename bool_cutoff into something that reflects that it contains functions
_check(component, x) = getproperty(bool_cutoff, component)(x)

# This will be for Revised, mapreduce over two collections then
# one for compos and one for adjustments to cutoffs
# the adjustments should be stored in a tuple like that in Subset
_check(component, x, offset) = getproperty(bool_cutoff, component)(x; offset=offset)

function isremission(::Type{BooleanRemission}, x)
    return mapreduce(compo -> _check(compo, x), &, components(x))
end

function isremission(::Type{Subset{BooleanRemission}}, x)
    return mapreduce(compo -> _check(compo, root(x)), &, components(x))
end

function isremission(::Type{<:Revised{<:BooleanRemission}}, x)
    return tjc(x) <= 1 && sjc(x) <= 1 && pga(x) <= 20.0u"mm" && crp(x) <= 1.0u"mg/dL"
end

isremission(x::AbstractComposite) = isremission(typeof(x), x)
isremission(x::AbstractComponent) = isremission(typeof(x), x)
