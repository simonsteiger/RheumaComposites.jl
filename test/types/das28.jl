# Dummy DAS28s for testing
das28e = DAS28ESR(t28=4, s28=5, pga=12u"mm", apr=44u"mm/hr")
das28c = DAS28CRP(t28=4, s28=5, pga=12u"mm", apr=44u"mg/L")

# Intercepts
i_das28e = RheumaComposites.intercept(das28e)
i_das28c = RheumaComposites.intercept(das28c)

# Test if different unit scales lead to same results
das28e_u1 = DAS28CRP(t28=0, s28=1, pga=10u"mm", apr=1u"mg/dL")
das28e_u2 = DAS28CRP(t28=0, s28=1, pga=1u"cm", apr=10u"mg/L")
das28c_u1 = DAS28CRP(t28=0, s28=1, pga=10u"mm", apr=1u"mg/dL")
das28c_u2 = DAS28CRP(t28=0, s28=1, pga=1u"cm", apr=10u"mg/L")

facets = (objective=[:s28, :apr], subjective=[:t28, :pga])

# A reference value for comparison
# calculated using https://www.4s-dawn.com/DAS28/
ref_value_esr = 4.56
ref_value_crp = 4.24

@testset "Construct DAS28ESR" begin
    @test das28e isa AbstractComposite
    @test das28e isa ContinuousComposite
    @test das28e isa DAS28
    @test das28e isa DAS28ESR
    @test t28(das28e) isa Real
    @test s28(das28e) isa Real
    @test pga(das28e) isa Unitful.AbstractQuantity
    @test apr(das28e) isa Unitful.AbstractQuantity
end

@testset "Score DAS28ESR" begin
    @test i_das28e == 0.0
    @test score(das28e) isa Float64
    @test score(das28e) ≈ i_das28e + sum(weight(das28e)) atol = 1e-3
    @test score(das28e) ≈ ref_value_esr atol = 1e-2
    @test score(das28e_u1) ≈ score(das28e_u2) atol = 1e-3
end

@testset "DAS28ESR Remission" begin
    @test !isremission(das28e)
    @test isremission(DAS28ESR(t28=0, s28=0, pga=8u"mm", apr=2u"mm/hr"))
    @test isremission(das28e_u1) == isremission(das28e_u2)
end

@testset "Faceted DAS28ESR" begin
    @test faceted(das28e, facets) isa ModifiedComposite
    @test faceted(das28e, facets) isa Faceted{<:ContinuousComposite}
    @test score(faceted(das28e, facets)) == score(das28e)
    @test sum(decompose(faceted(das28e, facets), digits=5)) ≈ 1.0 atol = 1e-5
end

@testset "Categorise DAS28ESR" begin
    @test categorise(das28e) == "Moderate"
    @test categorise.(DAS28ESR, [2.59, 2.61]) == ["Remission", "Low"]
    @test categorise.(DAS28ESR, [3.19, 3.21]) == ["Low", "Moderate"]
    @test categorise.(DAS28ESR, [5.09, 5.11]) == ["Moderate", "High"]
end

@testset "Construct DAS28CRP" begin
    @test das28c isa AbstractComposite
    @test das28c isa ContinuousComposite
    @test das28c isa DAS28
    @test das28c isa DAS28CRP
    @test t28(das28c) isa Real
    @test s28(das28c) isa Real
    @test pga(das28c) isa Unitful.AbstractQuantity
    @test apr(das28c) isa Unitful.AbstractQuantity
end

@testset "Score DAS28CRP" begin
    @test i_das28c == 0.96
    @test score(das28c) isa Float64
    @test score(das28c) ≈ i_das28c + sum(weight(das28c)) atol = 1e-3
    @test score(das28c) ≈ ref_value_crp atol = 1e-2
    @test score(das28c_u1) ≈ score(das28c_u2) atol = 1e-3
end

@testset "DAS28CRP remission" begin
    @test !isremission(das28c)
    @test isremission(DAS28CRP(t28=0, s28=0, pga=8u"mm", apr=2u"mg/L"))
    @test isremission(das28c_u1) == isremission(das28c_u2)
end

@testset "Faceted DAS28CRP" begin
    @test faceted(das28c, facets) isa ModifiedComposite
    @test faceted(das28c, facets) isa Faceted{<:ContinuousComposite}
    @test score(faceted(das28c, facets)) == score(das28c)
    @test sum(decompose(faceted(das28c, facets), digits=5)) ≈ 1.0 atol = 1e-5
end

@testset "Categorise DAS28CRP" begin
    @test categorise(das28c) == "Moderate"
    @test categorise.(DAS28CRP, [2.39, 2.51]) == ["Remission", "Low"]
    @test categorise.(DAS28CRP, [2.89, 2.91]) == ["Low", "Moderate"]
    @test categorise.(DAS28CRP, [4.59, 4.61]) == ["Moderate", "High"]
end
