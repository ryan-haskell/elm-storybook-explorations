module Ui.Pill exposing
    ( neutral
    , blue, green, yellow, red
    , violet, teal, pink, orange
    )

{-|

@docs neutral
@docs blue, green, yellow, red
@docs violet, teal, pink, orange

-}

import Ui
import Ui.Attr
import Ui.Palette
import Ui.Typography


type Color
    = Neutral
    | Blue
    | Green
    | Yellow
    | Red
    | Violet
    | Teal
    | Pink
    | Orange


neutral : String -> Ui.Html msg
neutral label =
    view
        { fontColor = Ui.Palette.n800
        , backgroundColor = Ui.Palette.n200
        , label = label
        }


blue : String -> Ui.Html msg
blue label =
    view
        { fontColor = Ui.Palette.b500
        , backgroundColor = Ui.Palette.b200
        , label = label
        }


green : String -> Ui.Html msg
green label =
    view
        { fontColor = Ui.Palette.g600
        , backgroundColor = Ui.Palette.g200
        , label = label
        }


yellow : String -> Ui.Html msg
yellow label =
    view
        { fontColor = Ui.Palette.y600
        , backgroundColor = Ui.Palette.y100
        , label = label
        }


red : String -> Ui.Html msg
red label =
    view
        { fontColor = Ui.Palette.r600
        , backgroundColor = Ui.Palette.r100
        , label = label
        }


violet : String -> Ui.Html msg
violet label =
    view
        { fontColor = Ui.Palette.v500
        , backgroundColor = Ui.Palette.v100
        , label = label
        }


teal : String -> Ui.Html msg
teal label =
    view
        { fontColor = Ui.Palette.t600
        , backgroundColor = Ui.Palette.t100
        , label = label
        }


pink : String -> Ui.Html msg
pink label =
    view
        { fontColor = Ui.Palette.p600
        , backgroundColor = Ui.Palette.p100
        , label = label
        }


orange : String -> Ui.Html msg
orange label =
    view
        { fontColor = Ui.Palette.o600
        , backgroundColor = Ui.Palette.o100
        , label = label
        }



-- INTERNALS


view :
    { fontColor : Ui.Palette.Color
    , backgroundColor : Ui.Palette.Color
    , label : String
    }
    -> Ui.Html msg
view options =
    Ui.Typography.h150
        [ Ui.Attr.padXY.px8.zero
        , Ui.Attr.radius.px8
        , Ui.Attr.fontColor options.fontColor
        , Ui.Attr.backgroundColor options.backgroundColor
        ]
        options.label
