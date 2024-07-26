isremission(x::DAS28ESR) = score(x) < 2.6
isremission(x::DAS28CRP) = score(x) < 2.4
isremission(x::SDAI) = score(x) <= 3.3
isremission(x::PGA) = x.value <= 10.0
isremission(x::SJC28) = x.value == 0
