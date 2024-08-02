"""
    isremission(x::AbstractComposite)

Check whether a composite fulfils remission criteria.

# Examples

```jldoctest
julia> DAS28ESR(t28=4, s28=5, pga=44u"mm", apr=23u"mm/hr") |> isremission
false
julia> BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl") |>
       revised |>
       isremission
true
```
"""
isremission(::Type{DAS28ESR}, x) = score(x) < 2.6
isremission(::Type{DAS28CRP}, x) = score(x) < 2.4

isremission(::Type{SDAI}, x) = score(x) <= 3.3
isremission(::Type{CDAI}, x) = score(x) <= 2.8

isremission(::Type{PGA}, x) = x.value <= 10.0u"mm"
isremission(::Type{SJC28}, x) = x.value == 0

function isremission(::Type{BooleanRemission}, x)
    return t28(x) <= 1 && s28(x) <= 1 && pga(x) <= 10.0u"mm" && crp(x) <= 1.0u"mg/dL"
end

function isremission(::Type{<:Revised{<:BooleanRemission}}, x)
    return t28(x) <= 1 && s28(x) <= 1 && pga(x) <= 20.0u"mm" && crp(x) <= 1.0u"mg/dL"
end

function isremission(::Type{<:ThreeItem{<:BooleanRemission}}, x)
    return t28(x) <= 1 && s28(x) <= 1 && crp(x) <= 1.0u"mg/dL"
end

isremission(x::AbstractComposite) = isremission(typeof(x), x)
isremission(x::AbstractComponent) = isremission(typeof(x), x)
