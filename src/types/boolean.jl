struct BooleanRemission <: BooleanComposite
    t28::Int64
    s28::Int64
    pga::Unitful.AbstractQuantity
    crp::Unitful.AbstractQuantity
    function BooleanRemission(; t28, s28, pga::Unitful.AbstractQuantity, crp::Unitful.AbstractQuantity)
        foreach([t28, s28]) do joints
            Base.isbetween(0, joints, 28) || throw(DomainError(joints, "only defined for 0 < joints < 28."))
        end
        Base.isbetween(0units.brem_vas, units.brem_vas(pga), 100units.brem_vas) || throw(DomainError(units.brem_vas(pga), "only defined for 0 mm < pga < 100 mm."))
        units.brem_crp(crp) >= 0units.brem_crp || throw(DomainError(units.brem_crp(crp), "CRP must be positive."))
        return new(t28, s28, pga, units.brem_crp(crp))
    end
end

struct Revised{T} <: ModifiedComposite
    c0::T
end

revised(c0::AbstractComposite) = Revised(c0)

struct ThreeItem{T} <: ModifiedComposite
    c0::T
end

threeitem(c0::BooleanRemission) = ThreeItem(c0)

crp(x::BooleanComposite) = x.crp
crp(x::ModifiedComposite) = crp(x.c0)
