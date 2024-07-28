# Dummy DAS28s for testing
d28e = DAS28ESR(t28=4, s28=5, pga=12u"mm", apr=44u"mm/hr")
d28c = DAS28CRP(t28=4, s28=5, pga=12u"mm", apr=44u"mg/L")

# Intercepts
i_das28e = RheumaComposites.intercept(d28e)
i_das28c = RheumaComposites.intercept(d28c)

# Test if different unit scales lead to same results
das28e_u1 = DAS28CRP(t28=0, s28=1, pga=10u"mm", apr=1u"mg/dL")
das28e_u2 = DAS28CRP(t28=0, s28=1, pga=1u"cm", apr=10u"mg/L")
das28c_u1 = DAS28CRP(t28=0, s28=1, pga=10u"mm", apr=1u"mg/dL")
das28c_u2 = DAS28CRP(t28=0, s28=1, pga=1u"cm", apr=10u"mg/L")

# A reference value for comparison
# calculated using https://www.4s-dawn.com/DAS28/
ref_value_esr = 4.56
ref_value_crp = 4.24

@testset "Construct DAS28ESR" begin
    @test d28e isa AbstractComposite
    @test d28e isa ContinuousComposite
    @test d28e isa DAS28
    @test d28e isa DAS28ESR
    @test t28(d28e) isa Real
    @test s28(d28e) isa Real
    @test pga(d28e) isa Unitful.AbstractQuantity
    @test apr(d28e) isa Unitful.AbstractQuantity
end

@testset "Score DAS28ESR" begin
    @test i_das28e == 0.0
    @test score(d28e) isa Float64
    @test score(d28e) ≈ i_das28e + sum(weight(d28e)) atol = 1e-3
    @test score(d28e) ≈ ref_value_esr atol = 1e-2
    @test score(das28e_u1) ≈ score(das28e_u2) atol = 1e-3
end

@testset "DAS28ESR Remission" begin
    @test !isremission(d28e)
    @test isremission(DAS28ESR(t28=0, s28=0, pga=8u"mm", apr=2u"mm/hr"))
    @test isremission(das28e_u1) == isremission(das28e_u2)
end

@testset "Construct DAS28CRP" begin
    @test d28c isa AbstractComposite
    @test d28c isa ContinuousComposite
    @test d28c isa DAS28
    @test d28c isa DAS28CRP
    @test t28(d28c) isa Real
    @test s28(d28c) isa Real
    @test pga(d28c) isa Unitful.AbstractQuantity
    @test apr(d28c) isa Unitful.AbstractQuantity
end

@testset "Score DAS28CRP" begin
    @test i_das28c == 0.96
    @test score(d28c) isa Float64
    @test score(d28c) ≈ i_das28c + sum(weight(d28c)) atol = 1e-3
    @test score(d28c) ≈ ref_value_crp atol = 1e-2
    @test score(das28c_u1) ≈ score(das28c_u2) atol = 1e-3
end

@testset "DAS28CRP remission" begin
    @test !isremission(d28c)
    @test isremission(DAS28CRP(t28=0, s28=0, pga=8u"mm", apr=2u"mg/L"))
    @test isremission(das28c_u1) == isremission(das28c_u2)
end
