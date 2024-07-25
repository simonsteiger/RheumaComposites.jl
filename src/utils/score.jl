"""
    score(c::T; digits=3)

Calculate the value of an `Composite` and optionally round the result to a specific number of digits.
   
> For more detail on the formulas, see the following links:
> - DAS28: https://www.4s-dawn.com/DAS28/.

# Example

```julia-repl
julia> score(DAS28ESR(4, 2, 64, 44))
> 5.061
```
"""
score(x::AbstractComposite; digits=3) = round(intercept(x) + sum(weight(x)), digits=digits)
