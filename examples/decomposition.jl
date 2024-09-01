# # Decomposing composites

# In this tutorial, we will explore how to decompose continuous composites, like the DAS28ESR or SDAI, to better understand which components contribute most.

# It is easier to gauge this composition with unweighted composites like the SDAI, but it becomes much harder with weighted composites like the DAS28.

using RheumaComposites
using Unitful

# Let's begin by defining an SDAI score and looking at its composition.

sdai = SDAI(tjc=2, sjc=1, pga=6u"cm", ega=5.5u"cm", crp=15u"mg/L")
decompose(sdai)

# By default, `decompose()` splits the score into the contributions of each component.
# The values represent ratios of the total score and always sum to one.

# It is also possible to define a custom decomposition by first grouping components in a `Faceted` composite.

das28 = DAS28CRP(tjc=3, sjc=2, pga=44u"mm", apr=14u"mg/L")
facets = (objective=[:sjc, :apr], subjective=[:tjc, :pga])
faceted(das28, facets)

# We then simply call `decompose()` on this `Faceted` composite to get the custom decomposition.

decompose(faceted(das28, facets))

# This can give interesting insights when working with an otherwise opaque composite score!
