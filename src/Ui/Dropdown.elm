module Ui.Dropdown exposing (group, item, view)

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
    , items : List (Item value)
    , toLabel : value -> String
    , searchInputValue : String
    , isMenuOpen : Bool
    , onSelectClicked : msg
    , onOptionClicked : value -> msg
    , onSearchInputChanged : String -> msg
    , onSelectSpacebar : msg
    , onSelectArrowUp : msg
    , onSelectArrowDown : msg
    }
    -> Ui.Html msg
view options =
    let
        viewSelectInput : Ui.Html msg
        viewSelectInput =
            Ui.Select.view
                { placeholder = options.placeholder
                , value = options.selected |> Maybe.map options.toLabel
                , error = Nothing
                , onClick = options.onSelectClicked
                , isDisabled = False
                , onArrowUp = options.onSelectArrowUp
                , onArrowDown = options.onSelectArrowDown
                }

        viewItem : String -> Int -> Item value -> Ui.Html msg
        viewItem menuId index item_ =
            case item_ of
                Group label ->
                    Ui.Typography.h200
                        [ Ui.Attr.fontColor Ui.Palette.n600
                        , Ui.Attr.backgroundColor Ui.Palette.n0
                        , Ui.Attr.padXY.px12.px8
                        ]
                        label

                Option value ->
                    Ui.clickable (Ui.Action.fromMsg (options.onOptionClicked value))
                        [ Ui.Attr.backgroundColor Ui.Palette.n0
                        , Ui.Attr.padXY.px12.px8
                        , Ui.Attr.cursor.pointer
                        , Ui.Attr.whenFocused
                            [ Ui.Attr.outline.px2 Ui.Palette.b200
                            , Ui.Attr.relative
                            ]
                        , Ui.Attr.id (menuId ++ "__option-" ++ String.fromInt index)
                        ]
                        (Ui.Typography.p100
                            [ Ui.Attr.fontColor Ui.Palette.n800
                            ]
                            (options.toLabel value)
                        )

        viewMenu : String -> Ui.Html msg
        viewMenu menuId =
            Ui.el
                [ Ui.Attr.padTop.px8
                ]
                (Ui.col
                    [ Ui.Attr.backgroundColor Ui.Palette.n300
                    , Ui.Attr.radius.px4
                    , Ui.Attr.border.px1 Ui.Palette.n300
                    , Ui.Attr.elevation.level2
                    , Ui.Attr.gap.px1
                    , Ui.Attr.absolute
                    , Ui.Attr.width.fill
                    , Ui.Attr.align.below
                    ]
                    [ viewSearchInput menuId
                    , viewMenuOptions menuId
                    ]
                )

        viewMenuOptions : String -> Ui.Html msg
        viewMenuOptions menuId =
            Ui.col [ Ui.Attr.gap.px1 ] (List.indexedMap (viewItem menuId) options.items)

        viewSearchInput : String -> Ui.Html msg
        viewSearchInput menuId =
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
                    , Ui.Attr.id (menuId ++ "__search")
                    ]
                    { placeholder = "Search by name"
                    , value = options.searchInputValue
                    , onInput = options.onSearchInputChanged
                    }
                ]
    in
    Ui.col [ Ui.Attr.relative ]
        [ viewSelectInput
        , if options.isMenuOpen then
            viewMenu "1"
            -- TODO: Pass this in from elm-layers

          else
            Ui.none
        ]


type Item value
    = Group String
    | Option value


group : String -> Item value
group string =
    Group string


item : value -> Item value
item value =
    Option value
