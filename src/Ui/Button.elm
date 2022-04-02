module Ui.Button exposing
    ( view
    , Option
    , primary, secondary, minimal, error
    , iconLeft, iconRight
    )

{-|

@docs view

@docs Option
@docs primary, secondary, minimal, error
@docs iconLeft, iconRight

-}

import Ui
import Ui.Attr
import Ui.Icon
import Ui.Palette
import Ui.Transition
import Ui.Typography


view : List (Option msg) -> String -> Ui.Html msg
view options label =
    let
        settings : Settings
        settings =
            fromOptionsToSettings options

        commonAttrs : List (Ui.Attribute msg)
        commonAttrs =
            [ Ui.Attr.padXY.px16.px8
            , Ui.Attr.wrap.none
            , Ui.Attr.radius.px4
            , Ui.Attr.cursor.pointer
            , Ui.Attr.align.center
            , Ui.Attr.transition.ms100
                [ Ui.Transition.borderColor
                , Ui.Transition.background
                , Ui.Transition.fontColor
                ]
            ]

        styleAttrs : List (Ui.Attribute msg)
        styleAttrs =
            case settings.style of
                Primary ->
                    [ Ui.Attr.fontColor Ui.Palette.light
                    , Ui.Attr.backgroundColor Ui.Palette.b400
                    , Ui.Attr.whenDisabled
                        [ Ui.Attr.backgroundColor Ui.Palette.b200
                        ]
                    , Ui.Attr.whenHovered
                        [ Ui.Attr.backgroundColor Ui.Palette.b500
                        ]
                    , Ui.Attr.whenPressed
                        [ Ui.Attr.backgroundColor Ui.Palette.b600
                        ]
                    , Ui.Attr.whenFocused
                        [ Ui.Attr.backgroundColor Ui.Palette.b500
                        , Ui.Attr.outline.px2 Ui.Palette.b200
                        ]
                    ]

                Secondary ->
                    [ Ui.Attr.fontColor Ui.Palette.n700
                    , Ui.Attr.backgroundColor Ui.Palette.light
                    , Ui.Attr.border.px1 Ui.Palette.n400
                    , Ui.Attr.whenDisabled
                        [ Ui.Attr.fontColor Ui.Palette.n500
                        , Ui.Attr.border.px1 Ui.Palette.n300
                        ]
                    , Ui.Attr.whenHovered
                        [ Ui.Attr.fontColor Ui.Palette.n800
                        , Ui.Attr.border.px1 Ui.Palette.n600
                        ]
                    , Ui.Attr.whenPressed
                        [ Ui.Attr.fontColor Ui.Palette.n800
                        , Ui.Attr.border.px1 Ui.Palette.n500
                        , Ui.Attr.backgroundColor Ui.Palette.n100
                        ]
                    , Ui.Attr.whenFocused
                        [ Ui.Attr.fontColor Ui.Palette.n800
                        , Ui.Attr.border.px1 Ui.Palette.n500
                        , Ui.Attr.outline.px2 Ui.Palette.b200
                        ]
                    ]

                Minimal ->
                    [ Ui.Attr.fontColor Ui.Palette.n700
                    , Ui.Attr.backgroundColor Ui.Palette.light
                    , Ui.Attr.whenDisabled
                        [ Ui.Attr.fontColor Ui.Palette.n500
                        , Ui.Attr.border.px1 Ui.Palette.n300
                        ]
                    , Ui.Attr.whenHovered
                        [ Ui.Attr.fontColor Ui.Palette.n800
                        , Ui.Attr.backgroundColor Ui.Palette.n100
                        ]
                    , Ui.Attr.whenPressed
                        [ Ui.Attr.fontColor Ui.Palette.n800
                        , Ui.Attr.backgroundColor Ui.Palette.n200
                        ]
                    , Ui.Attr.whenFocused
                        [ Ui.Attr.fontColor Ui.Palette.n800
                        , Ui.Attr.backgroundColor Ui.Palette.n50
                        , Ui.Attr.outline.px2 Ui.Palette.b200
                        ]
                    ]

                Error ->
                    [ Ui.Attr.fontColor Ui.Palette.light
                    , Ui.Attr.backgroundColor Ui.Palette.r400
                    , Ui.Attr.whenDisabled
                        [ Ui.Attr.backgroundColor Ui.Palette.r100
                        ]
                    , Ui.Attr.whenHovered
                        [ Ui.Attr.backgroundColor Ui.Palette.r500
                        ]
                    , Ui.Attr.whenPressed
                        [ Ui.Attr.backgroundColor Ui.Palette.r600
                        ]
                    , Ui.Attr.whenFocused
                        [ Ui.Attr.backgroundColor Ui.Palette.r500
                        , Ui.Attr.outline.px2 Ui.Palette.r200
                        ]
                    ]

        iconColor : Ui.Palette.Color
        iconColor =
            case settings.style of
                Primary ->
                    Ui.Palette.light

                Secondary ->
                    Ui.Palette.n600

                Minimal ->
                    Ui.Palette.n600

                Error ->
                    Ui.Palette.light

        viewLabel : Ui.Html msg
        viewLabel =
            Ui.Typography.p200 [ Ui.Attr.inherit.fontColor ] label

        viewIcon : Ui.Icon.Icon -> Ui.Html msg
        viewIcon icon =
            Ui.el [ Ui.Attr.fontColor iconColor ] (Ui.icon icon)

        content : Ui.Html msg
        content =
            case settings.icon of
                Just (Left icon) ->
                    Ui.row [ Ui.Attr.gap.px8, Ui.Attr.align.center ]
                        [ viewIcon icon
                        , viewLabel
                        ]

                Just (Right icon) ->
                    Ui.row [ Ui.Attr.gap.px8, Ui.Attr.align.center ]
                        [ viewLabel
                        , viewIcon icon
                        ]

                Nothing ->
                    viewLabel
    in
    Ui.clickable
        (commonAttrs ++ styleAttrs)
        content



-- OPTIONS


type Option msg
    = WithStyle ButtonStyle
    | WithIcon IconInfo


type ButtonStyle
    = Primary
    | Secondary
    | Minimal
    | Error


type IconInfo
    = Left Ui.Icon.Icon
    | Right Ui.Icon.Icon


primary : Option msg
primary =
    WithStyle Primary


secondary : Option msg
secondary =
    WithStyle Secondary


minimal : Option msg
minimal =
    WithStyle Minimal


error : Option msg
error =
    WithStyle Error


iconLeft : Ui.Icon.Icon -> Option msg
iconLeft icon =
    WithIcon (Left icon)


iconRight : Ui.Icon.Icon -> Option msg
iconRight icon =
    WithIcon (Right icon)



-- SETTINGS


type alias Settings =
    { style : ButtonStyle
    , icon : Maybe IconInfo
    }


defaultSettings : Settings
defaultSettings =
    { style = Primary
    , icon = Nothing
    }


fromOptionsToSettings : List (Option msg) -> Settings
fromOptionsToSettings options =
    List.foldl
        (\option settings ->
            case option of
                WithStyle style ->
                    { settings | style = style }

                WithIcon iconInfo ->
                    { settings | icon = Just iconInfo }
        )
        defaultSettings
        options
