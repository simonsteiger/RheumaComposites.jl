boolrem = BooleanRemission(tjc=1, sjc=0, pga=14u"mm", crp=0.4u"mg/dl")

@testset "Original BoolRem" begin
    @test boolrem isa AbstractComposite
    @test boolrem isa BooleanComposite
    @test try weight(boolrem) catch e; e isa ErrorException end
    @test !isremission(boolrem)
    @test tjc(boolrem) isa Real
    @test sjc(boolrem) isa Real
    @test pga(boolrem) isa Unitful.AbstractQuantity
    @test crp(boolrem) isa Unitful.AbstractQuantity
end

@testset "Revised BoolRem" begin
    @test revised(boolrem) isa ModifiedComposite
    @test revised(boolrem) isa Revised{<:BooleanComposite}
    @test try weight(revised(boolrem)) catch e; e isa ErrorException end
    @test isremission(revised(boolrem))
    @test tjc(revised(boolrem)) isa Real
    @test sjc(revised(boolrem)) isa Real
    @test pga(revised(boolrem)) isa Unitful.AbstractQuantity
    @test crp(revised(boolrem)) isa Unitful.AbstractQuantity
end

@testset "Three-item BoolRem" begin
    @test threeitem(boolrem) isa ModifiedComposite
    @test threeitem(boolrem) isa Subset{3, <:BooleanComposite}
    @test try weight(threeitem(boolrem)) catch e; e isa ErrorException end
    @test isremission(threeitem(boolrem))
    @test tjc(threeitem(boolrem)) isa Real
    @test sjc(threeitem(boolrem)) isa Real
    @test pga(threeitem(boolrem)) isa Unitful.AbstractQuantity
    @test crp(threeitem(boolrem)) isa Unitful.AbstractQuantity
end
