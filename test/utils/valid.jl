@testset "Validate inputs" begin
    @test try RheumaComposites.valid_joints(29) catch e; e isa ErrorException end
    @test RheumaComposites.valid_joints(12)
    @test try RheumaComposites.valid_vas(11u"cm") catch e; e isa DomainError end
    @test RheumaComposites.valid_vas(6u"mm")
    @test try RheumaComposites.valid_vas(3) catch e; e isa ErrorException end
    @test RheumaComposites.valid_apr(12u"mm/hr")
    @test try RheumaComposites.valid_apr(44) catch e; e isa ErrorException end
end
