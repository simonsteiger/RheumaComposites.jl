"""
    DAS28 <: ContinuousComposite

Abstract type for DAS28 subtypes.

See also [`DAS28ESR`](@ref), [`DAS28CRP`](@ref).
"""
abstract type DAS28 <: ContinuousComposite end

WeightingScheme(::Type{<:DAS28}) = IsWeighted()

# TODO add weighting formula to docstring
"""
    DAS28CRP(; t28, s28, pga, apr)

Store the component measures of the DAS28CRP.

# Components

- `t28` 28 tender joint count
- `s28` 28 swollen joint count
- `pga` patient's global assessment
- `apr` active phase reactant, here CRP

!!! warning "Units"
    Currently, `pga` must be a length (typically millimeters or centimeters) and `crp` must be a concentration (typically mg/dL or mg/L).
    See also [`Unitful.@u_str`](@extref).

# External links

* [The DAS28 calculator](https://www.4s-dawn.com/DAS28/)

See also [`score`](@ref), [`isremission`](@ref), [`DAS28`](@ref).
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

# Components

- `t28` 28 tender joint count
- `s28` 28 swollen joint count
- `pga` patient's global assessment
- `apr` active phase reactant, here ESR

!!! warning "Units"
    Currently, `pga` must be a length (typically millimeters or centimeters) and `apr` must be a rate (typically mm/hr).
    See also [`Unitful.@u_str`](@extref).

# External links

- DAS28 calculator [https://www.4s-dawn.com/DAS28/](https://www.4s-dawn.com/DAS28/)

See also [`score`](@ref), [`isremission`](@ref), [`DAS28`](@ref).
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
