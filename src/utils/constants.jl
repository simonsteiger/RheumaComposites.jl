cutoff = (
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
        moderate=22.0,
    ),
    DAPSA=(
        remission=4.0,
        low=14.0,
        moderate=28.0,
    ),
    BASDAI=(
        # are there cutoffs other than "less than 4"?
        remission=4,
    ),
    BooleanRemission=(
        tjc=1,
        sjc=1,
        pga=10u"mm",
        crp=1.0u"mg/dL",
    ),
)

bool_cutoff_funs = (
    tjc=(x; offset = 0) -> x.tjc <= cutoff.BooleanRemission.tjc + offset,
    sjc=(x; offset = 0) -> x.sjc <= cutoff.BooleanRemission.sjc + offset,
    pga=(x; offset = 0u"mm") -> x.pga <= cutoff.BooleanRemission.pga + offset,
    crp=(x; offset = 0u"mg/dL") -> x.crp <= cutoff.BooleanRemission.crp + offset,
)

# TODO add a check that asserts that all continuous composites have an entry here
cont_cutoff_funs = (
    DAS28ESR=(
        remission=(x) -> x < cutoff.DAS28ESR.remission,
        low=(x) -> x <= cutoff.DAS28ESR.low,
        moderate=(x) -> x <= cutoff.DAS28ESR.moderate,
        high=(x) -> x > cutoff.DAS28ESR.moderate,
    ),
    DAS28CRP=(
        remission=(x) -> x < cutoff.DAS28CRP.remission,
        low=(x) -> x <= cutoff.DAS28CRP.low,
        moderate=(x) -> x <= cutoff.DAS28CRP.moderate,
        high=(x) -> x > cutoff.DAS28CRP.moderate,
    ),
    SDAI=(
        remission=(x) -> x <= cutoff.SDAI.remission,
        low=(x) -> x <= cutoff.SDAI.low,
        moderate=(x) -> x <= cutoff.SDAI.moderate,
        high=(x) -> x > cutoff.SDAI.moderate,
    ),
    CDAI=(
        remission=(x) -> x <= cutoff.CDAI.remission,
        low=(x) -> x <= cutoff.CDAI.low,
        moderate=(x) -> x <= cutoff.CDAI.moderate,
        high=(x) -> x > cutoff.CDAI.moderate,
    ),
    DAPSA=(
        remission=(x) -> x <= cutoff.DAPSA.remission,
        low=(x) -> x <= cutoff.DAPSA.low,
        moderate=(x) -> x <= cutoff.DAPSA.moderate,
        high=(x) -> x > cutoff.DAPSA.moderate,
    ),
    BASDAI=(remission=(x) -> x <= cutoff.BASDAI.remission,),
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

weights_basdai = (
    q1=q1 -> q1 * 0.2,
    q2=q2 -> q2 * 0.2,
    q3=q3 -> q3 * 0.2,
    q4=q4 -> q4 * 0.2,
    q5=q5 -> q5 * 0.1,
    q6=q6 -> q6 * 0.1,
)
