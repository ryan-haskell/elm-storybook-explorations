module Ui.Pill exposing
    ( Pill, view
    , neutral
    , blue, green, yellow, red
    , violet, teal, pink, orange
    , disabled
    )

{-|

@docs Pill, view

@docs neutral
@docs blue, green, yellow, red
@docs violet, teal, pink, orange


## Needed by Ui.SegmentedControls

@docs disabled

-}

import Ui
import Ui.Attr
import Ui.Palette
import Ui.Typography


type Pill
    = Pill
        { fontColor : Ui.Palette.Color
        , backgroundColor : Ui.Palette.Color
        , label : String
        }


view : Pill -> Ui.Html msg
view (Pill options) =
    Ui.Typography.h150
        [ Ui.Attr.padXY.px8.zero
        , Ui.Attr.radius.px8
        , Ui.Attr.fontColor options.fontColor
        , Ui.Attr.backgroundColor options.backgroundColor
        ]
        options.label



-- PILLS


neutral : String -> Pill
neutral label =
    Pill
        { fontColor = Ui.Palette.n800
        , backgroundColor = Ui.Palette.n200
        , label = label
        }


blue : String -> Pill
blue label =
    Pill
        { fontColor = Ui.Palette.b500
        , backgroundColor = Ui.Palette.b200
        , label = label
        }


green : String -> Pill
green label =
    Pill
        { fontColor = Ui.Palette.g600
        , backgroundColor = Ui.Palette.g200
        , label = label
        }


yellow : String -> Pill
yellow label =
    Pill
        { fontColor = Ui.Palette.y600
        , backgroundColor = Ui.Palette.y100
        , label = label
        }


red : String -> Pill
red label =
    Pill
        { fontColor = Ui.Palette.r600
        , backgroundColor = Ui.Palette.r100
        , label = label
        }


violet : String -> Pill
violet label =
    Pill
        { fontColor = Ui.Palette.v500
        , backgroundColor = Ui.Palette.v100
        , label = label
        }


teal : String -> Pill
teal label =
    Pill
        { fontColor = Ui.Palette.t600
        , backgroundColor = Ui.Palette.t100
        , label = label
        }


pink : String -> Pill
pink label =
    Pill
        { fontColor = Ui.Palette.p600
        , backgroundColor = Ui.Palette.p100
        , label = label
        }


orange : String -> Pill
orange label =
    Pill
        { fontColor = Ui.Palette.o600
        , backgroundColor = Ui.Palette.o100
        , label = label
        }



-- Needed by Ui.SegmentedControl


disabled : String -> Pill
disabled label =
    Pill
        { fontColor = Ui.Palette.n0
        , backgroundColor = Ui.Palette.n400
        , label = label
        }
