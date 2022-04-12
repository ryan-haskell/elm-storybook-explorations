module Ui.Dropdown exposing (group, item, view, viewMenu)

import Ui
import Ui.Action
import Ui.Attr
import Ui.Icon
import Ui.Palette
import Ui.Select
import Ui.Typography


view :
    { placeholder : String
    , selected : Maybe value
    , toLabel : value -> String
    , onSelectArrowUp : msg
    , onSelectArrowDown : msg
    }
    -> Ui.Html msg
view options =
    Ui.Select.view
        { placeholder = options.placeholder
        , value = options.selected |> Maybe.map options.toLabel
        , error = Nothing
        , isDisabled = False
        , onArrowUp = options.onSelectArrowUp
        , onArrowDown = options.onSelectArrowDown
        }


viewMenu :
    { menuId : String
    , selected : Maybe value
    , items : List (Item value)
    , toLabel : value -> String
    , searchInputValue : String
    , onOptionClicked : value -> msg
    , onSearchInputChanged : String -> msg
    }
    -> Ui.Html msg
viewMenu options =
    let
        viewMenuItem : Int -> Item value -> Ui.Html msg
        viewMenuItem index item_ =
            case item_ of
                Group label ->
                    Ui.Typography.h200
                        [ Ui.Attr.fontColor Ui.Palette.n600
                        , Ui.Attr.backgroundColor Ui.Palette.n0
                        , Ui.Attr.padXY.px12.px8
                        ]
                        label

                Option value ->
                    let
                        isSelected : Bool
                        isSelected =
                            Just value == options.selected

                        backgroundColor : Ui.Attribute msg
                        backgroundColor =
                            if isSelected then
                                Ui.Attr.backgroundColor Ui.Palette.b100

                            else
                                Ui.Attr.list
                                    [ Ui.Attr.backgroundColor Ui.Palette.n0
                                    , Ui.Attr.whenHovered
                                        [ Ui.Attr.backgroundColor Ui.Palette.n50
                                        ]
                                    ]

                        fontColor : Ui.Attribute msg
                        fontColor =
                            if isSelected then
                                Ui.Attr.fontColor Ui.Palette.b400

                            else
                                Ui.Attr.fontColor Ui.Palette.n800

                        border : Ui.Attribute msg
                        border =
                            if isSelected then
                                Ui.Attr.border.left.px2 Ui.Palette.b400

                            else
                                Ui.Attr.border.left.px2 Ui.Palette.transparent
                    in
                    Ui.clickable (Ui.Action.fromMsg (options.onOptionClicked value))
                        [ backgroundColor
                        , border
                        , Ui.Attr.padXY.px12.px8
                        , Ui.Attr.cursor.pointer
                        , Ui.Attr.whenFocused
                            [ Ui.Attr.outline.px2 Ui.Palette.b200
                            , Ui.Attr.relative
                            ]
                        , Ui.Attr.id (options.menuId ++ "__option-" ++ String.fromInt index)
                        ]
                        (Ui.Typography.p100
                            [ fontColor
                            ]
                            (options.toLabel value)
                        )

        viewMenuOptions : Ui.Html msg
        viewMenuOptions =
            Ui.col [ Ui.Attr.gap.px1 ]
                (List.indexedMap viewMenuItem options.items)

        viewSearchInput : Ui.Html msg
        viewSearchInput =
            Ui.row []
                [ Ui.el
                    [ Ui.Attr.absolute
                    , Ui.Attr.z2
                    , Ui.Attr.fontColor Ui.Palette.n600
                    , Ui.Attr.padXY.px12.zero
                    , Ui.Attr.height.px32
                    , Ui.Attr.align.center
                    , Ui.Attr.pointerEventsNone
                    ]
                    (Ui.icon.px12 Ui.Icon.search)
                , Ui.input
                    [ Ui.Attr.backgroundColor Ui.Palette.n0
                    , Ui.Attr.padTop.px8
                    , Ui.Attr.padBottom.px8
                    , Ui.Attr.padLeft.px32
                    , Ui.Attr.padRight.px16
                    , Ui.Attr.typography
                        { fontSize = 12
                        , lineHeight = 16
                        , weight = Ui.Attr.Regular
                        , color = Ui.Palette.n700
                        , families = Ui.Attr.SansSerif
                        }
                    , Ui.Attr.whenFocused
                        [ Ui.Attr.outline.px2 Ui.Palette.b200
                        , Ui.Attr.relative
                        , Ui.Attr.z1
                        ]
                    , Ui.Attr.id (options.menuId ++ "__search")
                    ]
                    { placeholder = "Search by name"
                    , value = options.searchInputValue
                    , onInput = options.onSearchInputChanged
                    }
                ]
    in
    Ui.el
        [ Ui.Attr.padTop.px4
        ]
        (Ui.col
            [ Ui.Attr.backgroundColor Ui.Palette.n300
            , Ui.Attr.radius.px4
            , Ui.Attr.border.px1 Ui.Palette.n300
            , Ui.Attr.elevation.level2
            , Ui.Attr.gap.px1
            , Ui.Attr.width.fill
            , Ui.Attr.align.below
            , Ui.Attr.height.max.px273
            , Ui.Attr.scroll
            ]
            [ viewSearchInput
            , viewMenuOptions
            ]
        )


type Item value
    = Group String
    | Option value


group : String -> Item value
group string =
    Group string


item : value -> Item value
item value =
    Option value
