"""
    ModifiedComposite <: AbstractComposite

Abstract type representing alterations to the behaviour of existing composites by, e.g., changing remission thresholds.
"""
abstract type ModifiedComposite <: AbstractComposite end

"""
    Faceted{T} <: ModifiedComposite

This type indicates a further grouping of the stored composite's components.
"""
struct Faceted{T} <: ModifiedComposite
    c0::T
    facets::NamedTuple
end

"""
    faceted(c0::ContinuousComposite, facets::NamedTuple)

Specify a custom grouping along which the composite can be analysed.

See also [`decompose`](@ref).
"""
function faceted(c0::ContinuousComposite, facets::NamedTuple)
    faceted_fields = getproperty.(Ref(facets), propertynames(facets)) |>
                     Iterators.flatten |>
                     collect
    all(field -> field in fieldnames(typeof(c0)), faceted_fields) ||
        throw(ErrorException("all values in `facets` must be fields of `c0`"))
    return Faceted(c0, facets)
end

"""
    Revised{T} <: ModifiedComposite

This type indicates that the stored composite's threshold for remission has been revised.

See also [`BooleanRemission`](@ref).
"""
struct Revised{T} <: ModifiedComposite
    c0::T
end

"""
    revised(c0::AbstractComposite)

Change the calculation of scores or thresholds to use the revised definition of a composite.

# Examples

```jldoctest
julia> boolrem = BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl");
julia> isremission(bool_rem)
false
julia> isremission(revised(boolrem))
true
```

See also [`isremission`](@ref), [`BooleanRemission`](@ref).
"""
revised(c0::AbstractComposite) = Revised(c0)

"""
    ThreeItem{T} <: ModifiedComposite

This type indicates that the stored composite no longer considers all of its components.
Instead, remission is now defined based on a three item subset.
"""
struct ThreeItem{T} <: ModifiedComposite
    c0::T
end

"""
    threeitem(c0::BooleanRemission)

Change the calculation of Boolean remission to exclude patient global assessment.

# Examples

```jldoctest
julia> boolrem = BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl");
julia> isremission(boolrem)
false
julia> isremission(threeitem(boolrem))
true
```

See also [`isremission`](@ref), [`BooleanRemission`](@ref).
"""
threeitem(c0::BooleanRemission) = ThreeItem(c0)

t28(x::ModifiedComposite) = t28(x.c0)
s28(x::ModifiedComposite) = s28(x.c0)
pga(x::ModifiedComposite) = pga(x.c0)
ega(x::ModifiedComposite) = ega(x.c0)
apr(x::ModifiedComposite) = apr(x.c0)
crp(x::ModifiedComposite) = crp(x.c0)
