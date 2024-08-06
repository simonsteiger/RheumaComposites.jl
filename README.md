# RheumaComposites.jl

[![Build Status](https://github.com/simonsteiger/RheumaComposites.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/simonsteiger/RheumaComposites.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://simonsteiger.github.io/RheumaComposites.jl/dev/)

A Julia package for composite scores used in Rheumatology.

## Getting started

This package is not yet registered with the Julia package registry, so you have to install it via url:

```julia
import Pkg
Pkg.add(url="https://github.com/simonsteiger/RheumaComposites.jl")
```

Now you're ready to start working with composite scores:

```julia
using RheumaComposites, Unitful
das28 = DAS28ESR(t28=4, s28=3, pga=41u"mm", apr=19u"mm/hr")
score(das28)
isremission(das28)
categorise(das28)
```

Have a look at the [documentation](https://simonsteiger.github.io/RheumaComposites.jl/dev/) for more examples!

## Supported composites

This package currently supports the following composites:

| Rheumatoid Arthritis | Psoriatric Arthritis | Spondyloarthritis | Lupus | ... |
|:---------------------|:---------------------|:------------------|:------|:----|
| DAS28                |                      |                   |       | ... |
| SDAI                 |                      |                   |       | ... |
| CDAI                 |                      |                   |       | ... |
| Boolean remission    |                      |                   |       | ... |

Additional subtypes and modifications of these composites are available, e.g., the DAS28CRP or the Revised Boolean Remission.

## Contributing

If you spot a bug or want to ask for a new feature, please [open an issue](https://github.com/simonsteiger/RheumaComposites.jl/issues) on the GitHub repository.
