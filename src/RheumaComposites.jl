module RheumaComposites

using Term

export AbstractComposite
export ContinuousComposite, BooleanComposite
export DAS28
export DAS28ESR, DAS28CRP
export intercept
export SDAI
export weight
export score


include("types/composites.jl")
include("types/das28.jl")
# include("types/sdai.jl")
include("utils/weight.jl")
include("utils/score.jl")
# include("utils/cutoff.jl")

end
