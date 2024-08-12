# Destructure the properties of a NamedTuple into a Vector
function values_flatten(x::NamedTuple)
    property_vec = getproperty.(Ref(x), propertynames(x)) |>
                   Iterators.flatten |>
                   collect
    return property_vec
end
