# Makie, CairoMakie and Colors is not a dependency of /docs!
# Change environment or install to make this work

using Makie
using CairoMakie
using Colors

# Defaults
strokewidth = 4
strokecolor = :white
data1 = [3, 4, 5]
data2 = [4, 2, 5]
data3 = [5, 3, 4]
green = parse(Colorant, "#389826")
purple = parse(Colorant, "#9658B2")
red = parse(Colorant, "#CA3C33")
blue = parse(Colorant, "#4063D8")

# TODO transparent background and aspect ratio (1:1?)
function init_pie(data, colors; offset=0, strokewidth=strokewidth, strokecolor=strokecolor)
    plt = pie(
        data,
        color=colors,
        radius=4,
        inner_radius=1.7,
        offset=offset,
        strokecolor=strokecolor,
        strokewidth=strokewidth,
        axis=(autolimitaspect=1,)
    )
    return plt
end

function add_pie!(data, colors; offset=0, strokewidth=strokewidth, strokecolor=strokecolor)
    plt = pie!(
        data,
        color=colors,
        radius=4,
        inner_radius=1.7,
        offset=offset,
        strokecolor=strokecolor,
        strokewidth=strokewidth,
    )
    return plt
end

function translate_all!(len, mod, plts...)
    plt1, plt2, plt3 = plts
    Makie.translate!(plt1, 0, len-len/mod, 0)
    Makie.translate!(plt2, len, -len, 0)
    Makie.translate!(plt3, -len, -len, 0)
    return nothing
end

f = Figure(backgroundcolor=:transparent)
ax = Axis(f[1, 1], backgroundcolor=:transparent, autolimitaspect=1)

plt1 = add_pie!(data1, [green, purple, red], offset=-0.5)
plt2 = add_pie!(data2, [green, purple, red], offset=4)
plt3 = add_pie!(data3, [purple, green, red])

translate_all!(4.3, 3.7, plt1, plt2, plt3)

hidedecorations!(ax)
hidespines!(ax)

colsize!(f.layout, 1, Aspect(1, 1.0))

resize_to_layout!(f)

f

# Assuming that the active project is docs
CairoMakie.save(joinpath(@__DIR__, "src", "assets", "logo.svg"), f)
