# Destructure properties of a NamedTuple into a Vector
function values_flatten(x::NamedTuple)
    property_vec = getproperty.(Ref(x), propertynames(x)) |>
                   Iterators.flatten |>
                   collect
    return property_vec
end

_typename(x::DataType) = Symbol(split(string(nameof(x)), ".")[end])

function seq_check(x::Real, conds::NamedTuple)
    funs = values(conds)
    i = 1
    for fun in funs
        fun(x) && break
        i += 1
    end
    return string(keys(conds)[i])
end

function unitfy(vals, conversions) # TODO add validation here?
    out = map(keys(vals), values(vals)) do k, v
        v isa Real && return v
        conversion = getproperty(conversions, k)
        return uconvert(conversion, v)
    end
    return out
end

#=
function seq_check(x::BooleanComposite, conds::NamedTuple)
    funs = values(conds)
    for fun in funs
        fun(x) || return false
    end
    return true
end
=#
