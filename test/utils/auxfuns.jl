@testset "NamedTuple to vector" begin
    nt = (; a = 1, b = 2, c = 3)
    @test RheumaComposites.values_flatten(nt) == [1, 2, 3]
end

@testset "Unit conversion" begin
    vals = (; pga = 10u"cm", ega = 10u"mm")
    conversions = (; pga = u"mm", ega = u"cm")
    @test RheumaComposites.unitfy(vals, conversions) == (100u"mm", 1u"cm")
end
