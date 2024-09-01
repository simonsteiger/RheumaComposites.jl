# Check if joint count is valid
function valid_joints(x; max=28)
    Base.isbetween(0, x, max) ||
        throw(DomainError(x, "joints must be between 0 and $max."))
end

# Check if VAS value is valid
function valid_vas(x::Unitful.AbstractQuantity)
    v = (ustrip ∘ uconvert)(u"cm", x)
    0 <= v && v <= 10 || throw(DomainError(x, "VAS must be between 0 cm and 10 cm."))
end

function valid_vas(x::Real)
    throw(error("VAS must be a length. Forgot to convert? See Unitful.@u_str"))
end

# Check if APR value is valid
function valid_apr(x::Unitful.AbstractQuantity, min=0)
    ustrip(x) >= min || throw(DomainError("Invalid APR"))
end

function valid_apr(x::Real, min) 
    throw(error("APR must be a concentration. Forgot to convert? See Unitful.@u_str"))
end
