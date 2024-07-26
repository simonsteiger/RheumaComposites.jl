# Dummy SDAI for testing
sdai = SDAI(t28=1, s28=0, pga=1, ega=0, crp=1)

@testset "Construct SDAI" begin
    @test sdai isa AbstractComposite
    @test sdai isa ContinuousComposite
    @test sdai isa SDAI
    @test t28(sdai) isa Real
    @test s28(sdai) isa Real
    @test pga(sdai) isa Real
    @test ega(sdai) isa Real
    @test crp(sdai) isa Real
end

@testset "Score SDAI" begin
    @test intercept(sdai) == 0.0
    @test score(sdai) isa Float64
    @test score(sdai) ≈ intercept(sdai) + sum(weight(sdai)) atol = 1e-3
    @test score(sdai) ≈ 3.0 atol = 1e-2
end

@testset "SDAI Remission" begin
    @test isremission(sdai)
    @test !isremission(SDAI(t28=3, s28=4, pga=4, ega=4, crp=5))
end
