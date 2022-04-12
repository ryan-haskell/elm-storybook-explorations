module Ui.Select exposing (view)

import Ui
import Ui.Action
import Ui.Attr
import Ui.Icon
import Ui.Palette
import Ui.Typography


view :
    { placeholder : String
    , value : Maybe String
    , error : Maybe String
    , buttonId : Maybe String
    , isDisabled : Bool
    , onClick : msg
    , onArrowUp : msg
    , onArrowDown : msg
    }
    -> Ui.Html msg
view options =
    let
        isFilledIn : Bool
        isFilledIn =
            options.value /= Nothing

        hasAnError : Bool
        hasAnError =
            options.error /= Nothing

        label : String
        label =
            case options.value of
                Just value ->
                    value

                Nothing ->
                    options.placeholder

        borderWhenValid : Ui.Palette.Color -> Ui.Attribute msg
        borderWhenValid color =
            if hasAnError then
                Ui.Attr.border.px1 Ui.Palette.r400

            else
                Ui.Attr.border.px1 color

        viewSelectInput : Ui.Html msg
        viewSelectInput =
            Ui.clickable (Ui.Action.fromMsg options.onClick)
                [ borderWhenValid Ui.Palette.n400
                , Ui.Attr.backgroundColor Ui.Palette.n0
                , case options.buttonId of
                    Just id ->
                        Ui.Attr.id id

                    Nothing ->
                        Ui.Attr.none
                , if isFilledIn then
                    Ui.Attr.fontColor Ui.Palette.n800

                  else
                    Ui.Attr.fontColor Ui.Palette.n600
                , Ui.Attr.radius.px4
                , Ui.Attr.cursor.pointer
                , Ui.Attr.isDisabled options.isDisabled
                , Ui.Attr.whenHovered
                    [ borderWhenValid Ui.Palette.n600
                    , Ui.Attr.fontColor Ui.Palette.n700
                    ]
                , Ui.Attr.whenPressed []
                , Ui.Attr.whenFocused
                    [ borderWhenValid Ui.Palette.b300
                    , Ui.Attr.fontColor Ui.Palette.n700
                    , if hasAnError then
                        Ui.Attr.outline.px2 Ui.Palette.r200

                      else
                        Ui.Attr.outline.px2 Ui.Palette.b200
                    ]
                , Ui.Attr.whenDisabled
                    [ Ui.Attr.cursor.disabled
                    , Ui.Attr.backgroundColor Ui.Palette.n100
                    , Ui.Attr.border.px1 Ui.Palette.n300
                    , Ui.Attr.fontColor Ui.Palette.n600
                    ]
                , Ui.Attr.onKeyPressed.arrowUp options.onArrowUp
                , Ui.Attr.onKeyPressed.arrowDown options.onArrowDown
                ]
                (Ui.row
                    [ Ui.Attr.width.px216
                    , Ui.Attr.height.px32
                    , Ui.Attr.padLeft.px12
                    , Ui.Attr.padRight.px6
                    , Ui.Attr.align.centerY
                    , Ui.Attr.gap.fill
                    ]
                    [ Ui.Typography.p100
                        [ Ui.Attr.inherit.fontColor ]
                        label
                    , Ui.el
                        [ Ui.Attr.fontColor Ui.Palette.n600
                        , Ui.Attr.backgroundColor Ui.Palette.n100
                        , Ui.Attr.radius.px4
                        , Ui.Attr.width.px20
                        , Ui.Attr.align.center
                        , Ui.Attr.height.px20
                        ]
                        (Ui.icon.px12 Ui.Icon.caretDown)
                    ]
                )

        viewErrorMessage : String -> Ui.Html msg
        viewErrorMessage error =
            Ui.Typography.p100 [ Ui.Attr.fontColor Ui.Palette.r400 ] error
    in
    case options.error of
        Just error ->
            Ui.col [ Ui.Attr.gap.px4 ] [ viewSelectInput, viewErrorMessage error ]

        Nothing ->
            viewSelectInput
