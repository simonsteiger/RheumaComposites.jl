# TODO add weighting formula to docstring
"""
    BASDAI(; tjc, sjc, pga, jpn)

Store component measures of the Bath Ankylosing Spondylitis Disease Activity Index, or BASDAI.

# Components

- `q1` fatigue or tiredness
- `q2` AS neck, back, or hip pain
- `q3` pain or swelling in other joints
- `q4` discomfort from tender areas
- `q5` morning stiffness severity
- `q6` morning stiffness duration

!!! note "Units"
    All questions are recorded on VAS scales (typically millimeters or centimeters).
    See also [`Unitful.@u_str`](@extref).

# Categories

The only cutoff I am aware of checks if a person's BASDAI is below 4. This is currently implemented in [`categorise`](@ref) and [`isremission`](@ref), making them effectively redundant.
Feel free to open an issue on the GitHub page of this package if you know about other cutoffs.

# External links

* [BASDAI calculator](https://qxmd.com/calculate/calculator_299/basdai#)

See also [`score`](@ref).
"""
struct BASDAI <: ContinuousComposite
    components::NTuple{6, Float64}
    names::NTuple{6, Symbol}
    units::NamedTuple
    function BASDAI(; q1, q2, q3, q4, q5, q6, units=BASDAI_UNITS)
        components = (; q1, q2, q3, q4, q5, q6)
        ucomponents_vals = unitfy(components, units; conversions=BASDAI_UNITS)
        ucomponents = NamedTuple{keys(components)}(ucomponents_vals)

        valid_vas.(values(ucomponents))

        names = keys(components)
        vals = ustrip.(values(ucomponents))
        return new(vals, names, BASDAI_UNITS)
    end
end

WeightingScheme(::Type{<:BASDAI}) = IsWeighted()
