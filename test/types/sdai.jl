# Dummy SDAIs for testing
sdai = SDAI(tjc=1, sjc=0, pga=1u"cm", ega=0u"cm", crp=0.1u"mg/dL")
# See https://www.mdcalc.com/calc/2194/simple-disease-activity-index-sdai-rheumatoid-arthritis
sdai_ref = 2.1 

# Intercept
i_sdai = RheumaComposites.intercept(sdai)

# Test if different unit scales lead to same results
sdai_u1 = SDAI(tjc=0, sjc=1, pga=10u"mm", ega=10u"mm", crp=10u"mg/L")
sdai_u2 = SDAI(tjc=0, sjc=1, pga=1u"cm", ega=1u"cm", crp=1u"mg/dL")

@testset "Construct SDAI" begin
    @test sdai isa AbstractComposite
    @test sdai isa ContinuousComposite
    @test sdai isa SDAI
end

@testset "Score SDAI" begin
    @test i_sdai == 0.0
    @test score(sdai) isa Float64
    @test score(sdai) ≈ i_sdai + sum(weight(sdai)) atol = 1e-3
    @test score(sdai) ≈ sdai_ref atol = 1e-2
    @test score(sdai_u1) ≈ score(sdai_u2) atol = 1e-3
end

@testset "SDAI Remission" begin
    @test isremission(sdai)
    @test !isremission(SDAI(tjc=3, sjc=4, pga=4u"cm", ega=4u"cm", crp=5u"mg/dL"))
end

@testset "Categorise SDAI" begin
    @test categorise(sdai) == "remission"
    @test categorise.(SDAI, [3.29, 3.31]) == ["remission", "low"]
    @test categorise.(SDAI, [10.99, 11.01]) == ["low", "moderate"]
    @test categorise.(SDAI, [25.99, 26.01]) == ["moderate", "high"]
end
