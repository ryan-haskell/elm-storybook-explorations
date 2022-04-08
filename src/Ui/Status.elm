module Ui.Status exposing
    ( neutral
    , blue, green, yellow, red
    , cross, tick
    )

{-|

@docs neutral
@docs blue, green, yellow, red
@docs cross, tick

-}

import Ui
import Ui.Attr
import Ui.Icon
import Ui.Palette
import Ui.Typography


neutral : String -> Ui.Html msg
neutral label =
    view
        { color = Ui.Palette.n500
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


blue : String -> Ui.Html msg
blue label =
    view
        { color = Ui.Palette.b400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


green : String -> Ui.Html msg
green label =
    view
        { color = Ui.Palette.g400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


yellow : String -> Ui.Html msg
yellow label =
    view
        { color = Ui.Palette.y400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


red : String -> Ui.Html msg
red label =
    view
        { color = Ui.Palette.r400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


cross : String -> Ui.Html msg
cross label =
    view
        { color = Ui.Palette.r400
        , icon = Ui.Icon.cross
        , label = label
        , gap = Ui.Attr.gap.px8
        }


tick : String -> Ui.Html msg
tick label =
    view
        { color = Ui.Palette.g400
        , icon = Ui.Icon.tick
        , label = label
        , gap = Ui.Attr.gap.px8
        }



-- INTERNALS


view :
    { color : Ui.Palette.Color
    , icon : Ui.Icon.Icon
    , label : String
    , gap : Ui.Attribute msg
    }
    -> Ui.Html msg
view options =
    Ui.row [ options.gap, Ui.Attr.align.center ]
        [ Ui.el [ Ui.Attr.fontColor options.color ] (Ui.icon.px16 options.icon)
        , Ui.Typography.p200 [] options.label
        ]
