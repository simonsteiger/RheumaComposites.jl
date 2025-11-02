#=
# Boolean composites

Boolean composites differ from continuous composites in that they only define a threshold for remission.
This obviates the need for a scoring algorithm and turns disease activity classification into a binary "remission or not remission", hence the name Boolean composite.
=#

using RheumaComposites, Unitful

boolrem = BooleanRemission(tjc=0, sjc=1, pga=14u"mm", crp=8u"mg/L")

#=
## Remission

To check for remission, we simply call [`isremission`](@ref)
=#

isremission(boolrem)

#=
## Modification

Choosing cutoffs and component variables correctly can be tough, and may therefore change.

Examples of this include the debate around the inclusion of patient-reported global health in EULAR's definition of Boolean remission. 
Critics pointed out that it risks conflating disease activity with the impact the disease (or other comorbidities) may already have had on the patient's quality of life.

### Ignoring components

As a solution, some researchers proposed dropping patient-reported global health from the definition of Boolean remission.

As we saw above, our hypothetical patient would not be in remission according to the "classical" definition of Boolean remission because their patient-reported global health exceeds 10 mm.

Let's now change this score into to the so-called "three-item" Boolean remission, no longer accounting for patient-reported global health when deciding whether a patient is in remission or not.
=#

threeitem_boolrem = threeitem(boolrem)
isremission(threeitem_boolrem)

#=
As expected, this patient would meet these modified remission criteria.

It is also possible to manually specify which scores should be ignored when testing whether a patient is in remission with [`partial`](@ref).
=#

joints_boolrem = partial(boolrem, [:tjc, :sjc])
isremission(joints_boolrem)

#=
In this modified version, we are only considering whether this patient meets remission cutoffs defined for `tjc` and `sjc`.

### Modifying cutoffs

Another solution that was proposed to change the role of patient-reported global health in defining remission was to increase the cutoff from 10 mm to 20 mm.

This is how we can change to the [`revised`](@ref) definition of Boolean remission:
=#

revised_boolrem = revised(boolrem)
isremission(revised_boolrem)

#=
When calling [`revised`](@ref) on a [`BooleanRemission`](@ref) score, it applies this popular revision by default.
However, we can also manually change other cutoffs.
If we wanted to work with a definition where a patient must have exactly 0 swollen joints to qualify as in remission, we could do the following:
=#

strict_sjc_boolrem = revised(boolrem, (; sjc=-1))
isremission(strict_sjc_boolrem)

# Since the patient had more than 0 `sjc`, this patient no longer qualifies as in remission according to our modified cutoffs.
