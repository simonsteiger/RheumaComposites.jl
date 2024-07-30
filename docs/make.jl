push!(LOAD_PATH, "../src/")

using Documenter
using RheumaComposites

makedocs(;
    sitename="RheumaComposites.jl",
    #modules=[RheumaComposites],
)
