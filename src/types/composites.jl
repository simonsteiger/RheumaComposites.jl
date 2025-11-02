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

abstract type WeightingScheme end
struct IsUnweightable <: WeightingScheme end
struct IsUnweighted <: WeightingScheme end
struct IsWeighted <: WeightingScheme end

WeightingScheme(::Type) = IsUnweightable()
WeightingScheme(::Type{<:ContinuousComposite}) = IsUnweighted()

"""
    intercept(x::ContinuousComposite)

Return the intercept.

This function can be useful if you want to implement custom decomposition or component reweighting.

See also [`score`](@ref), [`decompose`](@ref).
"""
intercept(x::ContinuousComposite) = 0.0

"""
    values(x::AbstractComposite)

Return the values stored in `x`.
"""
values(x::AbstractComposite) = x.values

"""
    uvalues(x::AbstractComposite)

Return the values stored in `x` in their units.
"""
function uvalues(x::AbstractComposite)
    return map(names(x), values(x)) do n, v
        hasproperty(units(x), n) ? v * getproperty(units(x), n) : v
    end
end

"""
    names(x::AbstractComposite)

Return the names of `x`'s values.
"""
names(x::AbstractComposite) = x.names

"""
    units(x::AbstractComposite)

Return the units of `x`'s values.
"""
units(x::AbstractComposite) = x.units

"""
    named_vals(x::AbstractComposite)

Return the values of `x` and their names in a NamedTuple.
"""
named_vals(x::AbstractComposite) = NamedTuple{names(x)}(values(x))

# Important for ModifiedComposites
root(x) = x

Base.show(io::IO, x::AbstractComposite) = print(io, "$(nameof(typeof(x))) composite")

function Base.show(io::IO, ::MIME"text/plain", x::AbstractComposite)
    header = Term.@bold string(typeof(x))
    fields = map(fieldnames(typeof(x))) do component
        "$((uppercase ∘ string)(component)): $(getproperty(x, component))"
    end
    print(io, join([header, fields...], "\n  "))
end

basdai_qs = [Symbol("q$x") => ContinuousComposite for x in 1:6]
accessor_dict = Dict(
    :tjc => AbstractComposite,
    :sjc => AbstractComposite,
    :pga => AbstractComposite,
    :crp => AbstractComposite,
    :ega => ContinuousComposite,
    :apr => ContinuousComposite,
    :jpn => ContinuousComposite,
    basdai_qs...
)

for (f, T) in accessor_dict
    docstring = """
        $f(x::$T)
    
    Return the component `$f` stored in `x`, if it exists.
    """
    @eval @doc $docstring function $(f)(x::$(QuoteNode(T)))
        var = $(QuoteNode(f))
        var ∉ names(x) && return error("`$var` is not a component of $(typeof(x))")
        i = findfirst(==(var), names(x))
        return only(getindex(uvalues(x), i))
    end
end
