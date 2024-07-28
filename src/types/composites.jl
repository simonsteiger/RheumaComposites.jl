"""
   AbstractComposite

Abstract type that specifies the category of composites.

It is either [`ContinuousComposite`](@ref), [`BooleanComposite`](@ref), or [`ModifiedComposite`](@ref).
"""
abstract type AbstractComposite end

"""
    ContinuousComposite <: AbstractComposite

Abstract type that encompasses all composites whose score is a real number.

See also [`score`](@ref), [`BooleanComposite`](@ref).
"""
abstract type ContinuousComposite <: AbstractComposite end

# TODO implement ScoringScheme that allows `score` to be used on all composites?
# Would call isremission for BooleanComposites
"""
    BooleanComposite <: AbstractComposite

Abstract type that encompasses all composites who directly evaluate to a Boolean value.

See also [`score`](@ref), [`isremission`](@ref), [`ContinuousComposite`](@ref), [`ModifiedComposite`](@ref).
"""
abstract type BooleanComposite <: AbstractComposite end

"""
    ModifiedComposite <: AbstractComposite

Abstract type representing alterations to the behaviour of existing composites by, e.g., changing remission thresholds.

See also [`revised`](@ref), [`threeitem`](@ref), [`BooleanComposite`](@ref).
"""
abstract type ModifiedComposite <: AbstractComposite end

"Return the value of the 28 tender-joint count."
t28(x::AbstractComposite) = x.t28
t28(x::ModifiedComposite) = t28(x.c0)

"Return the value of the 28 swollen-joint count."
s28(x::AbstractComposite) = x.s28
s28(x::ModifiedComposite) = s28(x.c0)

"Return the value of the patient global assessment."
pga(x::AbstractComposite) = x.pga
pga(x::ModifiedComposite) = pga(x.c0)

"Return the value of the acute phase reactant."
apr(x::AbstractComposite) = x.apr
apr(x::ModifiedComposite) = apr(x.c0)

abstract type WeightingScheme end
struct IsUnweightable <: WeightingScheme end
struct IsUnweighted <: WeightingScheme end
struct IsWeighted <: WeightingScheme end

WeightingScheme(::Type) = IsUnweightable()

"Return the intercept of a ContinuousComposite."
intercept(x::ContinuousComposite) = 0.0

# FIXME this is currently not correctly exported it seems
Base.show(io::IO, x::AbstractComposite) = print(io, "$(nameof(typeof(x))) composite")

function Base.show(io::IO, ::MIME"text/plain", x::AbstractComposite)
    header = Term.@bold string(typeof(x))
    fields = map(fieldnames(typeof(x))) do component
        "$((uppercase ∘ string)(component)): $(getproperty(x, component))"
    end
    print(io, join([header, fields...], "\n  "))
end
