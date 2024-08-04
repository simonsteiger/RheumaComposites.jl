using Documenter
using DocumenterInterLinks
using RheumaComposites
using Unitful
using Literate

DocMeta.setdocmeta!(RheumaComposites, :DocTestSetup, :(using RheumaComposites, Unitful); recursive=true)

links = InterLinks(
    "Documenter" => "https://documenter.juliadocs.org/stable/objects.inv",
    "Unitful" => "https://painterqubits.github.io/Unitful.jl/stable/objects.inv",
)

examples_jl_path = joinpath(dirname(@__DIR__), "examples")
examples_md_path = joinpath(@__DIR__, "src", "examples")

for file in readdir(examples_md_path)
    if endswith(file, ".md")
        rm(joinpath(examples_md_path, file))
    end
end

for file in readdir(examples_jl_path)
    Literate.markdown(joinpath(examples_jl_path, file), examples_md_path)
end

pages = [
    "Tutorials" => [
        "Basics" => joinpath("examples", "basics.md")
    ],
    "API reference" => "api.md"
]

makedocs(;
    sitename="RheumaComposites.jl",
    authors="Simon Steiger",
    modules=[RheumaComposites],
    pages=pages,
    plugins=[links],
    pagesonly=true,
)

# deploydocs(; repo="github.com/simonsteiger/RheumaComposites.jl", devbranch="main")
