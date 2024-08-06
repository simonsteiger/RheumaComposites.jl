"""
   AbstractComposite

Abstract type that specifies the category of composites.

It is either [`ContinuousComposite`](@ref), [`BooleanComposite`](@ref), or [`ModifiedComposite`](@ref).
"""
abstract type AbstractComposite end

"""
    ContinuousComposite <: AbstractComposite

Abstract type for composites whose scores are floating point numbers.

See also [`score`](@ref), [`BooleanComposite`](@ref).
"""
abstract type ContinuousComposite <: AbstractComposite end

"""
    BooleanComposite <: AbstractComposite

Abstract type for composites only implementing a definition of remission.

See also [`isremission`](@ref), [`ContinuousComposite`](@ref).
"""
abstract type BooleanComposite <: AbstractComposite end

"Return the 28 tender-joint count."
tjc(x::AbstractComposite) = x.tjc

"Return the 28 swollen-joint count."
sjc(x::AbstractComposite) = x.sjc

"Return the patient global assessment."
pga(x::AbstractComposite) = x.pga

"Return the acute phase reactant."
apr(x::AbstractComposite) = x.apr

abstract type WeightingScheme end
struct IsUnweightable <: WeightingScheme end
struct IsUnweighted <: WeightingScheme end
struct IsWeighted <: WeightingScheme end

WeightingScheme(::Type) = IsUnweightable()

"""
    intercept(x::ContinuousComposite)

Return the intercept.

This function can be useful if you want to implement custom decomposition or component reweighting.

See also [`score`](@ref), [`decompose`](@ref).
"""
intercept(x::ContinuousComposite) = 0.0

Base.show(io::IO, x::AbstractComposite) = print(io, "$(nameof(typeof(x))) composite")

function Base.show(io::IO, ::MIME"text/plain", x::AbstractComposite)
    header = Term.@bold string(typeof(x))
    fields = map(fieldnames(typeof(x))) do component
        "$((uppercase ∘ string)(component)): $(getproperty(x, component))"
    end
    print(io, join([header, fields...], "\n  "))
end
