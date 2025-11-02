```@meta
EditURL = "../../../examples/gettingstarted.jl"
```

# Getting started

Creating your first composite score is straightforward:

````@example gettingstarted
using RheumaComposites, Unitful
das28 = DAS28CRP(tjc=1, sjc=0, pga=2.2u"cm", apr=4u"mg/L")
````

`RheumaComposites` requires you to specify units where possible.
To do so you can use the [`@u_str`](https://painterqubits.github.io/Unitful.jl/stable/manipulations/#Unitful.@u_str) macro as shown above.

This hopefully makes it much less unlikely that a measurement taken in centimeters is suddely entered as millimeters!

You are free to specify the score in whichever unit you'd like, so long as it is a compatible unit (i.e., meters and centimeters works, but not square centimeters).

````@example gettingstarted
score(das28) == score(DAS28CRP(tjc=1, sjc=0, pga=22u"mm", apr=4u"mg/L"))
````

If you need to retrieve a specific value stored in the composite, you can use the respectively named accessor function:

````@example gettingstarted
pga(das28)
````

If you would like to retrieve all values, you can use [`values`](@ref):

````@example gettingstarted
values(das28)
````

As you can see, these values come without units!
Depending on your needs, you can also retrieve the units with units using [`uvalues`](@ref)

````@example gettingstarted
uvalues(das28)
````

Finally, you can use [`names`](@ref) to retrieve the variables names making up that composite.

````@example gettingstarted
names(das28)
````

The above concepts hold for all supported composites.

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

