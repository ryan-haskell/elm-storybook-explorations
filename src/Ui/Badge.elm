module Ui.Badge exposing
    ( Badge, view
    , neutral
    , blue, green, yellow, red
    , violet, teal, pink, orange
    )

{-|

@docs Badge, view

@docs neutral
@docs blue, green, yellow, red
@docs violet, teal, pink, orange

-}

import Ui
import Ui.Attr
import Ui.Palette
import Ui.Typography


type Badge
    = Badge
        { fontColor : Ui.Palette.Color
        , backgroundColor : Ui.Palette.Color
        , label : String
        }


view : Badge -> Ui.Html msg
view (Badge options) =
    Ui.Typography.h150
        [ Ui.Attr.padXY.px6.zero
        , Ui.Attr.radius.px4
        , Ui.Attr.fontColor options.fontColor
        , Ui.Attr.backgroundColor options.backgroundColor
        ]
        options.label



-- BadgeS


neutral : String -> Badge
neutral label =
    Badge
        { fontColor = Ui.Palette.n800
        , backgroundColor = Ui.Palette.n200
        , label = label
        }


blue : String -> Badge
blue label =
    Badge
        { fontColor = Ui.Palette.b500
        , backgroundColor = Ui.Palette.b200
        , label = label
        }


green : String -> Badge
green label =
    Badge
        { fontColor = Ui.Palette.g600
        , backgroundColor = Ui.Palette.g200
        , label = label
        }


yellow : String -> Badge
yellow label =
    Badge
        { fontColor = Ui.Palette.y600
        , backgroundColor = Ui.Palette.y100
        , label = label
        }


red : String -> Badge
red label =
    Badge
        { fontColor = Ui.Palette.r600
        , backgroundColor = Ui.Palette.r100
        , label = label
        }


violet : String -> Badge
violet label =
    Badge
        { fontColor = Ui.Palette.v500
        , backgroundColor = Ui.Palette.v100
        , label = label
        }


teal : String -> Badge
teal label =
    Badge
        { fontColor = Ui.Palette.t600
        , backgroundColor = Ui.Palette.t100
        , label = label
        }


pink : String -> Badge
pink label =
    Badge
        { fontColor = Ui.Palette.p600
        , backgroundColor = Ui.Palette.p100
        , label = label
        }


orange : String -> Badge
orange label =
    Badge
        { fontColor = Ui.Palette.o600
        , backgroundColor = Ui.Palette.o100
        , label = label
        }
