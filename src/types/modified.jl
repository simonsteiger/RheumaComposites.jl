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

WeightingScheme(::Type{<:Faceted{T}}) where {T} = WeightingScheme(T)

"""
    faceted(root::ContinuousComposite, facets::NamedTuple)

Specify a custom grouping along which the composite can be analysed.

See also [`decompose`](@ref).
"""
function faceted(root::ContinuousComposite, facets::NamedTuple)
    faceted_composites = values_flatten(facets)
    if any(f -> f ∉ root.names, faceted_composites)
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
    offsets::Vector{Float64}
end

WeightingScheme(::Type{<:Revised{T}}) where {T} = WeightingScheme(T)

"""
    Partial{T}

Redefine a composite as a subset of its components.
"""
struct Partial{N,T} <: ModifiedComposite
    root::T
    names::NTuple{N,Symbol}
    values::NTuple{N,Float64}
end

WeightingScheme(::Type{<:Partial{T}}) where {T} = WeightingScheme(T)

"""
    partial(root::AbstractComposite, keep::Vector{Symbol})

Redefine a composite as a subset of its components.

Functions like [`score`](@ref) or [`isremission`](@ref) act on the subset of components.
"""
function partial(root::AbstractComposite, keep::Vector{Symbol})
    unique(keep) == keep || throw(error("`keep` must contain unique values"))
    all(d -> d in root.names, keep) || throw(error("can only keep `root` components"))
    idx = [findfirst(==(x), root.names) for x in keep]
    kept_values = getindex(values(root), idx)
    return Partial(root, Tuple(keep), kept_values)
end

"""
    root(x::ModifiedComposite)

Return the unmodified composite.
"""
root(x::ModifiedComposite) = x.root

"""
    values(x::ModifiedComposite)
    
Return the values of the unmodified composite, i.e., `x.root.values`.
"""
values(x::ModifiedComposite) = x.root.values

"""
    values(x::Partial{N,<:BooleanComposite})

Return the values kept by `x`.
"""
values(x::Partial{N,<:BooleanComposite}) where {N} = x.values

"""
    offsets(x::Revised{<:BooleanComposite})

Return the offsets to remission thresholds.
"""
offsets(x::Revised{<:BooleanComposite}) = x.offsets

intercept(x::ModifiedComposite) = intercept(x.root)
