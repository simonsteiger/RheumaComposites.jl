"""
    ModifiedComposite <: AbstractComposite

Abstract type representing alterations to existing composites.

See also [`faceted`](@ref), [`revised`](@ref), [`threeitem`](@ref).
"""
abstract type ModifiedComposite <: AbstractComposite end

"""
    Faceted{T} <: ModifiedComposite

This type indicates a further grouping of the stored composite's components.
"""
struct Faceted{T} <: ModifiedComposite
    root::T
    facets::NamedTuple
end

"""
    faceted(root::ContinuousComposite, facets::NamedTuple)

Specify a custom grouping along which the composite can be analysed.

See also [`decompose`](@ref).
"""
function faceted(root::ContinuousComposite, facets::NamedTuple)
    compos = components(root)
    facet_compos = getproperty.(Ref(facets), propertynames(facets)) |>
                   Iterators.flatten |>
                   collect
    all(f -> f in compos, facet_compos) || throw(error("can only facet `root` components"))
    return Faceted(root, facets)
end

"""
    Revised{T} <: ModifiedComposite

This type indicates that the stored composite's threshold for remission has been revised.

See also [`BooleanRemission`](@ref).
"""
struct Revised{T} <: ModifiedComposite
    root::T
    offset::NamedTuple
end

"""
    revised(root::AbstractComposite)

Change the calculation of scores or thresholds to use the revised definition of a composite.

Currently, revised versions are implemented only for [`BooleanRemission`](@ref).

See also [`isremission`](@ref).
"""
revised(root::BooleanComposite, offset) = Revised(root, offset)

struct Subset{N,T} <: ModifiedComposite
    root::T
    components::NTuple{N,Symbol}
end

function subset(root::AbstractComposite, keep::Vector{Symbol})
    compos = components(root)
    all(d -> d in compos, keep) || throw(error("can only keep `root` components"))
    kept_compos = filter(x -> x in keep, compos)
    return Subset(root, kept_compos)
end

root(x::ModifiedComposite) = x.root

components(x::ModifiedComposite) = components(x.root)
components(x::Subset{N,<:BooleanComposite}) where {N} = x.components

offset(x::Revised{<:BooleanComposite}) = x.offset

intercept(x::ModifiedComposite) = intercept(x.root)

tjc(x::ModifiedComposite) = tjc(x.root)

sjc(x::ModifiedComposite) = sjc(x.root)

pga(x::ModifiedComposite) = pga(x.root)

ega(x::ModifiedComposite) = ega(x.root)

apr(x::ModifiedComposite) = apr(x.root)

crp(x::ModifiedComposite) = crp(x.root)
