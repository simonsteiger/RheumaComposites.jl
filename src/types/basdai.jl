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
    q1::Unitful.AbstractQuantity
    q2::Unitful.AbstractQuantity
    q3::Unitful.AbstractQuantity
    q4::Unitful.AbstractQuantity
    q5::Unitful.AbstractQuantity
    q6::Unitful.AbstractQuantity
    function BASDAI(;
        q1::Unitful.AbstractQuantity,
        q2::Unitful.AbstractQuantity,
        q3::Unitful.AbstractQuantity,
        q4::Unitful.AbstractQuantity,
        q5::Unitful.AbstractQuantity,
        q6::Unitful.AbstractQuantity,
    )
        valid_vas.([q1, q2, q3, q4, q5, q6])

        # Must convert because weights do not adjust to measurement
        return new(uconvert.(Ref(units.xdai_vas), [q1, q2, q3, q4, q5, q6])...)
    end
end

WeightingScheme(::Type{<:BASDAI}) = IsWeighted()
