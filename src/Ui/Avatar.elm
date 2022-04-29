module Ui.Avatar exposing
    ( Avatar, viewCircle
    , neutral
    , blue, green, yellow, red
    , violet, teal, pink, orange
    )

{-|

@docs Avatar, viewCircle

@docs neutral
@docs blue, green, yellow, red
@docs violet, teal, pink, orange

-}

import Ui
import Ui.Attr
import Ui.Palette
import Ui.Typography


type Avatar
    = Avatar
        { fontColor : Ui.Palette.Color
        , backgroundColor : Ui.Palette.Color
        , label : String
        }


viewCircle : Avatar -> Ui.Html msg
viewCircle (Avatar options) =
    Ui.Typography.p100
        [ Ui.Attr.width.px32
        , Ui.Attr.height.px32
        , Ui.Attr.radius.circle
        , Ui.Attr.align.center
        , Ui.Attr.fontColor options.fontColor
        , Ui.Attr.backgroundColor options.backgroundColor
        ]
        options.label



-- AvatarS


neutral : String -> Avatar
neutral label =
    Avatar
        { fontColor = Ui.Palette.n800
        , backgroundColor = Ui.Palette.n200
        , label = label
        }


blue : String -> Avatar
blue label =
    Avatar
        { fontColor = Ui.Palette.b500
        , backgroundColor = Ui.Palette.b200
        , label = label
        }


green : String -> Avatar
green label =
    Avatar
        { fontColor = Ui.Palette.g600
        , backgroundColor = Ui.Palette.g200
        , label = label
        }


yellow : String -> Avatar
yellow label =
    Avatar
        { fontColor = Ui.Palette.y600
        , backgroundColor = Ui.Palette.y100
        , label = label
        }


red : String -> Avatar
red label =
    Avatar
        { fontColor = Ui.Palette.r600
        , backgroundColor = Ui.Palette.r100
        , label = label
        }


violet : String -> Avatar
violet label =
    Avatar
        { fontColor = Ui.Palette.v500
        , backgroundColor = Ui.Palette.v100
        , label = label
        }


teal : String -> Avatar
teal label =
    Avatar
        { fontColor = Ui.Palette.t600
        , backgroundColor = Ui.Palette.t100
        , label = label
        }


pink : String -> Avatar
pink label =
    Avatar
        { fontColor = Ui.Palette.p600
        , backgroundColor = Ui.Palette.p100
        , label = label
        }


orange : String -> Avatar
orange label =
    Avatar
        { fontColor = Ui.Palette.o600
        , backgroundColor = Ui.Palette.o100
        , label = label
        }
