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

"""
    BooleanComposite <: AbstractComposite

Abstract type that encompasses all composites who directly evaluate to a Boolean value.

See also [`score`](@ref), [`isremission`](@ref), [`ContinuousComposite`](@ref), [`ModifiedComposite`](@ref).
"""
abstract type BooleanComposite <: AbstractComposite end

"Return the 28 tender-joint count."
t28(x::AbstractComposite) = x.t28

"Return the 28 swollen-joint count."
s28(x::AbstractComposite) = x.s28

"Return the patient global assessment."
pga(x::AbstractComposite) = x.pga

"Return the acute phase reactant."
apr(x::AbstractComposite) = x.apr

abstract type WeightingScheme end
struct IsUnweightable <: WeightingScheme end
struct IsUnweighted <: WeightingScheme end
struct IsWeighted <: WeightingScheme end

WeightingScheme(::Type) = IsUnweightable()

"Return the intercept of a ContinuousComposite."
intercept(x::ContinuousComposite) = 0.0

Base.show(io::IO, x::AbstractComposite) = print(io, "$(nameof(typeof(x))) composite")

function Base.show(io::IO, ::MIME"text/plain", x::AbstractComposite)
    header = Term.@bold string(typeof(x))
    fields = map(fieldnames(typeof(x))) do component
        "$((uppercase ∘ string)(component)): $(getproperty(x, component))"
    end
    print(io, join([header, fields...], "\n  "))
end
