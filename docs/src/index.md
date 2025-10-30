````@raw html
---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: RheumaComposites.jl
  text: 
  tagline: Composite scores for Rheumatology in Julia
  image:
    src: /logo.svg
    alt: RheumaComposites
  actions:
    - theme: brand
      text: Get started
      link: /examples/basics
    - theme: alt
      text: View on Github
      link: https://github.com/simonsteiger/RheumaComposites.jl
    - theme: alt
      text: API Reference
      link: /api
---

<p style="margin-bottom:2cm"></p>

<div class="vp-doc" style="width:80%; margin:auto">
````

# What is RheumaComposites.jl?

RheumaComposites.jl leverages Julia's type system and multiple dispatch to allow you to construct and work with common composite scores in Rheumatology.

## Installation

This package is not currently registered with the Julia package registry, so you have to install it via url:

```julia
import Pkg
Pkg.add(url="https://github.com/simonsteiger/RheumaComposites.jl")
```

## Getting started

Now you're ready to start working with composite scores:

```julia
using RheumaComposites, Unitful
das28 = DAS28ESR(tjc=4, sjc=3, pga=4.1u"cm", apr=19u"mm/hr")
score(das28)
isremission(das28)
categorise(das28)
```

## Supported composites

This package currently supports the following composites:

| Rheumatoid Arthritis | Psoriatric Arthritis | Spondyloarthritis | Lupus | ... |
|:---------------------|:---------------------|:------------------|:------|:----|
| DAS28                | DAPSA                | BASDAI            |       | ... |
| SDAI                 |                      |                   |       | ... |
| CDAI                 |                      |                   |       | ... |
| Boolean remission    |                      |                   |       | ... |

Additional subtypes and modifications of these composites are available, e.g., the DAS28CRP or the Revised Boolean Remission.

## Contributing

If you spot a bug or want to ask for a new feature, please [open an issue](https://github.com/simonsteiger/RheumaComposites.jl/issues) on the GitHub repository.

````@raw html
</div>
````
