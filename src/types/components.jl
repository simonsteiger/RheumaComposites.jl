"""
    AbstractComponent

Abstract type for single-component outcomes.

See also [`isremission`](@ref), [`PGA`](@ref), [`SJC28`](@ref).
"""
abstract type AbstractComponent end

"""
    PGA <: AbstractComponent

This type represents the patient global assessment measured on the visual analogue scale.

See also [`value`](@ref), [`SJC28`](@ref), [`AbstractComponent`](@ref).
"""
struct PGA <: AbstractComponent
    value::Unitful.AbstractQuantity
    function PGA(x)
        valid_vas(x)
        return new(x)
    end
end

"""
    SJC28 <: AbstractComponent

This type represents the 28 swollen joints count.

See also [`value`](@ref), [`PGA`](@ref), [`AbstractComponent`](@ref).
"""
struct SJC28 <: AbstractComponent
    value::Int64
    function SJC28(x)
        valid_joints(x)
        return new(x)
    end
end

"Return the value stored in `x`."
value(x::AbstractComponent) = x.value
