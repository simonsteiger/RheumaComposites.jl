# Dummy SDAIs for testing
sdai = SDAI(t28=1, s28=0, pga=1u"cm", ega=0u"cm", crp=0.1u"mg/dL")
sdai_u1 = SDAI(t28=0, s28=1, pga=10u"mm", ega=10u"mm", crp=1u"mg/dL")
sdai_u2 = SDAI(t28=0, s28=1, pga=1u"cm", ega=1u"cm", crp=10u"mg/L")

@testset "Construct SDAI" begin
    @test sdai isa AbstractComposite
    @test sdai isa ContinuousComposite
    @test sdai isa SDAI
    @test t28(sdai) isa Real
    @test s28(sdai) isa Real
    @test pga(sdai) isa Unitful.AbstractQuantity
    @test ega(sdai) isa Unitful.AbstractQuantity
    @test crp(sdai) isa Unitful.AbstractQuantity
end

@testset "Score SDAI" begin
    @test intercept(sdai) == 0.0
    @test score(sdai) isa Float64
    @test score(sdai) ≈ intercept(sdai) + sum(weight(sdai)) atol = 1e-3
    @test score(sdai) ≈ 3.0 atol = 1e-3
    @test score(sdai_u1) ≈ score(sdai_u2) atol = 1e-3
end

@testset "SDAI Remission" begin
    @test isremission(sdai)
    @test !isremission(SDAI(t28=3, s28=4, pga=4u"cm", ega=4u"cm", crp=5u"mg/dL"))
end
