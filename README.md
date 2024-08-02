# RheumaComposites.jl

[![Build Status](https://github.com/simonsteiger/RheumaComposites.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/simonsteiger/RheumaComposites.jl/actions/workflows/CI.yml?query=branch%3Amain)

This package implements the most common composite scores used for evaluating disease activity across different rheumatic diseases:

- DAS28ESR
- DAS28CRP
- SDAI
- CDAI
- ACR / EULAR Boolean remission
- Revised ACR / EULAR Boolean remission
- Three-item ACR / EULAR Boolean remission

In addition to composite measures, this package allows testing for further remission definitions:

- SJC28 remission
- PGA remission

## Getting started

Since this package is not currently registered with the Julia package registry, you have to install it via url:

```julia
import Pkg
Pkg.add(url="https://github.com/simonsteiger/RheumaComposites.jl")
```

## Examples

This package is effectively undocumented right now, so I hope that these basic examples give an idea of its use:

```julia
using RheumaComposites

das28 = DAS28ESR(t28=4, s28=3, pga=41u"mm", apr=19u"mm/hr");

score(das28)
# 4.24

isremission(das28)
# false
```

This package uses [Unitful.jl](https://painterqubits.github.io/Unitful.jl/stable/) to ensure correctness between different measurement systems, such as PGA measured in mm or cm or CRP measured in mg/dL or mg/L.

## Resources

Not much here yet!

The above example generalises to the other constructors, namely `DAS28CRP`, `SDAI`, `BooleanRemission`, and its modifications `revised(x::BooleanRemission)`, `threeitem(x::BooleanRemission)`.

**NOTE**: This project is a very early work in progress and far from complete. For many functions, documentation is still missing.
