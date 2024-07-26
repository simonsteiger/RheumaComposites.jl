# These structs do not represent composites
# They are here for dispatch of `isremission`
# I don't think there's a point for using them inside the composites

abstract type AbstractComponent end

struct PGA <: AbstractComponent
    value::Float64
    function PGA(x)
        Base.isbetween(0, x, 100) || throw(DomainError(x, "VAS global must be between 0 and 100."))
        return new(x)
    end
end

struct SJC28 <: AbstractComponent
    value::Int64
    function SJC28(x)
        Base.isbetween(0, x, 28) || throw(DomainError(x, "only defined for 0 < joints < 28."))
        return new(x)
    end
end
