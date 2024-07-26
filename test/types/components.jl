@testset "PGA" begin
    @test PGA(90u"mm") isa AbstractComponent
    @test PGA(90u"mm").value isa Unitful.AbstractQuantity
    @test try PGA(101u"mm") catch e; e isa DomainError end
    @test try PGA(-2u"mm") catch e; e isa DomainError end
    @test !isremission(PGA(90u"mm"))
    @test isremission(PGA(4u"mm"))
end

@testset "SJC28" begin
    @test SJC28(4) isa AbstractComponent
    @test SJC28(4).value isa Int64
    @test try SJC28(44) catch e; e isa DomainError end
    @test try SJC28(-2) catch e; e isa DomainError end
    @test !isremission(SJC28(6))
    @test isremission(SJC28(0))
end