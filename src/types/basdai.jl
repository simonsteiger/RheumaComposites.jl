# TODO add weighting formula to docstring
"""
    BASDAI(; tjc, sjc, pga, jpn[; units])

Store component measures of the Bath Ankylosing Spondylitis Disease Activity Index, or BASDAI.

Optionally specify the units for each component using [`Unitful.@u_str`](@extref).

# Components

- `q1` (cm) fatigue or tiredness
- `q2` (cm) AS neck, back, or hip pain
- `q3` (cm) pain or swelling in other joints
- `q4` (cm) discomfort from tender areas
- `q5` (cm) morning stiffness severity
- `q6` (cm) morning stiffness duration

# Categories

The only cutoff I am aware of checks if a person's BASDAI is below 4. This is currently implemented in [`categorise`](@ref) and [`isremission`](@ref), making them effectively redundant.
Feel free to open an issue on the GitHub page of this package if you know about other cutoffs.

# External links

* [BASDAI calculator](https://qxmd.com/calculate/calculator_299/basdai#)

See also [`score`](@ref).
"""
struct BASDAI <: ContinuousComposite
    values::NTuple{6, Float64}
    names::NTuple{6, Symbol}
    units::NamedTuple
    function BASDAI(; q1, q2, q3, q4, q5, q6, units=BASDAI_UNITS)
        ntvals = (; q1, q2, q3, q4, q5, q6)
        uvals = unitfy(ntvals, units; conversions=BASDAI_UNITS)
        ucomponents = NamedTuple{keys(ntvals)}(uvals)

        valid_vas.(values(ucomponents))

        names = keys(ntvals)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, BASDAI_UNITS)
    end
end

WeightingScheme(::Type{<:BASDAI}) = IsWeighted()
