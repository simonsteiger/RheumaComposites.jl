boolrem = BooleanRemission(t28=1, s28=0, pga=14u"mm", crp=0.4u"mg/dl")

@testset "Original BoolRem" begin
    @test boolrem isa AbstractComposite
    @test boolrem isa BooleanComposite
    @test try weight(boolrem) catch e; e isa ErrorException end
    # should we add a scoring style?
    @test !isremission(boolrem)
    @test t28(boolrem) isa Real
    @test s28(boolrem) isa Real
    @test pga(boolrem) isa Unitful.AbstractQuantity
    @test crp(boolrem) isa Unitful.AbstractQuantity
end

@testset "Revised BoolRem" begin
    @test revised(boolrem) isa ModifiedComposite
    @test revised(boolrem) isa Revised{<:BooleanComposite}
    @test try weight(revised(boolrem)) catch e; e isa ErrorException end
    # should we add a scoring style?
    @test isremission(revised(boolrem))
    @test t28(revised(boolrem)) isa Real
    @test s28(revised(boolrem)) isa Real
    @test pga(revised(boolrem)) isa Unitful.AbstractQuantity
    @test crp(revised(boolrem)) isa Unitful.AbstractQuantity
end

@testset "Three-item BoolRem" begin
    @test threeitem(boolrem) isa ModifiedComposite
    @test threeitem(boolrem) isa ThreeItem{<:BooleanComposite}
    @test try weight(threeitem(boolrem)) catch e; e isa ErrorException end
    # should we add a scoring style?
    @test isremission(threeitem(boolrem))
    @test t28(threeitem(boolrem)) isa Real
    @test s28(threeitem(boolrem)) isa Real
    @test pga(threeitem(boolrem)) isa Unitful.AbstractQuantity
    @test crp(threeitem(boolrem)) isa Unitful.AbstractQuantity
end
