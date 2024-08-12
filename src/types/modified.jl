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
    faceted_composites = values_flatten(facets)
    if any(f -> f ∉ components(root), faceted_composites)
        throw(error("can only facet `root` components"))
    end
    if faceted_composites != unique(faceted_composites)
        throw(error("`facets` must contain unique composites"))
    end
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

function revised(root::BooleanComposite, offset::NamedTuple)
    if any(o -> o ∉ components(root), propertynames(offset))
        throw(error("can only revise `root` components"))
    end
    return Revised(root, offset)
end

"""
    Subset{N,T}

Redefine a composite as a subset of its components.
"""
struct Subset{N,T} <: ModifiedComposite
    root::T
    components::NTuple{N,Symbol}
end

"""
    subset(root::AbstractComposite, keep::Vector{Symbol})

Redefine a composite as a subset of its components.

Functions like [`score`](@ref) or [`isremission`](@ref) act on the subset of components.
"""
function subset(root::AbstractComposite, keep::Vector{Symbol})
    cns = components(root)
    unique(keep) == keep || throw(error("`keep` must contain unique values"))
    all(d -> d in cns, keep) || throw(error("can only keep `root` components"))
    kept_cns = filter(x -> x in keep, cns)
    return Subset(root, kept_cns)
end

"""
    root(x::ModifiedComposite)

Return the unmodified composite.
"""
root(x::ModifiedComposite) = x.root

"""
    components(x::ModifiedComposite)
    
Return the components of the unmodified composite.
"""
components(x::ModifiedComposite) = components(x.root)

"""
    components(x::Subset{N,<:BooleanComposite})

Return the components kept in the `Subset`.
"""
components(x::Subset{N,<:BooleanComposite}) where {N} = x.components

"""
    offset(x::Revised{<:BooleanComposite})

Return the offsets to remission thresholds.
"""
offset(x::Revised{<:BooleanComposite}) = x.offset

intercept(x::ModifiedComposite) = intercept(x.root)

tjc(x::ModifiedComposite) = tjc(x.root)

sjc(x::ModifiedComposite) = sjc(x.root)

pga(x::ModifiedComposite) = pga(x.root)

ega(x::ModifiedComposite) = ega(x.root)

apr(x::ModifiedComposite) = apr(x.root)

crp(x::ModifiedComposite) = crp(x.root)
