using RheumaComposites
using Test

@testset "Components" begin
    include("types/components.jl")
end

@testset "DAS28" begin
    include("types/das28.jl")
end

@testset "SDAI" begin
    include("types/sdai.jl")
end
