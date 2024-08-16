"""
    RheumaComposites

A Julia package for composite scores in Rheumatology.
"""
module RheumaComposites

import Term
using Unitful

export AbstractComposite
export ContinuousComposite
export BooleanComposite
export ModifiedComposite
export DAS28
export DAS28ESR
export DAS28CRP
export SDAI
export CDAI
export BASDAI
export DAPSA
export faceted, Faceted
export BooleanRemission
export revised, Revised
export subset, Subset
export threeitem
export components
export offset
export root
export intercept
export weight
export score
export isremission
export decompose
export categorise

include("utils/units.jl")
include("utils/constants.jl")
include("utils/auxfuns.jl")
include("utils/valid.jl")

include("types/components.jl")
include("types/composites.jl")
include("types/modified.jl")
include("types/das28.jl")
include("types/sdai.jl")
include("types/cdai.jl")
include("types/dapsa.jl")
include("types/basdai.jl")
include("types/boolean.jl")

include("functions/weight.jl")
include("functions/score.jl")
include("functions/isremission.jl")
include("functions/decompose.jl")
include("functions/categorise.jl")

end
