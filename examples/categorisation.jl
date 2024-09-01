# # Categorising composites

# In this tutorial, we will explore how to convert continuous composites, like the DAS28ESR or SDAI, into discrete disease activity levels.

using RheumaComposites
using Unitful

# As long as the composite you are defining is a continuous composite, all you need to do is to call [`categorise`](@ref).

sdai = SDAI(tjc=2, sjc=1, pga=6u"cm", ega=5.5u"cm", crp=15u"mg/L")
sdai isa ContinuousComposite

# Well, that was expected!

# Now let's see what the discrete disease activity level of this score would be.

categorise(sdai)
#=
## Cutoffs

The cutoffs used per disease, composite score and category are listed below.

### Rheumatoid arthritis

| Disease activity | DAS28ESR | DAS28CRP | SDAI   | CDAI   | 
|:-----------------|----------|----------|--------|--------| 
| Remission        | ``<`` 2.6    | ``<`` 2.4    | ``\leq`` 3.3  | ``\leq`` 2.8  | 
| Low              | ``\leq`` 3.2    | ``\leq`` 2.9    | ``\leq`` 11.0 | ``\leq`` 10.0 | 
| Moderate         | ``\leq`` 5.1    | ``\leq`` 4.6    | ``\leq`` 26.0 | ``\leq`` 22.0 | 
| High             | ``>`` 5.1    | ``>`` 4.6    | ``>`` 26.0 | ``>`` 22.0 | 

### Psoriatic arthritis

| Disease activity | DAPSA |
|:-----------------|----------|
| Remission        | ``<`` 4.0    |
| Low              | ``\leq`` 14.0    |
| Moderate         | ``\leq`` 28.0    |
| High             | ``>`` 28.0    |

### Ankylosing spondylitis

I have not found a list of BASDAI cutoffs for disease categories.
The only threshold in use to categorise low disease activity seems to be ``\leq 4``.
=#
