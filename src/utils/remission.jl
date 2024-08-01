"""
    isremission(x::DAS28ESR)

Check whether a DAS28ESR fulfils remission criteria (< 2.4).

# Examples

```jldoctest
julia> DAS28ESR(t28=4, s28=5, pga=44u"mm", apr=23u"mm/hr") |> isremission
false
```

    isremission(x::DAS28CRP)

Check whether a DAS28CRP fulfils remission criteria (< 2.6).

# Examples

```jldoctest
julia> DAS28CRP(t28=0, s28=1, pga=12u"mm", apr=9u"mg/L") |> isremission
true
```

    isremission(x::SDAI)

Check whether an SDAI fulfils remission criteria (<= 3.3).

# Examples

```jldoctest
julia> SDAI(t28=0, s28=0, pga=12u"mm", ega=8u"mm", crp=4u"mg/L") |> isremission
true
```

    isremission(x::BooleanRemission)

Check whether a BooleanRemission fulfils remission criteria (all T28, S28, PGA, CRP <= 1), where PGA is measured in cm and CRP measured in mg/dL.

See also [`revised`](@ref), [`threeitem`](@ref).

# Examples

```jldoctest
julia> BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl") |>
       isremission
false
julia> BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl") |>
       revised |>
       isremission
true
julia> BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl") |>
       threeitem |>
       isremission
true
```
"""
isremission(x::DAS28ESR) = score(x) < 2.6
isremission(x::DAS28CRP) = score(x) < 2.4

isremission(x::SDAI) = score(x) <= 3.3

isremission(x::PGA) = x.value <= 10.0u"mm"
isremission(x::SJC28) = x.value == 0

function isremission(x::BooleanRemission)
    return t28(x) <= 1 && s28(x) <= 1 && pga(x) <= 10.0u"mm" && crp(x) <= 1.0u"mg/dL"
end

function isremission(x::Revised{<:BooleanRemission})
    return t28(x) <= 1 && s28(x) <= 1 && pga(x) <= 20.0u"mm" && crp(x) <= 1.0u"mg/dL"
end

function isremission(x::ThreeItem{<:BooleanRemission})
    return t28(x) <= 1 && s28(x) <= 1 && crp(x) <= 1.0u"mg/dL"
end
