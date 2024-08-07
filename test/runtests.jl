using RheumaComposites
using Test
using Unitful

@testset "Components" begin
    include("types/components.jl")
end

@testset "DAS28" begin
    include("types/das28.jl")
end

@testset "SDAI" begin
    include("types/sdai.jl")
end

@testset "CDAI" begin
    include("types/cdai.jl")
end

@testset "Boolean" begin
    include("types/boolean.jl")
end
