module Ui.Card exposing
    ( view
    , Option
    , alwaysEnabled, alwaysDisabled, alwaysFocused, alwaysHovered
    )

{-|

@docs view

@docs Option


### Used by Storybook

@docs alwaysEnabled, alwaysDisabled, alwaysFocused, alwaysHovered

-}

import Ui
import Ui.Attr
import Ui.Palette
import Ui.Transition



-- OPTIONS


type Option msg
    = AlwaysEnabled
    | AlwaysDisabled
    | AlwaysHovered
    | AlwaysFocused


alwaysEnabled : Option msg
alwaysEnabled =
    AlwaysEnabled


alwaysDisabled : Option msg
alwaysDisabled =
    AlwaysDisabled


alwaysHovered : Option msg
alwaysHovered =
    AlwaysHovered


alwaysFocused : Option msg
alwaysFocused =
    AlwaysFocused



-- VIEW A CARD


view : List (Option msg) -> Ui.Html msg -> Ui.Html msg
view options content =
    let
        enabledAttributes : List (Ui.Attribute msg)
        enabledAttributes =
            [ Ui.Attr.outline.none
            , Ui.Attr.backgroundColor Ui.Palette.light
            , Ui.Attr.border.px1 Ui.Palette.n400
            ]

        hoveredAttributes : List (Ui.Attribute msg)
        hoveredAttributes =
            [ Ui.Attr.outline.none
            , Ui.Attr.backgroundColor Ui.Palette.light
            , Ui.Attr.border.px1 Ui.Palette.n400
            , Ui.Attr.elevation.level1
            ]

        focusedAttributes : List (Ui.Attribute msg)
        focusedAttributes =
            [ Ui.Attr.outline.none
            , Ui.Attr.elevation.level1
            , Ui.Attr.border.px1 Ui.Palette.b400
            , Ui.Attr.backgroundColor Ui.Palette.n50
            ]

        pressedAttributes : List (Ui.Attribute msg)
        pressedAttributes =
            [ Ui.Attr.outline.none
            , Ui.Attr.elevation.level1
            , Ui.Attr.border.px1 Ui.Palette.b400
            , Ui.Attr.backgroundColor Ui.Palette.b50
            ]

        disabledAttributes : List (Ui.Attribute msg)
        disabledAttributes =
            [ Ui.Attr.outline.none
            , Ui.Attr.backgroundColor Ui.Palette.n50
            , Ui.Attr.cursor.disabled
            ]

        settings : Settings
        settings =
            fromOptionsToSettings options
    in
    Ui.clickable
        [ Ui.Attr.cursor.pointer
        , Ui.Attr.pad.px40
        , Ui.Attr.radius.px8
        , case settings.state of
            Normal ->
                Ui.Attr.list
                    [ Ui.Attr.list enabledAttributes
                    , Ui.Attr.transition.ms100
                        [ Ui.Transition.elevation
                        , Ui.Transition.background
                        , Ui.Transition.borderColor
                        ]
                    , Ui.Attr.whenHovered hoveredAttributes
                    , Ui.Attr.whenDisabled disabledAttributes
                    , Ui.Attr.whenFocused focusedAttributes
                    , Ui.Attr.whenPressed pressedAttributes
                    ]

            ForceEnabled ->
                Ui.Attr.list enabledAttributes

            ForceHovered ->
                Ui.Attr.list hoveredAttributes

            ForceDisabled ->
                Ui.Attr.list disabledAttributes

            ForceFocused ->
                Ui.Attr.list focusedAttributes
        ]
        content



-- INTERNALS


type alias Settings =
    { state : State
    }


defaultSettings : Settings
defaultSettings =
    { state = Normal
    }


type State
    = Normal
    | ForceEnabled
    | ForceHovered
    | ForceDisabled
    | ForceFocused


fromOptionsToSettings : List (Option msg) -> Settings
fromOptionsToSettings options =
    List.foldl
        (\option settings ->
            case option of
                AlwaysEnabled ->
                    { settings | state = ForceEnabled }

                AlwaysHovered ->
                    { settings | state = ForceHovered }

                AlwaysDisabled ->
                    { settings | state = ForceDisabled }

                AlwaysFocused ->
                    { settings | state = ForceFocused }
        )
        defaultSettings
        options
