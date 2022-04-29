module Ui.Table exposing (view)

import Ui
import Ui.Attr
import Ui.Palette
import Ui.Table.Column
import Ui.Typography


view :
    { columns : List (Ui.Table.Column.Column item)
    , items : List item
    }
    -> Ui.Html msg
view options =
    let
        -- HEADER
        viewTableHeader : Ui.Html msg
        viewTableHeader =
            Ui.thead [] (List.map viewTableHeaderCell options.columns)

        viewTableHeaderCell : Ui.Table.Column.Column item -> Ui.Html msg
        viewTableHeaderCell column =
            Ui.th
                [ Ui.Attr.backgroundColor Ui.Palette.n300
                , Ui.Attr.fontColor Ui.Palette.n700
                , Ui.Attr.padXY.px24.px16
                , Ui.Attr.sticky.top
                ]
                [ Ui.Typography.h100 [] (Ui.Table.Column.toLabel column) ]

        -- BODY
        viewTableBody : Ui.Html msg
        viewTableBody =
            Ui.tbody [] (List.map viewTableRow options.items)

        viewTableRow : item -> Ui.Html msg
        viewTableRow item =
            Ui.tr [] (List.map (viewTableCell item) options.columns)

        viewTableCell : item -> Ui.Table.Column.Column item -> Ui.Html msg
        viewTableCell item column =
            Ui.td
                [ Ui.Attr.padXY.px24.px16
                , Ui.Attr.border.bottom.px1 Ui.Palette.n300
                ]
                [ Ui.Table.Column.view item column
                ]
    in
    Ui.table
        [ Ui.Attr.radius.px4
        , Ui.Attr.border.px1 Ui.Palette.n300
        , Ui.Attr.scroll
        ]
        [ viewTableHeader
        , viewTableBody
        ]
