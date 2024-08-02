# Dummy CDAIs for testing
cdai = CDAI(t28=1, s28=0, pga=1u"cm", ega=0u"cm")
cdai_ref = 2.0

# Intercept
i_cdai = RheumaComposites.intercept(cdai)

# Test if different unit scales lead to same results
cdai_u1 = CDAI(t28=0, s28=1, pga=10u"mm", ega=10u"mm")
cdai_u2 = CDAI(t28=0, s28=1, pga=1u"cm", ega=1u"cm")

@testset "Construct CDAI" begin
    @test cdai isa AbstractComposite
    @test cdai isa ContinuousComposite
    @test cdai isa CDAI
    @test t28(cdai) isa Real
    @test s28(cdai) isa Real
    @test pga(cdai) isa Unitful.AbstractQuantity
    @test ega(cdai) isa Unitful.AbstractQuantity
end

@testset "Score CDAI" begin
    @test i_cdai == 0.0
    @test score(cdai) isa Float64
    @test score(cdai) ≈ i_cdai + sum(weight(cdai)) atol = 1e-3
    @test score(cdai) ≈ cdai_ref atol = 1e-2
    @test score(cdai_u1) ≈ score(cdai_u2) atol = 1e-3
end

@testset "CDAI Remission" begin
    @test isremission(cdai)
    @test !isremission(CDAI(t28=3, s28=4, pga=4u"cm", ega=4u"cm"))
end

@testset "Categorise CDAI" begin
    @test categorise(cdai) == "Remission"
    @test categorise.(CDAI, [2.79, 2.81]) == ["Remission", "Low"]
    @test categorise.(CDAI, [9.99, 10.01]) == ["Low", "Moderate"]
    @test categorise.(CDAI, [21.99, 22.01]) == ["Moderate", "High"]
end
