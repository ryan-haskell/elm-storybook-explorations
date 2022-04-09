module Ui.Badge exposing
    ( Badge, view
    , neutral
    , blue, green, yellow, red
    , violet, teal, pink, orange
    , tick
    )

{-|

@docs Badge, view

@docs neutral
@docs blue, green, yellow, red
@docs violet, teal, pink, orange

@docs tick

-}

import Ui
import Ui.Attr
import Ui.Icon
import Ui.Palette
import Ui.Typography


type Badge
    = Badge
        { fontColor : Ui.Palette.Color
        , backgroundColor : Ui.Palette.Color
        , content : Content
        }


type Content
    = Label String
    | Icon Ui.Icon.Icon


view : Badge -> Ui.Html msg
view (Badge options) =
    let
        attrs : List (Ui.Attribute msg)
        attrs =
            [ Ui.Attr.padXY.px6.zero
            , Ui.Attr.radius.px4
            , Ui.Attr.fontColor options.fontColor
            , Ui.Attr.backgroundColor options.backgroundColor
            ]
    in
    case options.content of
        Label label ->
            Ui.Typography.h150
                [ Ui.Attr.padXY.px6.zero
                , Ui.Attr.radius.px4
                , Ui.Attr.fontColor options.fontColor
                , Ui.Attr.backgroundColor options.backgroundColor
                ]
                label

        Icon icon ->
            Ui.el
                [ Ui.Attr.width.px16
                , Ui.Attr.height.px16
                , Ui.Attr.align.center
                , Ui.Attr.radius.px4
                , Ui.Attr.fontColor options.fontColor
                , Ui.Attr.backgroundColor options.backgroundColor
                ]
                (Ui.icon.px12 icon)



-- BadgeS


neutral : String -> Badge
neutral label =
    Badge
        { fontColor = Ui.Palette.n800
        , backgroundColor = Ui.Palette.n200
        , content = Label label
        }


blue : String -> Badge
blue label =
    Badge
        { fontColor = Ui.Palette.b500
        , backgroundColor = Ui.Palette.b200
        , content = Label label
        }


green : String -> Badge
green label =
    Badge
        { fontColor = Ui.Palette.g600
        , backgroundColor = Ui.Palette.g200
        , content = Label label
        }


yellow : String -> Badge
yellow label =
    Badge
        { fontColor = Ui.Palette.y600
        , backgroundColor = Ui.Palette.y100
        , content = Label label
        }


red : String -> Badge
red label =
    Badge
        { fontColor = Ui.Palette.r600
        , backgroundColor = Ui.Palette.r100
        , content = Label label
        }


violet : String -> Badge
violet label =
    Badge
        { fontColor = Ui.Palette.v500
        , backgroundColor = Ui.Palette.v100
        , content = Label label
        }


teal : String -> Badge
teal label =
    Badge
        { fontColor = Ui.Palette.t600
        , backgroundColor = Ui.Palette.t100
        , content = Label label
        }


pink : String -> Badge
pink label =
    Badge
        { fontColor = Ui.Palette.p600
        , backgroundColor = Ui.Palette.p100
        , content = Label label
        }


orange : String -> Badge
orange label =
    Badge
        { fontColor = Ui.Palette.o600
        , backgroundColor = Ui.Palette.o100
        , content = Label label
        }


tick : Badge
tick =
    Badge
        { fontColor = Ui.Palette.g600
        , backgroundColor = Ui.Palette.g200
        , content = Icon Ui.Icon.tick
        }
