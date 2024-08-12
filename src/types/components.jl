# TODO make these special cases of Subset, too

"""
    AbstractComponent

Abstract type for single-component outcomes.

See also [`isremission`](@ref), [`PGA`](@ref), [`SJC`](@ref).
"""
abstract type AbstractComponent end

"""
    PGA <: AbstractComponent

This type represents the patient global assessment measured on the visual analogue scale.

See also [`value`](@ref), [`SJC`](@ref), [`AbstractComponent`](@ref).
"""
struct PGA <: AbstractComponent
    value::Unitful.AbstractQuantity
    function PGA(x)
        valid_vas(x)
        return new(x)
    end
end

"""
    SJC <: AbstractComponent

This type represents the 28 swollen joints count.

See also [`value`](@ref), [`PGA`](@ref), [`AbstractComponent`](@ref).
"""
struct SJC <: AbstractComponent
    value::Int64
    function SJC(x)
        valid_joints(x)
        return new(x)
    end
end

"Return the value stored in `x`."
value(x::AbstractComponent) = x.value
