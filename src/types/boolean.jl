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
