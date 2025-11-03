# RheumaComposites.jl

[![Build Status](https://github.com/simonsteiger/RheumaComposites.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/simonsteiger/RheumaComposites.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://simonsteiger.github.io/RheumaComposites.jl/dev/)
[![codecov](https://codecov.io/gh/simonsteiger/RheumaComposites.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/simonsteiger/RheumaComposites.jl)

A Julia package for composite scores used in Rheumatology.

## Getting started

All you need to get started are some appropriately formatted measurements, then plug them into the composite score you'd like to work with:

```julia
using RheumaComposites, Unitful
das28 = DAS28ESR(tjc=4, sjc=3, pga=4.1u"cm", apr=19u"mm/hr")
score(das28)
isremission(das28)
categorise(das28)
```

Have a look at the [documentation](https://simonsteiger.github.io/RheumaComposites.jl/dev/) for more examples!

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
