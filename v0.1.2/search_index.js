var documenterSearchIndex = {"docs":
[{"location":"api/#API-reference","page":"API reference","title":"API reference","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"RheumaComposites","category":"page"},{"location":"api/#RheumaComposites","page":"API reference","title":"RheumaComposites","text":"RheumaComposites\n\nA Julia package for composite scores in Rheumatology.\n\n\n\n\n\n","category":"module"},{"location":"api/#Types","page":"API reference","title":"Types","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"AbstractComposite\nContinuousComposite\nBooleanComposite\nModifiedComposite\nDAS28\nDAS28ESR\nDAS28CRP\nSDAI\nCDAI\nFaceted\nBooleanRemission\nRevised\nSubset\nAbstractComponent\nPGA\nSJC","category":"page"},{"location":"api/#RheumaComposites.AbstractComposite","page":"API reference","title":"RheumaComposites.AbstractComposite","text":"AbstractComposite\n\nAbstract type that specifies the category of composites.\n\nIt is either ContinuousComposite, BooleanComposite, or ModifiedComposite.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.ContinuousComposite","page":"API reference","title":"RheumaComposites.ContinuousComposite","text":"ContinuousComposite <: AbstractComposite\n\nAbstract type for composites whose scores are floating point numbers.\n\nSee also score, BooleanComposite.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.BooleanComposite","page":"API reference","title":"RheumaComposites.BooleanComposite","text":"BooleanComposite <: AbstractComposite\n\nAbstract type for composites only implementing a definition of remission.\n\nSee also isremission, ContinuousComposite.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.ModifiedComposite","page":"API reference","title":"RheumaComposites.ModifiedComposite","text":"ModifiedComposite <: AbstractComposite\n\nAbstract type representing alterations to existing composites.\n\nSee also faceted, revised, threeitem.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.DAS28","page":"API reference","title":"RheumaComposites.DAS28","text":"DAS28 <: ContinuousComposite\n\nAbstract type for DAS28 subtypes.\n\nSee also DAS28ESR, DAS28CRP.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.DAS28ESR","page":"API reference","title":"RheumaComposites.DAS28ESR","text":"DAS28ESR(; tjc, sjc, pga, apr)\n\nStore the component measures of the DAS28ESR.\n\nComponents\n\ntjc 28 tender joint count\nsjc 28 swollen joint count\npga patient's global assessment\napr active phase reactant, here ESR\n\nnote: Units\nCurrently, pga must be a length (typically millimeters or centimeters) and apr must be a rate (typically mm/hr). See also Unitful.@u_str.\n\nCategories\n\n 3.2 = Remission\nleq 3.2 = Low\nleq 5.1 = Moderate\n 5.1 = High\n\nExternal links\n\nDAS28 calculator\n\nSee also score, categorise, isremission.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.DAS28CRP","page":"API reference","title":"RheumaComposites.DAS28CRP","text":"DAS28CRP(; tjc, sjc, pga, apr)\n\nStore the component measures of the DAS28CRP.\n\nComponents\n\ntjc 28 tender joint count\nsjc 28 swollen joint count\npga patient's global assessment\napr active phase reactant, here CRP\n\nnote: Units\nCurrently, pga must be a length (typically millimeters or centimeters) and crp must be a concentration (typically mg/dL or mg/L). See also Unitful.@u_str.\n\nCategories\n\n 2.9 = Remission\nleq 2.9 = Low\nleq 4.6 = Moderate\n 4.6 = High\n\nExternal links\n\nDAS28 calculator\n\nSee also score, categorise, isremission.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.SDAI","page":"API reference","title":"RheumaComposites.SDAI","text":"SDAI(; tjc, sjc, pga, ega, crp)\n\nStore component measures of the Simplified Disease Activity Index, or SDAI.\n\nComponents\n\ntjc 28 tender joint count\nsjc 28 swollen joint count\npga patient's global assessment\nega evaluator's global assessment\ncrp c-reactive protein\n\nnote: Units\nCurrently, pga and ega must be a length (typically millimeters or centimeters) and crp must be a concentration (typically mg/dL or mg/L). See also Unitful.@u_str.\n\nCategories\n\nleq 11.0 = Remission\nleq 11.0 = Low\nleq 26.0 = Moderate\n 26.0 = High\n\nExternal links\n\nSDAI calculator\n\nSee also score, categorise, isremission.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.CDAI","page":"API reference","title":"RheumaComposites.CDAI","text":"CDAI(; tjc, sjc, pga, ega)\n\nStore component measures of the Clinical Disease Activity Index, or CDAI.\n\nComponents\n\ntjc 28 tender joint count\nsjc 28 swollen joint count\npga patient's global assessment\nega evaluator's global assessment\n\nnote: Units\nCurrently, pga and ega must be a length (typically millimeters or centimeters). See also Unitful.@u_str.\n\nCategories\n\n 10.0 = Remission\nleq 10.0 = Low\nleq 22.0 = Moderate\n 22.0 = High\n\nExternal links\n\nCDAI calculator\n\nSee also score, categorise, isremission.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.Faceted","page":"API reference","title":"RheumaComposites.Faceted","text":"Faceted{T} <: ModifiedComposite\n\nThis type indicates a further grouping of the stored composite's components.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.BooleanRemission","page":"API reference","title":"RheumaComposites.BooleanRemission","text":"BooleanRemission(; tjc, sjc, pga, crp)\n\nStore the components of the original ACR/EULAR Boolean remission.\n\nComponents\n\ntjc 28 tender joint count\nsjc 28 swollen joint count\npga patient's global assessment\ncrp C-reactive protein\n\nnote: Units\nCurrently, pga must be a length (typically millimeters or centimeters) and crp must be a concentration (typically mg/dL or mg/L). See also Unitful.@u_str.\n\nSee also isremission.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.Revised","page":"API reference","title":"RheumaComposites.Revised","text":"Revised{T} <: ModifiedComposite\n\nThis type indicates that the stored composite's threshold for remission has been revised.\n\nSee also BooleanRemission.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.Subset","page":"API reference","title":"RheumaComposites.Subset","text":"Subset{N,T}\n\nRedefine a composite as a subset of its components.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.AbstractComponent","page":"API reference","title":"RheumaComposites.AbstractComponent","text":"AbstractComponent\n\nAbstract type for single-component outcomes.\n\nSee also isremission, PGA, SJC.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.PGA","page":"API reference","title":"RheumaComposites.PGA","text":"PGA <: AbstractComponent\n\nThis type represents the patient global assessment measured on the visual analogue scale.\n\nSee also value, SJC, AbstractComponent.\n\n\n\n\n\n","category":"type"},{"location":"api/#RheumaComposites.SJC","page":"API reference","title":"RheumaComposites.SJC","text":"SJC <: AbstractComponent\n\nThis type represents the 28 swollen joints count.\n\nSee also value, PGA, AbstractComponent.\n\n\n\n\n\n","category":"type"},{"location":"api/#Interface","page":"API reference","title":"Interface","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"tjc\nsjc\npga\napr\nega\ncrp\noffset\ncomponents\nroot","category":"page"},{"location":"api/#RheumaComposites.tjc","page":"API reference","title":"RheumaComposites.tjc","text":"tjc(x::AbstractComposite)\n\nReturn the 28 tender-joint count.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.sjc","page":"API reference","title":"RheumaComposites.sjc","text":"sjc(x::AbstractComposite)\n\nReturn the 28 swollen-joint count.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.pga","page":"API reference","title":"RheumaComposites.pga","text":"pga(x::AbstractComposite)\n\nReturn the patient global assessment.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.apr","page":"API reference","title":"RheumaComposites.apr","text":"apr(x::AbstractComposite)\n\nReturn the acute phase reactant.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.ega","page":"API reference","title":"RheumaComposites.ega","text":"Return the evaluator's global assessment.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.crp","page":"API reference","title":"RheumaComposites.crp","text":"Return the CRP value.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.offset","page":"API reference","title":"RheumaComposites.offset","text":"offset(x::Revised{<:BooleanComposite})\n\nReturn the offsets to remission thresholds.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.components","page":"API reference","title":"RheumaComposites.components","text":"components(x::AbstractComposite)\n\nReturn the fieldnames of the type of x.\n\nAlias for fieldnames(typeof(x)).\n\n\n\n\n\ncomponents(x::ModifiedComposite)\n\nReturn the components of the unmodified composite.\n\n\n\n\n\ncomponents(x::Subset{N,<:BooleanComposite})\n\nReturn the components kept in the Subset.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.root","page":"API reference","title":"RheumaComposites.root","text":"root(x::ModifiedComposite)\n\nReturn the unmodified composite.\n\n\n\n\n\n","category":"function"},{"location":"api/#Functions","page":"API reference","title":"Functions","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"intercept\nweight\nscore\nisremission\ndecompose\ncategorise\nfaceted\nrevised\nsubset\nthreeitem\nvalue","category":"page"},{"location":"api/#RheumaComposites.intercept","page":"API reference","title":"RheumaComposites.intercept","text":"intercept(x::ContinuousComposite)\n\nReturn the intercept.\n\nThis function can be useful if you want to implement custom decomposition or component reweighting.\n\nSee also score, decompose.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.weight","page":"API reference","title":"RheumaComposites.weight","text":"weight(x::T) where {T}\n\nWeight a composite score's components according to its weighting scheme.\n\nExample\n\njulia> DAS28CRP(tjc=2, sjc=2, pga=54u\"mm\", apr=19u\"mg/L\") |> weight\n(0.7919595949289333, 0.39597979746446665, 0.756, 1.0784636184794367)\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.score","page":"API reference","title":"RheumaComposites.score","text":"score(c::ContinuousComposite; digits=3)\n\nScore a composite and optionally specify the rounding precision.\n\nExamples\n\njulia> DAS28ESR(tjc=4, sjc=2, pga=64u\"mm\", apr=44u\"mm/hr\") |> score\n5.061\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.isremission","page":"API reference","title":"RheumaComposites.isremission","text":"isremission(x::AbstractComposite)\n\nCheck whether a composite fulfils remission criteria.\n\nExamples\n\njulia> DAS28ESR(tjc=4, sjc=5, pga=44u\"mm\", apr=23u\"mm/hr\") |> isremission\nfalse\njulia> BooleanRemission(tjc=1, sjc=0, pga=14u\"mm\", crp=0.4u\"mg/dl\") |>\n       revised |>\n       isremission\ntrue\n\n\n\n\n\nisremission(::Type{T}, s::Real) where {T<:ContinuousComposite}\n\nCheck whether a composite fulfils remission criteria.\n\nExamples\n\njulia> isremission(DAS28ESR, 3.9)\nfalse\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.decompose","page":"API reference","title":"RheumaComposites.decompose","text":"decompose(x::ContinuousComposite; digits=3)\n\nReturn the proportion to which each component contributes to the composite's score.\n\nOptionally specify the number of digits to round the results to.\n\nSee also score.\n\nExamples\n\njulia> SDAI(tjc=4, sjc=5, pga=16u\"mm\", ega=12u\"mm\", crp=3u\"mg/L\") |> decompose\n(tjc = 0.331, sjc = 0.413, pga = 0.132, ega = 0.099, crp = 0.025)\n\n\n\n\n\ndecompose(x::Faceted{<:ContinuousComposite}; digits=3)\n\nReturn the proportion to which each facet contributes to the composite's score.\n\nExamples\n\njulia> root = DAS28ESR(tjc=4, sjc=5, pga=14u\"mm\", apr=12u\"mm/hr\");\n\njulia> faceted(root, (objective=[:sjc, :apr], subjective=[:tjc, :pga])) |> decompose\n(objective = 0.474, subjective = 0.525)\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.categorise","page":"API reference","title":"RheumaComposites.categorise","text":"categorise(::Type{T}, s::Real) where {T<:ContinuousComposite}\n\nConvert score s to a discrete value using SDAI thresholds.\n\nThe same functionality exists for other ContinuousComposites.\n\nExamples\n\njulia> categorise(SDAI, 3.6)\n\"low\"\n\n\n\n\n\ncategorise(x::ContinuousComposite)\n\nConvert x to a discrete value.\n\nExamples\n\njulia> DAS28ESR(tjc=4, sjc=5, pga=12u\"mm\", apr=44u\"mm/hr\") |> categorise\n\"moderate\"\n\n\n\n\n\ncategorise(x::Faceted{<:ContinuousComposite})\n\nConvert the root composite of x to a discrete value.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.faceted","page":"API reference","title":"RheumaComposites.faceted","text":"faceted(root::ContinuousComposite, facets::NamedTuple)\n\nSpecify a custom grouping along which the composite can be analysed.\n\nSee also decompose.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.revised","page":"API reference","title":"RheumaComposites.revised","text":"revised(root::BooleanRemission, offset::NamedTuple)\nrevised(root::BooleanRemission; offset::NamedTuple=(; pga=10u\"mm\"))\n\nModify the remission thresholds of a composite.\n\nThe values passed to offset will be added to the default thresholds of root.\n\nSee also isremission.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.subset","page":"API reference","title":"RheumaComposites.subset","text":"subset(root::AbstractComposite, keep::Vector{Symbol})\n\nRedefine a composite as a subset of its components.\n\nFunctions like score or isremission act on the subset of components.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.threeitem","page":"API reference","title":"RheumaComposites.threeitem","text":"threeitem(root::BooleanRemission)\n\nChange the calculation of Boolean remission to exclude patient global assessment.\n\nAlias for subset(root::BooleanRemission, [:sjc, :tjc, :crp]).\n\nSee also subset, isremission, BooleanRemission.\n\n\n\n\n\n","category":"function"},{"location":"api/#RheumaComposites.value","page":"API reference","title":"RheumaComposites.value","text":"Return the value stored in x.\n\n\n\n\n\n","category":"function"},{"location":"api/#Index","page":"API reference","title":"Index","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"EditURL = \"../../../examples/categorisation.jl\"","category":"page"},{"location":"examples/categorisation/#Categorising-composites","page":"Categorisation","title":"Categorising composites","text":"","category":"section"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"In this tutorial, we will explore how to convert continuous composites, like the DAS28ESR or SDAI, into discrete disease activity levels.","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"using RheumaComposites\nusing Unitful","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"As long as the composite you are defining is a continuous composite, all you need to do is to call categorise.","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"sdai = SDAI(tjc=2, sjc=1, pga=6u\"cm\", ega=5.5u\"cm\", crp=15u\"mg/L\")\nsdai isa ContinuousComposite","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"Well, that was expected!","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"Now let's see what the discrete disease activity level of this score would be.","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"categorise(sdai)","category":"page"},{"location":"examples/categorisation/#Cutoffs","page":"Categorisation","title":"Cutoffs","text":"","category":"section"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"The cutoffs used per composite and category are:","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"Disease activity DAS28ESR DAS28CRP SDAI CDAI\nRemission  2.6  2.4 leq 3.3 leq 2.8\nLow leq 3.2 leq 2.9 leq 11.0 leq 10.0\nModerate leq 5.1 leq 4.6 leq 26.0 leq 22.0\nHigh  5.1  4.6  26.0  22.0","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"Internally, these are saved in a NamedTuple which you can import with import RheumaComposites: cutoff. To retrieve the cutoff for a Moderate CDAI, you would:","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"import RheumaComposites: cutoff\ncutoff.CDAI.moderate","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"Note that this only returns the boundary value of the respective category, and that the inclusion of this value varies across both composites and categories. It is therefore safest to simply rely on the categorise function.","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"An alternative way to check the cutoffs is the respective composite's documentation. You can see this by typing ?CDAI in the REPL.","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"","category":"page"},{"location":"examples/categorisation/","page":"Categorisation","title":"Categorisation","text":"This page was generated using Literate.jl.","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"EditURL = \"../../../examples/basics.jl\"","category":"page"},{"location":"examples/basics/#Creating-Composites","page":"Basics","title":"Creating Composites","text":"","category":"section"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"This tutorial shows you how to set up different composite scores.","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"using RheumaComposites","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"Creating composites requires specifying the units of some components.","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"This protects us from accidentally specifying a DAS28 score on a 0-10 cm visual analogue scale (VAS), or vice versa, an SDAI on a 0-100 mm (VAS). The only exception are joint counts, which are simply integers.","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"We will use Unitful.jl for specifying units throughout.","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"using Unitful","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"Creating units is easy thanks to the @u_str macro.","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"18u\"mm\", 64u\"mg/L\"","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"Converting a unitless value stored in a variable is simple, too:","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"x = 7;\nx * u\"cm\"","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"Under the hood, the composites will be converted to the unit matching scoring weights and remission cutoffs. This means that you do not have to remember that SDAI requires a 0-10 cm VAS scale and C-reactive protein in mg/dL, while the DAS28 requires millimeters and mg/L.","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"Let's try this by creating a DAS28CRP composite with patient's global assessment measured in centimeters:","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"das28_cm = DAS28CRP(tjc=1, sjc=0, pga=2.2u\"cm\", apr=4u\"mg/L\")","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"As you can see, centimeters were automatically converted to millimeters. Providing the same score in millimeters return the same result:","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"das28_mm = DAS28CRP(tjc=1, sjc=0, pga=22u\"mm\", apr=4u\"mg/L\")\nscore(das28_cm) == score(das28_mm)","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"This principle holds for all supported composites.","category":"page"},{"location":"examples/basics/#Components","page":"Basics","title":"Components","text":"","category":"section"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"If you are not sure about the component names of a composite, you can check the docstring of that composite for guidance. To see the docstring, first hit ? in the REPL, then type the name of the composite, and hit enter.","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"This is all we need to explore the most important aspects of many different composite scores!","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"sdai = SDAI(sjc=3, tjc=4, pga=34u\"mm\", ega=28u\"mm\", crp=21u\"mg/L\")","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"score(sdai), isremission(sdai), categorise(sdai)","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"","category":"page"},{"location":"examples/basics/","page":"Basics","title":"Basics","text":"This page was generated using Literate.jl.","category":"page"},{"location":"","page":"Home","title":"Home","text":"EditURL = \"https://github.com/simonsteiger/RheumaComposites.jl/blob/main/README.md\"","category":"page"},{"location":"#RheumaComposites.jl-img-src'docs/src/assets/logo.svg'-align'right'-height'135'/","page":"Home","title":"RheumaComposites.jl <img src='docs/src/assets/logo.svg' align='right' height='135'/>","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Build Status) (Image: Dev)","category":"page"},{"location":"","page":"Home","title":"Home","text":"A Julia package for composite scores used in Rheumatology.","category":"page"},{"location":"#Getting-started","page":"Home","title":"Getting started","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This package is not yet registered with the Julia package registry, so you have to install it via url:","category":"page"},{"location":"","page":"Home","title":"Home","text":"import Pkg\nPkg.add(url=\"https://github.com/simonsteiger/RheumaComposites.jl\")","category":"page"},{"location":"","page":"Home","title":"Home","text":"Now you're ready to start working with composite scores:","category":"page"},{"location":"","page":"Home","title":"Home","text":"using RheumaComposites, Unitful\ndas28 = DAS28ESR(t28=4, s28=3, pga=41u\"mm\", apr=19u\"mm/hr\")\nscore(das28)\nisremission(das28)\ncategorise(das28)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Have a look at the documentation for more examples!","category":"page"},{"location":"#Supported-composites","page":"Home","title":"Supported composites","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This package currently supports the following composites:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Rheumatoid Arthritis Psoriatric Arthritis Spondyloarthritis Lupus ...\nDAS28    ...\nSDAI    ...\nCDAI    ...\nBoolean remission    ...","category":"page"},{"location":"","page":"Home","title":"Home","text":"Additional subtypes and modifications of these composites are available, e.g., the DAS28CRP or the Revised Boolean Remission.","category":"page"},{"location":"#Contributing","page":"Home","title":"Contributing","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"If you spot a bug or want to ask for a new feature, please open an issue on the GitHub repository.","category":"page"}]
}