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

const weights_das28esr = (
    tjc=tjc -> sqrt(tjc) * 0.56,
    sjc=sjc -> sqrt(sjc) * 0.28,
    pga=pga -> pga * 0.014,
    apr=apr -> log(apr) * 0.7,
)

const weights_das28crp = (
    tjc=tjc -> sqrt(tjc) * 0.56,
    sjc=sjc -> sqrt(sjc) * 0.28,
    pga=pga -> pga * 0.014,
    apr=apr -> log1p(apr) * 0.36,
)

const weights_basdai = (
    q1=q1 -> q1 * 0.2,
    q2=q2 -> q2 * 0.2,
    q3=q3 -> q3 * 0.2,
    q4=q4 -> q4 * 0.2,
    q5=q5 -> q5 * 0.1,
    q6=q6 -> q6 * 0.1,
)

# New implementation, the old should stay for the time being

const DAS28ESR_REMISSION = 2.6
const DAS28ESR_LOW = 3.2
const DAS28ESR_MODERATE = 5.1

const DAS28CRP_REMISSION = 2.4
const DAS28CRP_LOW = 2.9
const DAS28CRP_MODERATE =4.6

const SDAI_REMISSION = 3.3
const SDAI_LOW = 11.0
const SDAI_MODERATE = 26.0

const CDAI_REMISSION = 2.8
const CDAI_LOW = 10.0
const CDAI_MODERATE = 22.0

const DAPSA_REMISSION = 4.0
const DAPSA_LOW = 14.0
const DAPSA_MODERATE = 28.0

const BASDAI_REMISSION = 4.0
