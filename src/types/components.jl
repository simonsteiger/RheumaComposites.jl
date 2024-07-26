# These structs do not represent composites
# They are here for dispatch of `isremission`
# I don't think there's a point for using them inside the composites

abstract type AbstractComponent end

struct PGA <: AbstractComponent
    value::Unitful.AbstractQuantity
    function PGA(x)
        valid_vas(x)
        return new(x)
    end
end

struct SJC28 <: AbstractComponent
    value::Int64
    function SJC28(x)
        valid_joints(x)
        return new(x)
    end
end
