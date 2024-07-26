__precompile__(true)

module RheumaComposites

using Term

export AbstractComponent
export PGA, SJC28
export AbstractComposite
export ContinuousComposite, BooleanComposite
export DAS28
export DAS28ESR, DAS28CRP
export intercept
export SDAI
export weight
export score
export isremission

include("types/components.jl")
include("types/composites.jl")
include("types/das28.jl")
include("types/sdai.jl")
include("utils/weight.jl")
include("utils/score.jl")
include("utils/remission.jl")
# include("utils/categorise.jl")

end
