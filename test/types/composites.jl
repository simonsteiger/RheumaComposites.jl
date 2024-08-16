das28 = DAS28ESR(tjc=4, sjc=4, pga=14u"mm", apr=22u"mm/hr")

pure_scheme = RheumaComposites.WeightingScheme(typeof(das28))
partial_scheme = RheumaComposites.WeightingScheme(typeof(partial(das28, [:sjc, :tjc])))

@testset "Component accessor" begin
    @test components(das28) == fieldnames(typeof(das28))
end

@testset "WeightingScheme inheritance" begin
    @test pure_scheme == partial_scheme
end
