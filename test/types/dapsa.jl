# Dummy CDAIs for testing
dapsa = DAPSA(tjc=1, sjc=1, crp=3u"mg/dL", pga=1u"cm", jpn=1u"cm")

# Intercept
i_dapsa = RheumaComposites.intercept(dapsa)

# Test if different unit scales lead to same results
dapsa_ualt = DAPSA(tjc=1, sjc=1, crp=30u"mg/L", pga=10u"mm", jpn=10u"mm")

dapsa_ref = 7.0

@testset "Construct DAPSA" begin
    @test dapsa isa AbstractComposite
    @test dapsa isa ContinuousComposite
    @test dapsa isa DAPSA
end

@testset "Score DAPSA" begin
    @test i_dapsa == 0.0
    @test score(dapsa) isa Float64
    @test score(dapsa) ≈ i_dapsa + sum(weight(dapsa)) atol = 1e-3
    @test score(dapsa) ≈ dapsa_ref atol = 1e-2
    @test score(dapsa) ≈ score(dapsa_ualt) atol = 1e-3
end

@testset "DAPSA Remission" begin
    @test !isremission(dapsa)
end

@testset "Categorise DAPSA" begin
    @test categorise(dapsa) == "low"
    @test categorise.(DAPSA, [3.99, 4.01]) == ["remission", "low"]
    @test categorise.(DAPSA, [13.99, 14.01]) == ["low", "moderate"]
    @test categorise.(DAPSA, [27.99, 28.01]) == ["moderate", "high"]
end
