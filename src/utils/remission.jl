isremission(x::DAS28ESR) = score(x) < 2.6
isremission(x::DAS28CRP) = score(x) < 2.4
isremission(x::SDAI) = score(x) < 3.3
