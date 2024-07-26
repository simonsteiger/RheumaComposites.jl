using RheumaComposites
using Test

@testset "Components" begin
    include("essential/components.jl")
end

@testset "DAS28" begin
    include("essential/das28.jl")
end

@testset "SDAI" begin
    include("essential/sdai.jl")
end

@testset "Boolean" begin
    include("essential/boolean.jl")
end
