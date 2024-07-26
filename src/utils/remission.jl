isremission(x::DAS28ESR) = score(x) < 2.6
isremission(x::DAS28CRP) = score(x) < 2.4
isremission(x::SDAI) = score(x) <= 3.3

isremission(x::PGA) = x.value <= 10.0u"mm"
isremission(x::SJC28) = x.value == 0

function isremission(x::BooleanRemission)
    return t28(x) <= 1 && s28(x) <= 1 && pga(x) <= 10.0u"mm" && crp(x) <= 1.0u"mg/dL"
end

function isremission(x::Revised{<:BooleanRemission})
    return t28(x) <= 1 && s28(x) <= 1 && pga(x) <= 20.0u"mm" && crp(x) <= 1.0u"mg/dL"
end

function isremission(x::ThreeItem{<:BooleanRemission})
    return t28(x) <= 1 && s28(x) <= 1 && crp(x) <= 1.0u"mg/dL"
end
