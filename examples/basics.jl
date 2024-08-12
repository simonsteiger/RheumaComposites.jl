# # Creating Composites

#=
This tutorial shows you how to set up different composite scores.
=#

using RheumaComposites

#=
Creating composites requires specifying the units of some components.

This protects us from accidentally specifying a DAS28 score on a 0-10 cm visual analogue scale (VAS), or vice versa, an SDAI on a 0-100 mm (VAS).
The only exception are joint counts, which are simply integers.

We will use [`Unitful.jl`](https://painterqubits.github.io/Unitful.jl/stable/) for specifying units throughout.
=#

using Unitful

# Creating units is easy thanks to the [`@u_str`](https://painterqubits.github.io/Unitful.jl/stable/manipulations/#Unitful.@u_str) macro.

18u"mm", 64u"mg/L"

# Converting a unitless value stored in a variable is simple, too:

x = 7;
x * u"cm"

#=
Under the hood, the composites will be converted to the unit matching scoring weights and remission cutoffs.
This means that you do not have to remember that SDAI requires a 0-10 cm VAS scale and C-reactive protein in mg/dL, while the DAS28 requires millimeters and mg/L.

Let's try this by creating a DAS28CRP composite with patient's global assessment measured in centimeters:
=#

das28_cm = DAS28CRP(tjc=1, sjc=0, pga=2.2u"cm", apr=4u"mg/L")

# As you can see, centimeters were automatically converted to millimeters.
# Providing the same score in millimeters return the same result:

das28_mm = DAS28CRP(tjc=1, sjc=0, pga=22u"mm", apr=4u"mg/L")
score(das28_cm) == score(das28_mm)

#=
This principle holds for all supported composites.

## Components

If you are not sure about the component names of a composite, you can check the docstring of that composite for guidance.
To see the docstring, first hit `?` in the REPL, then type the name of the composite, and hit enter.

This is all we need to explore the most important aspects of many different composite scores!
=#

sdai = SDAI(sjc=3, tjc=4, pga=34u"mm", ega=28u"mm", crp=21u"mg/L")
#-
score(sdai), isremission(sdai), categorise(sdai)
