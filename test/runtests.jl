using RheumaComposites
using Test

@testset "DAS28" begin
    include("types/das28.jl")
end

@testset "SDAI" begin
    include("types/sdai.jl")
end
