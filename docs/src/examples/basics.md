```@meta
EditURL = "../../../examples/basics.jl"
```

# Creating Composites

This tutorial shows you how to set up different composite scores.

````@example basics
using RheumaComposites
````

Creating composites requires specifying the units of some components.
This protects us from accidentally specifying a DAS28 score on a 0-10 cm visual analogue scale (VAS), or vice versa, an SDAI on a 0-100 mm (VAS).
The only exception are joint counts, which are simply integers.

We will use [`Unitful.jl`](https://painterqubits.github.io/Unitful.jl/stable/) for specifying units throughout.
This is very convenient with the [`@u_str`](https://painterqubits.github.io/Unitful.jl/stable/manipulations/#Unitful.@u_str) macro.

````@example basics
using Unitful

18u"mm"

64u"mg/L"
````

Converting a unitless value stored in a variable is simple, too

````@example basics
x = 7;
x * u"cm"
````

Under the hood, the composites will be converted to the unit matching scoring weights and remission cutoffs.
This means that you do not have to remember that SDAI requires a 0-10 cm VAS scale and C-reactive protein in mg/dL, while the DAS28 requires millimeters and mg/L.

````@example basics
das28_1 = DAS28CRP(t28=1, s28=0, pga=22u"mm", apr=4u"mg/L")
````

````@example basics
score(das28_1)
````

````@example basics
das28_2 = DAS28CRP(t28=1, s28=0, pga=2.2u"cm", apr=4u"mg/L")
````

````@example basics
score(das28_2)
````

The same technique holds for all supported composites.
If you are not sure about the field names of a composite, you can check the docstring of that composite for guidance.
To see the docstring, first hit `?` in the REPL, then type the name of the composite, and hit enter.

Now we're ready to explore the most important aspects of composite scores!

````@example basics
sdai = SDAI(s28=3, t28=4, pga=34u"mm", ega=28u"mm", crp=21u"mg/L")
````

````@example basics
score(sdai), isremission(sdai), categorise(sdai)
````

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

