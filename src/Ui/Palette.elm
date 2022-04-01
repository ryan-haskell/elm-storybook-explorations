module Ui.Palette exposing
    ( Color
    , blue, dark, light
    , green, yellow, red, violet, teal, pink, orange
    , n900, n800, n700, n600, n500, n400, n300, n200, n100, n75, n50, n0
    , b600, b500, b400, b300, b200, b100, b50
    , g600, g500, g400, g300, g200, g100, g50
    , y600, y500, y400, y300, y200, y100, y50
    , r600, r500, r400, r300, r200, r100, r50
    , v600, v500, v400, v300, v200, v100, v50
    , t600, t500, t400, t300, t200, t100, t50
    , p600, p500, p400, p300, p200, p100, p50
    , o600, o500, o400, o300, o200, o100, o50
    , chartColors
    )

{-|

@docs Color


### Primary

@docs blue, dark, light


### Secondary

@docs green, yellow, red, violet, teal, pink, orange


### Neutral

@docs n900, n800, n700, n600, n500, n400, n300, n200, n100, n75, n50, n0


### Blue

@docs b600, b500, b400, b300, b200, b100, b50


### Green

@docs g600, g500, g400, g300, g200, g100, g50


### Yellow

@docs y600, y500, y400, y300, y200, y100, y50


### Red

@docs r600, r500, r400, r300, r200, r100, r50


### Violet

@docs v600, v500, v400, v300, v200, v100, v50


### Teal

@docs t600, t500, t400, t300, t200, t100, t50


### Pink

@docs p600, p500, p400, p300, p200, p100, p50


### Orange

@docs o600, o500, o400, o300, o200, o100, o50


### Charts

@docs chartColors

-}

import Css


type alias Color =
    Css.Color



-- PRIMARY


blue : Color
blue =
    b400


dark : Color
dark =
    n800


light : Color
light =
    n0



-- SECONDARY


green : Color
green =
    g400


yellow : Color
yellow =
    y400


red : Color
red =
    r400


violet : Color
violet =
    v400


teal : Color
teal =
    t400


pink : Color
pink =
    p400


orange : Color
orange =
    o400



-- NEUTRALS


n900 : Color
n900 =
    Css.hex "#101840"


n800 : Color
n800 =
    Css.hex "#474D66"


n700 : Color
n700 =
    Css.hex "#696F8C"


n600 : Color
n600 =
    Css.hex "#8F95B2"


n500 : Color
n500 =
    Css.hex "#C1C4D6"


n400 : Color
n400 =
    Css.hex "#D8DAE5"


n300 : Color
n300 =
    Css.hex "#E6E8F0"


n200 : Color
n200 =
    Css.hex "#EDEFF5"


n100 : Color
n100 =
    Css.hex "#F4F6FA"


n75 : Color
n75 =
    Css.hex "#F9FAFC"


n50 : Color
n50 =
    Css.hex "#FAFBFF"


n0 : Color
n0 =
    Css.hex "#FFFFFF"



-- BLUE


b600 : Color
b600 =
    Css.hex "#1F3D99"


b500 : Color
b500 =
    Css.hex "#2952CC"


b400 : Color
b400 =
    Css.hex "#3366FF"


b300 : Color
b300 =
    Css.hex "#9DB5FF"


b200 : Color
b200 =
    Css.hex "#D6E0FF"


b100 : Color
b100 =
    Css.hex "#EBF0FF"


b50 : Color
b50 =
    Css.hex "#F3F6FF"



-- GREEN


g600 : Color
g600 =
    Css.hex "#317159"


g500 : Color
g500 =
    Css.hex "#429777"


g400 : Color
g400 =
    Css.hex "#52BD94"


g300 : Color
g300 =
    Css.hex "#A3E6CD"


g200 : Color
g200 =
    Css.hex "#DCF2EA"


g100 : Color
g100 =
    Css.hex "#EEF8F4"


g50 : Color
g50 =
    Css.hex "#F5FBF8"



-- YELLOW


y600 : Color
y600 =
    Css.hex "#66460D"


y500 : Color
y500 =
    Css.hex "#996A13"


y400 : Color
y400 =
    Css.hex "#FFB020"


y300 : Color
y300 =
    Css.hex "#FFD079"


y200 : Color
y200 =
    Css.hex "#FFDFA6"


y100 : Color
y100 =
    Css.hex "#FFEFD2"


y50 : Color
y50 =
    Css.hex "#FFFAF1"



-- RED


r600 : Color
r600 =
    Css.hex "#7D2828"


r500 : Color
r500 =
    Css.hex "#A73636"


r400 : Color
r400 =
    Css.hex "#D14343"


r300 : Color
r300 =
    Css.hex "#EE9191"


r200 : Color
r200 =
    Css.hex "#F4B6B6"


r100 : Color
r100 =
    Css.hex "#F9DADA"


r50 : Color
r50 =
    Css.hex "#FDF4F4"



-- VIOLET


v600 : Color
v600 =
    Css.hex "#524988"


v500 : Color
v500 =
    Css.hex "#6E62B6"


v400 : Color
v400 =
    Css.hex "#897AE3"


v300 : Color
v300 =
    Css.hex "#B8AFEE"


v200 : Color
v200 =
    Css.hex "#D0CAF4"


v100 : Color
v100 =
    Css.hex "#E7E4F9"


v50 : Color
v50 =
    Css.hex "#F8F7FD"



-- TEAL


t600 : Color
t600 =
    Css.hex "#0F5156"


t500 : Color
t500 =
    Css.hex "#10899E"


t400 : Color
t400 =
    Css.hex "#25CBD6"


t300 : Color
t300 =
    Css.hex "#7CE0E6"


t200 : Color
t200 =
    Css.hex "#A8EAEF"


t100 : Color
t100 =
    Css.hex "#D3F5F7"


t50 : Color
t50 =
    Css.hex "#F2FCFD"



-- PINK


p600 : Color
p600 =
    Css.hex "#8E3374"


p500 : Color
p500 =
    Css.hex "#BE449B"


p400 : Color
p400 =
    Css.hex "#ED55C2"


p300 : Color
p300 =
    Css.hex "#F499DA"


p200 : Color
p200 =
    Css.hex "#F8BBE7"


p100 : Color
p100 =
    Css.hex "#FBDDF3"


p50 : Color
p50 =
    Css.hex "#FEF5FB"



-- ORANGE


o600 : Color
o600 =
    Css.hex "#85462B"


o500 : Color
o500 =
    Css.hex "#B25E3A"


o400 : Color
o400 =
    Css.hex "#DE7548"


o300 : Color
o300 =
    Css.hex "#EBAC91"


o200 : Color
o200 =
    Css.hex "#F2C8B6"


o100 : Color
o100 =
    Css.hex "#F8E3DA"


o50 : Color
o50 =
    Css.hex "#FDF4F4"


chartColors : List Color
chartColors =
    [ chartTeal
    , chartYellow
    , chartBlue
    , chartGreen
    , chartViolet
    , chartPink
    , chartAqua
    , chartOrange
    ]


chartTeal : Color
chartTeal =
    Css.hex "#74DDE5"


chartYellow : Color
chartYellow =
    Css.hex "#FAC86B"


chartBlue : Color
chartBlue =
    Css.hex "#678AF7"


chartGreen : Color
chartGreen =
    Css.hex "#6BDAAE"


chartViolet : Color
chartViolet =
    Css.hex "#8F59EF"


chartPink : Color
chartPink =
    Css.hex "#FD8ADC"


chartAqua : Color
chartAqua =
    Css.hex "#70B0FF"


chartOrange : Color
chartOrange =
    Css.hex "#FF9D66"
