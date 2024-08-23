# Check if joint count is valid
function valid_joints(x; max=28)
    Base.isbetween(0, x, max) ||
        throw(DomainError(x, "joints must be between 0 and $max."))
end

# Check if VAS value is valid
function valid_vas(x)
    Base.isbetween(0u"cm", uconvert(u"cm", x), 10u"cm") ||
        throw(DomainError(x, "VAS must be between 0 cm and 10 cm."))
end

# Check if APR value is valid
valid_apr(x) = ustrip(x) >= 0 || throw(error("Invalid APR"))
valid_apr(x, min) = ustrip(x) >= min || throw(error("Invalid APR"))
