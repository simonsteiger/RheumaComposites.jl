#=
# Continuous composites

Continuous composites are those composites which can be turned into a numeric score using some scoring algorithm.

Some functions like [`score`](@ref) are only defined for continuous composites.
If you are not sure if a composite is continuous, you can always run:
=#

using RheumaComposites
SDAI <: ContinuousComposite

#=
## Scoring

Being able to calculate a numeric score is what sets continuous composite apart from Boolean composites.
The score calculated this way is what will allow us to categorise the patient's disease activity or check whether they are in remission.
=#

using Unitful
sdai = SDAI(sjc=3, tjc=4, pga=3.4u"cm", ega=2.8u"cm", crp=21u"mg/dL")
score(sdai)

#=
## Categorisation

For all continuous composites included in `RheumaComposites`, cutoffs have been defined to categorise the numeric scores into discrete disease activity categories:

| Disease activity | DAS28ESR | DAS28CRP | SDAI   | CDAI   |  DAPSA  |  BASDAI  |
|:-----------------|----------|----------|--------|--------|---------|----------|
| Remission        | ``<`` 2.6    | ``<`` 2.4    | ``\leq`` 3.3  | ``\leq`` 2.8  | ``\leq`` 4.0  | ``\leq`` 4.0  | 
| Low              | ``\leq`` 3.2    | ``\leq`` 2.9    | ``\leq`` 11.0 | ``\leq`` 10.0 | ``\leq`` 14.0 | -  | 
| Moderate         | ``\leq`` 5.1    | ``\leq`` 4.6    | ``\leq`` 26.0 | ``\leq`` 22.0 | ``\leq`` 28.0 | -  | 
| High             | ``>`` 5.1    | ``>`` 4.6    | ``>`` 26.0 | ``>`` 22.0 | ``>`` 28.0 | -  | 

To determine the disease activity category of a patient's continuous composite, use [`categorise`](@ref)
=#

categorise(sdai)

# Since disease remission is typically of most interest, [`isremission`](@ref) allows you to check this directly.

isremission(sdai)

#=
## Decomposition

Several configurations of component variables can lead to the same composite score.
Therefore, it can be of interest to understand how configurations compare between patients within or across different disease activity groups.

The [`decompose`](@ref) function shows you by how much each component contributes to the final score.
The values are fractions and will therefore add to 1.
=#

decompose(sdai)

#=
Furthermore, it is possible to group component variables into different groups, resulting in what I named [`faceted`](@ref) composites.
This grouping will then be reflected by the fractions calculated by [`decompose`](@ref).
=#

facets = (subjective = [:tjc, :sjc, :pga], objective = [:ega, :crp])
faceted_sdai = faceted(sdai, facets)

# Using [`decompose`](@ref) on this modified SDAI composite will tell us to what degree subjective and objective variables contributed to the score.

decompose(faceted_sdai)
