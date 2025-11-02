# Destructure properties of a NamedTuple into a Vector
function values_flatten(x::NamedTuple)
    property_vec = getproperty.(Ref(x), propertynames(x)) |>
                   Iterators.flatten |>
                   collect
    return property_vec
end

function unitfy(vals, conversions) # TODO add validation here?
    out = map(keys(vals), values(vals)) do k, v
        v isa Real && return v
        conversion = getproperty(conversions, k)
        return uconvert(conversion, v)
    end
    return out
end
