using Documenter
using DocumenterInterLinks
using Literate
using RheumaComposites
using Unitful

DocMeta.setdocmeta!(RheumaComposites, :DocTestSetup, :(using RheumaComposites, Unitful); recursive=true)

links = InterLinks(
    "Documenter" => "https://documenter.juliadocs.org/stable/objects.inv",
    "Unitful" => "https://painterqubits.github.io/Unitful.jl/stable/objects.inv",
)

open(joinpath(joinpath(@__DIR__, "src"), "index.md"), "w") do io
    println(
        io,
        """
        ```@meta
        EditURL = "https://github.com/simonsteiger/RheumaComposites.jl/blob/main/README.md"
        ```
        """,
    )
    for line in eachline(joinpath(dirname(@__DIR__), "README.md"))
        println(io, line)
    end
end

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
    "Home" => "index.md",
    "Tutorials" => [
        "Basics" => joinpath("examples", "basics.md"),
        "Categorisation" => joinpath("examples", "categorisation.md"),
    ],
    "API reference" => "api.md",
]

Documenter.makedocs(;
    sitename="RheumaComposites.jl",
    authors="Simon Steiger",
    modules=[RheumaComposites],
    pages=pages,
    plugins=[links],
    pagesonly=true,
)

deploydocs(;
    repo="github.com/simonsteiger/RheumaComposites.jl",
    devbranch="main"
)
