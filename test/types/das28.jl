# Dummy DAS28s for testing
das28e = DAS28ESR(tjc=4, sjc=5, pga=12, apr=44)
das28c = DAS28CRP(tjc=4, sjc=5, pga=12, apr=44)

# Intercepts
i_das28e = RheumaComposites.intercept(das28e)
i_das28c = RheumaComposites.intercept(das28c)

alt_units_c = (pga=u"cm", apr=u"mg/dL")
alt_units_e = (pga=u"cm", apr=u"cm/hr")

# Test if different unit scales lead to same results
das28e_u1 = DAS28ESR(tjc=0, sjc=1, pga=1, apr=1, units=alt_units_e)
das28e_u2 = DAS28ESR(tjc=0, sjc=1, pga=10, apr=10)
das28c_u1 = DAS28CRP(tjc=0, sjc=1, pga=1, apr=1, units=alt_units_c)
das28c_u2 = DAS28CRP(tjc=0, sjc=1, pga=10, apr=10)

facets = (objective=[:sjc, :apr], subjective=[:tjc, :pga])

# A reference value for comparison
# calculated using https://www.4s-dawn.com/DAS28/
ref_value_esr = 4.56
ref_value_crp = 4.24

@testset "Construct DAS28ESR" begin
    @test das28e isa AbstractComposite
    @test das28e isa ContinuousComposite
    @test das28e isa DAS28
    @test das28e isa DAS28ESR
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
    @test isremission(DAS28ESR(tjc=0, sjc=0, pga=8, apr=2))
    @test isremission(das28e_u1) == isremission(das28e_u2)
end

@testset "Faceted DAS28ESR" begin
    @test faceted(das28e, facets) isa ModifiedComposite
    @test faceted(das28e, facets) isa Faceted{<:ContinuousComposite}
    @test score(faceted(das28e, facets)) == score(das28e)
    @test sum(values(decompose(faceted(das28e, facets), digits=5))) ≈ 1.0 atol = 1e-5
    @test decompose(faceted(DAS28ESR(tjc=1, sjc=0, pga=0, apr=1), facets))[:subjective] == 1
    @test decompose(faceted(DAS28ESR(tjc=0, sjc=1, pga=0, apr=1), facets))[:objective] == 1
end

@testset "Categorise DAS28ESR" begin
    @test categorise(das28e) == "moderate"
    @test categorise.(DAS28ESR, [2.59, 2.61]) == ["remission", "low"]
    @test categorise.(DAS28ESR, [3.19, 3.21]) == ["low", "moderate"]
    @test categorise.(DAS28ESR, [5.09, 5.11]) == ["moderate", "high"]
end

@testset "Decompose DAS28ESR" begin
    @test sum(values(decompose(das28e, digits=5))) ≈ 1.0 atol = 1e-5
end

@testset "Construct DAS28CRP" begin
    @test das28c isa AbstractComposite
    @test das28c isa ContinuousComposite
    @test das28c isa DAS28
    @test das28c isa DAS28CRP
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
    @test isremission(DAS28CRP(tjc=0, sjc=0, pga=8, apr=2))
    @test isremission(das28c_u1) == isremission(das28c_u2)
end

@testset "Decompose DAS28CRP" begin
    @test sum(values(decompose(das28c, digits=5))) ≈ 1.0 atol = 1e-5
end

@testset "Faceted DAS28CRP" begin
    @test faceted(das28c, facets) isa ModifiedComposite
    @test faceted(das28c, facets) isa Faceted{<:ContinuousComposite}
    @test score(faceted(das28c, facets)) == score(das28c)
    @test sum(values(decompose(faceted(das28c, facets), digits=5))) ≈ 1.0 atol = 1e-5
    @test try
        faceted(das28c, (abc=[:tjc, :pga], cde=[:tjc, :apr]))
    catch e
        e isa ErrorException
    end
end

@testset "Categorise DAS28CRP" begin
    @test categorise(das28c) == "moderate"
    @test categorise.(DAS28CRP, [2.39, 2.51]) == ["remission", "low"]
    @test categorise.(DAS28CRP, [2.89, 2.91]) == ["low", "moderate"]
    @test categorise.(DAS28CRP, [4.59, 4.61]) == ["moderate", "high"]
end

xx = DAS28ESR(tjc=1, sjc=0, pga=0, apr=1)

decompose(faceted(xx, facets))

# FIXME This should not return 0.56 for TJC weight
weight(xx)

decompose(xx)
