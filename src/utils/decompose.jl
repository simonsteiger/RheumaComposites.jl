function decompose(x::ContinuousComposite)
    ratios = float.(weight(x) ./ sum(weight(x)))
    fields = fieldnames(typeof(x))
    return NamedTuple{fields}(ratios)
end
