using RheumaComposites
using Test

# Dummy DAS28ESR for testing
x = DAS28ESR(t28=4, s28=5, pga=12, apr=44)

# A reference value for comparison
# calculated using https://www.4s-dawn.com/DAS28/
ref_value = 4.56

@testset "Constructors" begin
    @test x isa AbstractComposite
    @test x isa ContinuousComposite
    @test x isa DAS28
    @test x isa DAS28ESR
end

@testset "Weighting" begin
    @test intercept(x) == 0.0
    @test score(x) isa Float64
    @test score(x) ≈ intercept(x) + sum(weight(x)) atol=1e-3
    @test score(x) ≈ ref_value atol=1e-2
end
