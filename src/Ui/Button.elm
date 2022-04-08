module Ui.Button exposing
    ( view, viewIconOnly
    , Option
    , primary, secondary, minimal, error
    , iconLeft, iconRight
    )

{-|

@docs view, viewIconOnly

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
    viewWith options (Label label)


viewIconOnly : List (Option msg) -> Ui.Icon.Icon -> Ui.Html msg
viewIconOnly options icon =
    viewWith options (IconOnly icon)



-- COMMON VIEW HELPER


type Content
    = Label String
    | IconOnly Ui.Icon.Icon


viewWith : List (Option msg) -> Content -> Ui.Html msg
viewWith options content =
    let
        settings : Settings
        settings =
            fromOptionsToSettings options

        commonAttributes : List (Ui.Attribute msg)
        commonAttributes =
            [ Ui.Attr.ref.button
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

        contentAttributes : List (Ui.Attribute msg)
        contentAttributes =
            case content of
                Label _ ->
                    [ Ui.Attr.padXY.px16.px8
                    ]

                IconOnly _ ->
                    [ Ui.Attr.width.px32
                    , Ui.Attr.height.px32
                    , Ui.Attr.align.center
                    ]

        buttonStyleAttributes : List (Ui.Attribute msg)
        buttonStyleAttributes =
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

        viewLabel : String -> Ui.Html msg
        viewLabel label =
            Ui.Typography.p200
                [ Ui.Attr.inherit.fontColor
                , Ui.Attr.transition.ms100 [ Ui.Transition.fontColor ]
                ]
                label

        viewIcon : Ui.Icon.Icon -> Ui.Html msg
        viewIcon icon =
            Ui.el
                [ Ui.Attr.fontColor iconColor

                -- This "ref" makes it so "secondary" and "minimal" icons
                -- change when the ref.button is hovered/pressed/focused
                , Ui.Attr.ref.icon
                , Ui.Attr.transition.ms100 [ Ui.Transition.fontColor ]
                ]
                (Ui.icon.px12 icon)

        viewButtonContent : Ui.Html msg
        viewButtonContent =
            case ( content, settings.icon ) of
                ( Label label, Just (Left icon) ) ->
                    Ui.row [ Ui.Attr.gap.px8, Ui.Attr.align.center ]
                        [ viewIcon icon
                        , viewLabel label
                        ]

                ( Label label, Just (Right icon) ) ->
                    Ui.row [ Ui.Attr.gap.px8, Ui.Attr.align.center ]
                        [ viewLabel label
                        , viewIcon icon
                        ]

                ( Label label, Nothing ) ->
                    viewLabel label

                ( IconOnly icon, _ ) ->
                    viewIcon icon
    in
    Ui.clickable
        (commonAttributes ++ contentAttributes ++ buttonStyleAttributes)
        viewButtonContent



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
    List.foldl updateSettings defaultSettings options


updateSettings : Option msg -> Settings -> Settings
updateSettings option settings =
    case option of
        WithStyle style ->
            { settings | style = style }

        WithIcon iconInfo ->
            { settings | icon = Just iconInfo }
