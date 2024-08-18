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
struct Revised{N,T} <: ModifiedComposite
    root::T
    offsets::NTuple{N,Float64}
end

WeightingScheme(::Type{<:Revised{T}}) where {T} = WeightingScheme(T)

function revised(root::BooleanComposite, offsets::NamedTuple; units=BREM_UNITS)
    unknown_offset = findfirst(∉(root.names), keys(offsets))
    if !(unknown_offset isa Nothing)
        throw(error("$(keys(offsets)[unknown_offset]) is not a component of `root`."))
    end

    uoffsets = unitfy(offsets, units; conversions=BREM_UNITS)
    vals = ustrip.(values(uoffsets))
    indexes = [findfirst(==(x), root.names) for x in keys(offsets)]
    offsets_w_zeros = zeros(length(root.components))
    offsets_w_zeros[indexes] .= vals
    
    return Revised(root, Tuple(offsets_w_zeros))
end

"""
    Partial{N,T}

Redefine a composite as a subset of its components.
"""
struct Partial{T} <: ModifiedComposite
    root::T
    indices::Vector{Int64}
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
    kept_idx = [findfirst(==(x), root.names) for x in keep]
    return Partial(root, kept_idx)
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
components(x::ModifiedComposite) = x.root.components

#=
"""
    components(x::Partial{N,<:BooleanComposite})

Return the components kept in the `Partial`.
"""
indices(x::Partial{<:BooleanComposite}) = x.indices
=#

"""
    offsets(x::Revised{<:BooleanComposite})

Return the offsets to remission thresholds.
"""
offsets(x::Revised{<:BooleanComposite}) = x.offsets

intercept(x::ModifiedComposite) = intercept(x.root)
