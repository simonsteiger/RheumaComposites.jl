# Check if joint count is valid
function valid_joints(x)
    Base.isbetween(0, x, 28) ||
        throw(DomainError(x, "must be 0 < joints < 28."))
end

# Check if VAS value is valid
function valid_vas(x)
    Base.isbetween(0u"cm", uconvert(u"cm", x), 10u"cm") ||
        throw(DomainError(x, "must be 0 cm < VAS < 10 cm."))
end

# Check if APR value is valid
valid_apr(x) = 0 <= ustrip(x)
