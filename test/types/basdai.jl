# Dummy CDAIs for testing
basdai = BASDAI(q1=1, q2=2, q3=2, q4=2, q5=1, q6=3)

# Intercept
i_basdai = RheumaComposites.intercept(cdai)

# Test if different unit scales lead to same results
basdai_u1 = BASDAI(
    q1=10, q2=20, q3=20, q4=20, q5=10, q6=30,
    units=(q1=u"mm", q2=u"mm", q3=u"mm", q4=u"mm", q5=u"mm", q6=u"mm")
)

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
