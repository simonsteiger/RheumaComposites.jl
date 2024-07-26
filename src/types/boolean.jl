struct BooleanRemission <: BooleanComposite
    t28::Int64
    s28::Int64
    pga::Float64
    crp::Float64
    function BooleanRemission(; t28, s28, pga, crp)
        foreach([t28, s28]) do joints
            Base.isbetween(0, joints, 28) || throw(DomainError(joints, "only defined for 0 < joints < 28."))
        end
        Base.isbetween(0, pga, 100) || throw(DomainError(pga, "VAS global must be between 0 and 100."))
        crp >= 0 || throw(DomainError(crp, "CRP must be positive."))
        return new(t28, s28, pga, crp)
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
