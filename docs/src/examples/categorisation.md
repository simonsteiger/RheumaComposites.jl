```@meta
EditURL = "../../../examples/categorisation.jl"
```

# Categorising composites

In this tutorial, we will explore how to convert continuous composites, like the DAS28ESR or SDAI, into discrete disease activity levels.

````@example categorisation
using RheumaComposites
using Unitful
````

As long as the composite you are defining is a continuous composite, all you need to do is to call [`categorise`](@ref).

````@example categorisation
sdai = SDAI(tjc=2, sjc=1, pga=6u"cm", ega=5.5u"cm", crp=15u"mg/L")
sdai isa ContinuousComposite
````

Well, that was expected!

Now let's see what the discrete disease activity level of this score would be.

````@example categorisation
categorise(sdai)
````

## Cutoffs

The cutoffs used per composite and category are:

| Disease activity | DAS28ESR | DAS28CRP | SDAI   | CDAI   |
|:-----------------|----------|----------|--------|--------|
| Remission        | ``<`` 2.6    | ``<`` 2.4    | ``\leq`` 3.3  | ``\leq`` 2.8  |
| Low              | ``\leq`` 3.2    | ``\leq`` 2.9    | ``\leq`` 11.0 | ``\leq`` 10.0 |
| Moderate         | ``\leq`` 5.1    | ``\leq`` 4.6    | ``\leq`` 26.0 | ``\leq`` 22.0 |
| High             | ``>`` 5.1    | ``>`` 4.6    | ``>`` 26.0 | ``>`` 22.0 |

Internally, these are saved in a `NamedTuple` which you can import with `import RheumaComposites: cutoff`.
To retrieve the cutoff for a Moderate CDAI, you would:

````@example categorisation
import RheumaComposites: cutoff
cutoff.CDAI.moderate
````

Note that this only returns the boundary value of the respective category, and that the inclusion of this value varies across **both** composites and categories.
It is therefore safest to simply rely on the `categorise` function.

An alternative way to check the cutoffs is the respective composite's documentation.
You can see this by typing `?CDAI` in the REPL.

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
