boolrem = BooleanRemission(t28=1, s28=0, pga=14, crp=0.4)

@testset "Original BoolRem" begin
    @test boolrem isa AbstractComposite
    @test boolrem isa BooleanComposite
    @test try weight(boolrem) catch e; e isa ErrorException end
    # should we add a scoring style?
    @test !isremission(boolrem)
    @test t28(boolrem) isa Real
    @test s28(boolrem) isa Real
    @test pga(boolrem) isa Real
    @test crp(boolrem) isa Real
end

@testset "Revised BoolRem" begin
    @test revised(boolrem) isa ModifiedComposite
    @test try weight(revised(boolrem)) catch e; e isa ErrorException end
    # should we add a scoring style?
    @test isremission(revised(boolrem))
    @test t28(boolrem) isa Real
    @test s28(boolrem) isa Real
    @test pga(boolrem) isa Real
    @test crp(boolrem) isa Real
end

@testset "Three-item BoolRem" begin
    @test threeitem(boolrem) isa AbstractComposite
    @test threeitem(boolrem) isa ModifiedComposite
    @test try weight(threeitem(boolrem)) catch e; e isa ErrorException end
    # should we add a scoring style?
    @test isremission(threeitem(boolrem))
    @test t28(boolrem) isa Real
    @test s28(boolrem) isa Real
    @test pga(boolrem) isa Real
    @test crp(boolrem) isa Real
end
