# Dummy CDAIs for testing
basdai = BASDAI(q1=1u"cm", q2=2u"cm", q3=2u"cm", q4=2u"cm", q5=1u"cm", q6=3u"cm")

# Intercept
i_basdai = RheumaComposites.intercept(cdai)

# Test if different unit scales lead to same results
basdai_u1 = BASDAI(q1=10u"mm", q2=20u"mm", q3=20u"mm", q4=20u"mm", q5=10u"mm", q6=30u"mm")

basdai_ref = 1.8

@testset "Construct BASDAI" begin
    @test basdai isa AbstractComposite
    @test basdai isa ContinuousComposite
    @test basdai isa BASDAI
end

@testset "Score BASDAI" begin
    @test i_basdai == 0.0
    @test score(basdai) isa Float64
    @test score(basdai) ≈ i_basdai + sum(weight(basdai)) atol = 1e-3
    @test score(basdai) ≈ basdai_ref atol = 1e-2
    @test score(basdai) ≈ score(basdai_u1) atol = 1e-3
end

@testset "BASDAI Remission" begin
    @test isremission(basdai)
end
