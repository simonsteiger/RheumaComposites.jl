"""
    BooleanRemission(; t28, s28, pga, crp)

Store the components of the original ACR/EULAR Boolean remission.

See also [`isremission`](@ref), [`revised`](@ref), [`threeitem`](@reg).
"""
struct BooleanRemission <: BooleanComposite
    t28::Int64
    s28::Int64
    pga::Unitful.AbstractQuantity
    crp::Unitful.AbstractQuantity
    function BooleanRemission(; t28, s28, pga::Unitful.AbstractQuantity, crp::Unitful.AbstractQuantity)
        valid_joints.([t28, s28])
        valid_vas(pga)
        valid_apr(crp)
        return new(t28, s28, pga, uconvert(units.brem_crp, crp))
    end
end

"""
    Revised{T} <: ModifiedComposite

This type indicates that the stored composite's threshold for remission has been revised.

See also [`ModifiedComposite`](@ref), [`BooleanRemission`](@ref).
"""
struct Revised{T} <: ModifiedComposite
    c0::T
end

"""
    revised(c0::AbstractComposite)

Change the calculation of scores or thresholds to use the revised definition of a composite.

See also [`isremission`](@ref), [`BooleanRemission`](@ref), [`ModifiedComposite`](@ref).

# Examples

```jldoctest
julia> boolrem = BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl");
julia> isremission(bool_rem)
false
julia> isremission(revised(boolrem))
true
```
"""
revised(c0::AbstractComposite) = Revised(c0)

"""
    ThreeItem{T} <: ModifiedComposite

This type indicates that the stored composite no longer considers all of its components.
Instead, remission is now defined based on a three item subset.
"""
struct ThreeItem{T} <: ModifiedComposite
    c0::T
end

"""
    threeitem(c0::BooleanRemission)

Change the calculation of Boolean remission to exclude patient global assessment.

See also [`isremission`](@ref), [`BooleanRemission`](@ref), [`ModifiedComposite`](@ref).

# Examples

```jldoctest
julia> boolrem = BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl");
julia> isremission(boolrem)
false
julia> isremission(threeitem(boolrem))
true
```
"""
threeitem(c0::BooleanRemission) = ThreeItem(c0)

"Return the CRP value."
crp(x::BooleanComposite) = x.crp
crp(x::ModifiedComposite) = crp(x.c0)
