boolrem = BooleanRemission(tjc=1, sjc=0, pga=1.4, crp=0.4)

@testset "Original BoolRem" begin
    @test boolrem isa AbstractComposite
    @test boolrem isa BooleanComposite
    @test !isremission(boolrem)
end

@testset "Revised BoolRem" begin
    @test revised(boolrem) isa ModifiedComposite
    @test revised(boolrem) isa Revised{<:BooleanComposite}
    @test isremission(revised(boolrem))
end

@testset "Three-item BoolRem" begin
    @test threeitem(boolrem) isa ModifiedComposite
    @test threeitem(boolrem) isa Partial{3,<:BooleanComposite}
    @test isremission(threeitem(boolrem))
end

@testset "Misspecified BoolRem" begin
    @test try
        weight(boolrem)
    catch e
        e isa ErrorException
    end
    @test try
        weight(revised(boolrem))
    catch e
        e isa ErrorException
    end
    @test try
        weight(threeitem(boolrem))
    catch e
        e isa ErrorException
    end
    @test try
        partial(boolrem, [:tjc, :tjc, :pga])
    catch e
        e isa ErrorException
    end
end
