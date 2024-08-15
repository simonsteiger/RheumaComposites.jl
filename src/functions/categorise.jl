"""
    categorise(::Type{T}, s::Real) where {T<:ContinuousComposite}

Convert score `s` to a discrete value using `SDAI` thresholds.

The same functionality exists for other `ContinuousComposites`.

# Examples

```jldoctest
julia> categorise(SDAI, 3.6)
"low"
```
"""
function categorise(::Type{T}, s::Real) where {T<:ContinuousComposite}
    return seq_check(s, getproperty(cont_cutoff_funs, Symbol(T)))
end
# This implementation is roughly half as 2.5 times slower than hard coding
# cutoffs into each categorise function
# If performance is ever critical, I should change to the more verbose but faster version

"""
    categorise(x::ContinuousComposite)

Convert `x` to a discrete value.

# Examples

```jldoctest
julia> DAS28ESR(tjc=4, sjc=5, pga=12u"mm", apr=44u"mm/hr") |> categorise
"moderate"
```
"""
categorise(x::ContinuousComposite) = categorise(typeof(x), score(x))

"""
    categorise(x::Faceted{<:ContinuousComposite})

Convert the `root` composite of `x` to a discrete value.
"""
categorise(x::Faceted{<:ContinuousComposite}) = categorise(typeof(x.root), score(x.root))
