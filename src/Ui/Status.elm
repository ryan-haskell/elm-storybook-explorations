module Ui.Status exposing
    ( Status, view
    , neutral
    , blue, green, yellow, red
    , cross, tick
    , viewH300, disabled
    )

{-|

@docs Status, view

@docs neutral
@docs blue, green, yellow, red
@docs cross, tick


### Needed by Ui.SegmentedControl

@docs viewH300, disabled

-}

import Ui
import Ui.Attr
import Ui.Icon
import Ui.Palette
import Ui.Typography


type Status
    = Status
        { color : Ui.Palette.Color
        , icon : Ui.Icon.Icon
        , label : String
        , gap : Ui.Attribute Never
        }


view : Status -> Ui.Html msg
view status =
    viewWith (Ui.Typography.p200 []) status



-- STATUSES


neutral : String -> Status
neutral label =
    Status
        { color = Ui.Palette.n500
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


blue : String -> Status
blue label =
    Status
        { color = Ui.Palette.b400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


green : String -> Status
green label =
    Status
        { color = Ui.Palette.g400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


yellow : String -> Status
yellow label =
    Status
        { color = Ui.Palette.y400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


red : String -> Status
red label =
    Status
        { color = Ui.Palette.r400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }


cross : String -> Status
cross label =
    Status
        { color = Ui.Palette.r400
        , icon = Ui.Icon.cross
        , label = label
        , gap = Ui.Attr.gap.px8
        }


tick : String -> Status
tick label =
    Status
        { color = Ui.Palette.g400
        , icon = Ui.Icon.tick
        , label = label
        , gap = Ui.Attr.gap.px8
        }



-- NEEDED BY Ui.SegmentedControl


viewH300 : List (Ui.Attribute msg) -> Status -> Ui.Html msg
viewH300 attrs status =
    viewWith (Ui.Typography.h300 attrs) status


disabled : String -> Status
disabled label =
    Status
        { color = Ui.Palette.n400
        , icon = Ui.Icon.dot
        , label = label
        , gap = Ui.Attr.gap.px4
        }



-- INTERNALS


viewWith : (String -> Ui.Html msg) -> Status -> Ui.Html msg
viewWith viewLabel (Status options) =
    Ui.row [ Ui.Attr.map never options.gap, Ui.Attr.align.center ]
        [ Ui.el [ Ui.Attr.fontColor options.color ] (Ui.icon.px16 options.icon)
        , viewLabel options.label
        ]
