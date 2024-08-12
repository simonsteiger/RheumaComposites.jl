das28 = DAS28ESR(tjc=4, sjc=4, pga=14u"mm", apr=22u"mm/hr")

@testset "Component accessor" begin
    @test components(das28) == fieldnames(typeof(das28))
end
