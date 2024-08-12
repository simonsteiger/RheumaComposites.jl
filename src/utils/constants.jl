cont_cutoff = (
    DAS28ESR=(
        remission=2.6,
        low=3.2,
        moderate=5.1,
    ),
    DAS28CRP=(
        remission=2.4,
        low=2.9,
        moderate=4.6,
    ),
    SDAI=(
        remission=3.3,
        low=11.0,
        moderate=26.0,
    ),
    CDAI=(
        remission=2.8,
        low=10.0,
        moderate=22.0
    ),
)

bool_cutoff_funs = (
    tjc=(x; offset = 0) -> tjc(x) <= 1 + offset,
    sjc=(x; offset = 0) -> sjc(x) <= 1 + offset,
    pga=(x; offset = 0u"mm") -> pga(x) <= 10u"mm" + offset,
    crp=(x; offset = 0u"mg/dL") -> crp(x) <= 1.0u"mg/dL" + offset,
)

weights_das28esr = (
    tjc=tjc -> sqrt(tjc) * 0.56,
    sjc=sjc -> sqrt(sjc) * 0.28,
    pga=pga -> pga * 0.014,
    apr=apr -> log(apr) * 0.7,
)

weights_das28crp = (
    tjc=tjc -> sqrt(tjc) * 0.56,
    sjc=sjc -> sqrt(sjc) * 0.28,
    pga=pga -> pga * 0.014,
    apr=apr -> log1p(apr) * 0.36,
)
