module Ui.Table exposing (view)

import Ui
import Ui.Attr
import Ui.Avatar
import Ui.Badge
import Ui.Icon
import Ui.Palette
import Ui.Typography


view : Ui.Html msg
view =
    let
        th : List (Ui.Html msg) -> Ui.Html msg
        th children =
            Ui.th
                [ Ui.Attr.backgroundColor Ui.Palette.n300
                , Ui.Attr.fontColor Ui.Palette.n700
                , Ui.Attr.padXY.px24.px16
                ]
                children

        td : List (Ui.Html msg) -> Ui.Html msg
        td children =
            Ui.td
                [ Ui.Attr.padXY.px24.px16
                , Ui.Attr.border.bottom.px1 Ui.Palette.n300
                ]
                children
    in
    Ui.table [ Ui.Attr.radius.px4, Ui.Attr.border.px1 Ui.Palette.n300 ]
        [ Ui.thead []
            [ th [ Ui.Typography.h100 [] "Label" ]
            , th [ Ui.Typography.h100 [] "Dropdown label" ]
            , th [ Ui.Typography.h100 [] "Label" ]
            , th []
            ]
        , Ui.tbody []
            (List.repeat 5
                (Ui.tr []
                    [ td
                        [ Ui.row
                            [ Ui.Attr.width.max.fill
                            , Ui.Attr.gap.px8
                            , Ui.Attr.align.centerY
                            ]
                            [ Ui.Avatar.viewCircle (Ui.Avatar.violet "RH")
                            , Ui.Typography.h300 [ Ui.Attr.ellipsis ]
                                "Ryan Haskell-Glatz"
                            ]
                        ]
                    , td [ Ui.Badge.view (Ui.Badge.neutral "Label") ]
                    , td [ Ui.Typography.p100 [] "Property name" ]
                    , td
                        [ Ui.el
                            [ Ui.Attr.fontColor Ui.Palette.n600
                            ]
                            (Ui.icon.px12 Ui.Icon.more)
                        ]
                    ]
                )
            )
        ]
