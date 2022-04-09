module Ui.Checkbox exposing (State(..), view)

import Ui
import Ui.Action
import Ui.Attr exposing (isDisabled)
import Ui.Icon
import Ui.Palette
import Ui.Typography


type State
    = Selected
    | Indeterminate
    | Unselected


view :
    { state : State
    , label : String
    , onClick : State -> msg
    , isDisabled : Bool
    }
    -> Ui.Html msg
view options =
    Ui.row [ Ui.Attr.align.center, Ui.Attr.gap.px12 ]
        [ viewCheckboxIcon options
        , Ui.Typography.p200 [] options.label
        ]


viewCheckboxIcon : { options | isDisabled : Bool, state : State, onClick : State -> msg } -> Ui.Html msg
viewCheckboxIcon options =
    let
        viewIcon : Ui.Html msg
        viewIcon =
            case options.state of
                Unselected ->
                    Ui.none

                Indeterminate ->
                    Ui.icon.px12 Ui.Icon.smallMinus

                Selected ->
                    Ui.icon.px12 Ui.Icon.tick

        nextCheckboxState : State
        nextCheckboxState =
            case options.state of
                Unselected ->
                    Selected

                Indeterminate ->
                    Selected

                Selected ->
                    Unselected

        stateBasedAttributes : List (Ui.Attribute msg)
        stateBasedAttributes =
            case options.state of
                Unselected ->
                    [ Ui.Attr.backgroundColor Ui.Palette.n0
                    , Ui.Attr.border.px1 Ui.Palette.n400
                    , Ui.Attr.whenHovered
                        [ Ui.Attr.border.px1 Ui.Palette.n600
                        ]
                    , Ui.Attr.whenPressed
                        [ Ui.Attr.backgroundColor Ui.Palette.n100
                        , Ui.Attr.border.px1 Ui.Palette.n500
                        ]
                    , Ui.Attr.whenFocused
                        [ Ui.Attr.outline.px2 Ui.Palette.b200
                        ]
                    , Ui.Attr.whenDisabled
                        [ Ui.Attr.border.none
                        ]
                    ]

                Indeterminate ->
                    [ Ui.Attr.backgroundColor Ui.Palette.b400
                    , Ui.Attr.whenHovered
                        [ Ui.Attr.backgroundColor Ui.Palette.b500
                        ]
                    , Ui.Attr.whenPressed [ Ui.Attr.backgroundColor Ui.Palette.b600 ]
                    , Ui.Attr.whenFocused [ Ui.Attr.outline.px2 Ui.Palette.b200 ]
                    ]

                Selected ->
                    [ Ui.Attr.backgroundColor Ui.Palette.b400
                    , Ui.Attr.whenHovered
                        [ Ui.Attr.backgroundColor Ui.Palette.b500
                        ]
                    , Ui.Attr.whenPressed [ Ui.Attr.backgroundColor Ui.Palette.b600 ]
                    , Ui.Attr.whenFocused [ Ui.Attr.outline.px2 Ui.Palette.b200 ]
                    ]
    in
    Ui.clickable (Ui.Action.fromMsg (options.onClick nextCheckboxState))
        [ Ui.Attr.width.px16
        , Ui.Attr.height.px16
        , Ui.Attr.align.center
        , Ui.Attr.radius.px4
        , Ui.Attr.fontColor Ui.Palette.n0
        , Ui.Attr.cursor.pointer
        , Ui.Attr.isDisabled options.isDisabled
        , Ui.Attr.whenDisabled
            [ Ui.Attr.fontColor Ui.Palette.n500
            , Ui.Attr.backgroundColor Ui.Palette.n100
            , Ui.Attr.cursor.disabled
            ]
        , Ui.Attr.list stateBasedAttributes
        ]
        viewIcon
