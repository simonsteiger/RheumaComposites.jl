abstract type DAS28 <: ContinuousComposite end

WeightingScheme(::Type{<:DAS28}) = IsWeighted()

# TODO add weighting formula to docstring
"""
    DAS28CRP(; t28, s28, pga, apr)

Store the component measures of the DAS28CRP.

See also [`score`](@ref), [`isremission`](@ref), [`DAS28ESR`](@ref).

# Example

```jldoctest
julia> DAS28CRP(t28=4, s28=5, pga=12u"mm", apr=44u"mg/L")
DAS28CRP
[...]
```

# External links

* [The DAS28 calculator](https://www.4s-dawn.com/DAS28/)
"""
struct DAS28CRP <: DAS28
    t28::Int64
    s28::Int64
    pga::Unitful.AbstractQuantity
    apr::Unitful.AbstractQuantity
    function DAS28CRP(;
        t28,
        s28,
        pga::Unitful.AbstractQuantity,
        apr::Unitful.AbstractQuantity,
    )
        valid_joints.([t28, s28])
        valid_vas(pga)
        valid_apr(apr)
        
        # Must convert because weights do not adjust to measurement
        return new(
            t28,
            s28,
            uconvert(units.das28_vas, pga),
            uconvert(units.das28_crp, apr)
        )
    end
end

"""
    DAS28ESR(; t28, s28, pga, apr)

Store the component measures of the DAS28ESR.

See also [`score`](@ref), [`isremission`](@ref), [`DAS28ESR`](@ref).

# Example

```jldoctest
julia> DAS28ESR(t28=4, s28=5, pga=12u"mm", apr=44u"mg/L")
DAS28ESR
[...]
```

# External links

- DAS28 calculator [https://www.4s-dawn.com/DAS28/](https://www.4s-dawn.com/DAS28/)
"""
struct DAS28ESR <: DAS28
    t28::Int64
    s28::Int64
    pga::Unitful.AbstractQuantity
    apr::Unitful.AbstractQuantity
    function DAS28ESR(;
        t28,
        s28,
        pga::Unitful.AbstractQuantity,
        apr::Unitful.AbstractQuantity,
    )
        valid_joints.([t28, s28])
        valid_vas(pga)
        valid_apr(apr)
        return new(
            t28,
            s28,
            uconvert(units.das28_vas, pga),
            uconvert(units.das28_esr, apr)
        )
    end
end

intercept(x::DAS28CRP) = 0.96
