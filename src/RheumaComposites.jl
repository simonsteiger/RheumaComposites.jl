__precompile__(true)

module RheumaComposites

import Term
using Unitful

export AbstractComponent
export PGA, SJC28
export AbstractComposite
export ContinuousComposite
export BooleanComposite
export ModifiedComposite
export DAS28
export DAS28ESR
export DAS28CRP
export SDAI
export faceted, Faceted
export BooleanRemission
export revised, Revised, threeitem, ThreeItem
export t28, s28, pga, apr, ega, crp
export weight
export score
export isremission
export decompose

include("utils/units.jl")
include("utils/valid.jl")
include("types/components.jl")
include("types/composites.jl")
include("types/das28.jl")
include("types/sdai.jl")
include("types/boolean.jl")
include("types/modified.jl")
include("utils/weight.jl")
include("utils/score.jl")
include("utils/remission.jl")
include("utils/decompose.jl")
# include("utils/categorise.jl")

end
