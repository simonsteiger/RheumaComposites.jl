@testset "PGA" begin
    @test PGA(90u"mm") isa AbstractComponent
    @test PGA(90u"mm").value isa Unitful.AbstractQuantity
    @test !isremission(PGA(90u"mm"))
    @test isremission(PGA(4u"mm"))
    @test try
        PGA(101u"mm")
    catch e
        e isa DomainError
    end
    @test try
        PGA(-2u"mm")
    catch e
        e isa DomainError
    end
end

@testset "SJC" begin
    @test SJC(4) isa AbstractComponent
    @test SJC(4).value isa Int64
    @test !isremission(SJC(6))
    @test isremission(SJC(0))
    @test try
        SJC(44)
    catch e
        e isa DomainError
    end
    @test try
        SJC(-2)
    catch e
        e isa DomainError
    end
end