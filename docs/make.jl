using Documenter
using DocumenterInterLinks
using RheumaComposites
using Unitful

DocMeta.setdocmeta!(RheumaComposites, :DocTestSetup, :(using RheumaComposites, Unitful); recursive=true)

links = InterLinks(
    "Documenter" => "https://documenter.juliadocs.org/stable/objects.inv",
    "Unitful" => "https://painterqubits.github.io/Unitful.jl/stable/objects.inv",
)

makedocs(;
    sitename="RheumaComposites.jl",
    modules=[RheumaComposites],
    plugins=[links],
)

deploydocs(; repo="github.com/simonsteiger/RheumaComposites.jl", devbranch="main")
