using RheumaComposites
using Test
using Unitful

@testset "DAS28" begin
    include("types/das28.jl")
end

@testset "SDAI" begin
    include("types/sdai.jl")
end

@testset "CDAI" begin
    include("types/cdai.jl")
end

@testset "DAPSA" begin
    include("types/dapsa.jl")
end

@testset "BASDAI" begin
    include("types/basdai.jl")
end

@testset "Boolean" begin
    include("types/boolean.jl")
end

@testset "Helpers" begin
    include("utils/auxfuns.jl")
    include("utils/valid.jl")
end
