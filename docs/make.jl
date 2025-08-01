using Documenter
using DocumenterInterLinks
using DocumenterVitepress
using Literate
using RheumaComposites
using Unitful

DocMeta.setdocmeta!(RheumaComposites, :DocTestSetup, :(using RheumaComposites, Unitful); recursive=true)

links = InterLinks(
    "Documenter" => "https://documenter.juliadocs.org/stable/objects.inv",
    "Unitful" => "https://juliaphysics.github.io/Unitful.jl/stable/objects.inv",
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
    "Home" => "index.md",
    "Tutorials" => [
        "Basics" => joinpath("examples", "basics.md"),
        "Categorisation" => joinpath("examples", "categorisation.md"),
    ],
    "API reference" => "api.md",
]

makedocs(;
    modules=[RheumaComposites],
    sitename="RheumaComposites.jl",
    authors="Simon Steiger and contributors",
    format=DocumenterVitepress.MarkdownVitepress(;
        repo="https://github.com/simonsteiger/RheumaComposites.jl",
        devurl="dev",
        devbranch="main",
    ),
    pages=pages,
    plugins=[links],
    pagesonly=true,
)

DocumenterVitepress.deploydocs(;
    repo="github.com/simonsteiger/RheumaComposites.jl",
    devbranch="main",
    push_preview=true,
)