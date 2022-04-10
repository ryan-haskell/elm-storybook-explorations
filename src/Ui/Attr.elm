module Ui.Attr exposing
    ( Attribute, toAttributes
    , none, list, map
    , Weight(..), Family(..), typography, textAlign
    , fontColor, backgroundColor
    , border, radius
    , width, height
    , gap, align
    , pad, padXY
    , padTop, padLeft, padRight, padBottom
    , elevation
    , transition
    , whenHovered, whenDisabled, whenFocused, whenPressed
    , cursor, outline
    , inherit, wrap, ref
    , isDisabled
    , pointerEventsNone
    , relative, absolute
    , z1, z2
    , onKeyPressed, id
    )

{-|

@docs Attribute, toAttributes
@docs none, list, map
@docs Weight, Family, typography, textAlign
@docs fontColor, backgroundColor
@docs border, radius
@docs width, height

@docs gap, align
@docs pad, padXY
@docs padTop, padLeft, padRight, padBottom

@docs elevation

@docs transition


## Interaction

@docs whenHovered, whenDisabled, whenFocused, whenPressed
@docs cursor, outline

@docs inherit, wrap, ref
@docs isDisabled
@docs pointerEventsNone


## Layers

@docs relative, absolute
@docs z1, z2


## Events

@docs onKeyPressed, id

-}

import Css
import Dict exposing (Dict)
import Html.Styled
import Html.Styled.Attributes
import Html.Styled.Events
import Json.Decode
import Ui.Palette
import Ui.Transition


type Attribute msg
    = Styles (List Css.Style)
    | Id String
    | Class String
    | Ref String
    | IsDisabled Bool
    | KeyDown String msg
    | Batch (List (Attribute msg))


toAttributes : List (Attribute msg) -> List (Html.Styled.Attribute msg)
toAttributes attrs =
    let
        { attributes, keyDownEvents } =
            toBatchAttributes attrs
    in
    keyDownHandler keyDownEvents :: attributes


toBatchAttributes :
    List (Attribute msg)
    ->
        { attributes : List (Html.Styled.Attribute msg)
        , keyDownEvents : Dict String msg
        }
toBatchAttributes attrs =
    List.foldl
        (\attr data ->
            let
                { attributes, keyDownEvents } =
                    toAttributesInternal attr data.keyDownEvents
            in
            { attributes = data.attributes ++ attributes
            , keyDownEvents = keyDownEvents
            }
        )
        { attributes = []
        , keyDownEvents = Dict.empty
        }
        attrs


toAttributesInternal :
    Attribute msg
    -> Dict String msg
    ->
        { attributes : List (Html.Styled.Attribute msg)
        , keyDownEvents : Dict String msg
        }
toAttributesInternal attr keyDownEvents =
    case attr of
        Styles css ->
            { attributes = [ Html.Styled.Attributes.css css ]
            , keyDownEvents = keyDownEvents
            }

        Class name ->
            { attributes = [ Html.Styled.Attributes.class name ]
            , keyDownEvents = keyDownEvents
            }

        Id name ->
            { attributes = [ Html.Styled.Attributes.id name ]
            , keyDownEvents = keyDownEvents
            }

        Ref name ->
            { attributes = [ Html.Styled.Attributes.attribute "ref" name ]
            , keyDownEvents = keyDownEvents
            }

        IsDisabled bool ->
            { attributes = [ Html.Styled.Attributes.disabled bool ]
            , keyDownEvents = keyDownEvents
            }

        KeyDown code msg ->
            { attributes = []
            , keyDownEvents = Dict.insert code msg keyDownEvents
            }

        Batch items ->
            toBatchAttributes items


keyDownHandler : Dict String msg -> Html.Styled.Attribute msg
keyDownHandler keyDownEvents =
    Html.Styled.Events.on "keydown" (toKeyDownDecoder keyDownEvents)



-- BASICS


none : Attribute msg
none =
    Styles []


list : List (Attribute msg) -> Attribute msg
list attrs =
    Batch attrs


id : String -> Attribute msg
id str =
    Id str


map : (msg1 -> msg2) -> Attribute msg1 -> Attribute msg2
map fn attr =
    case attr of
        Styles list_ ->
            Styles list_

        Class string ->
            Class string

        Ref string ->
            Ref string

        Id string ->
            Id string

        IsDisabled bool ->
            IsDisabled bool

        KeyDown code msg1 ->
            KeyDown code (fn msg1)

        Batch attrs ->
            Batch (List.map (map fn) attrs)


isDisabled : Bool -> Attribute msg
isDisabled =
    IsDisabled



-- EVENTS


onKeyPressed :
    { spacebar : msg -> Attribute msg
    , arrowUp : msg -> Attribute msg
    , arrowDown : msg -> Attribute msg
    , escape : msg -> Attribute msg
    , enter : msg -> Attribute msg
    }
onKeyPressed =
    { spacebar = KeyDown "Space"
    , arrowUp = KeyDown "ArrowUp"
    , arrowDown = KeyDown "ArrowDown"
    , escape = KeyDown "Escape"
    , enter = KeyDown "Enter"
    }



-- STYLES


fontColor : Ui.Palette.Color -> Attribute msg
fontColor color =
    Styles [ Css.important (Css.color color) ]


inherit : { fontColor : Attribute msg }
inherit =
    { fontColor = Styles [ Css.important (Css.color Css.inherit) ]
    }


wrap : { none : Attribute msg }
wrap =
    { none = Styles [ Css.whiteSpace Css.noWrap ]
    }


backgroundColor : Ui.Palette.Color -> Attribute msg
backgroundColor color =
    Styles [ Css.backgroundColor color ]


pointerEventsNone : Attribute msg
pointerEventsNone =
    Styles [ Css.pointerEvents Css.none ]


relative : Attribute msg
relative =
    Styles [ Css.position Css.relative ]


absolute : Attribute msg
absolute =
    Class "elm-absolute"


z1 : Attribute msg
z1 =
    Styles [ Css.zIndex (Css.int 1) ]


z2 : Attribute msg
z2 =
    Styles [ Css.zIndex (Css.int 2) ]


width :
    { px16 : Attribute msg
    , px20 : Attribute msg
    , px32 : Attribute msg
    , px80 : Attribute msg
    , px216 : Attribute msg
    , fill : Attribute msg
    }
width =
    { px16 = fromPixels Css.width 16
    , px20 = fromPixels Css.width 20
    , px32 = fromPixels Css.width 32
    , px80 = fromPixels Css.width 80
    , px216 = fromPixels Css.width 216
    , fill = Styles [ Css.width (Css.pct 100) ]
    }


height :
    { px16 : Attribute msg
    , px20 : Attribute msg
    , px32 : Attribute msg
    , px80 : Attribute msg
    }
height =
    { px16 = fromPixels Css.height 16
    , px20 = fromPixels Css.height 20
    , px32 = fromPixels Css.height 32
    , px80 = fromPixels Css.height 80
    }


border :
    { none : Attribute msg
    , px1 : Ui.Palette.Color -> Attribute msg
    }
border =
    { none = Styles [ Css.border Css.zero ]
    , px1 = toBorder 1
    }


radius :
    { px4 : Attribute msg
    , px8 : Attribute msg
    , top : { px4 : Attribute msg }
    , bottom : { px4 : Attribute msg }
    , left : { px4 : Attribute msg }
    , right : { px4 : Attribute msg }
    }
radius =
    { px4 = toBorderRadius 4
    , px8 = toBorderRadius 8
    , top = { px4 = toBorderRadiusTop 4 }
    , bottom = { px4 = toBorderRadiusBottom 4 }
    , left = { px4 = toBorderRadiusLeft 4 }
    , right = { px4 = toBorderRadiusRight 4 }
    }


gap :
    { px1 : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px12 : Attribute msg
    , px16 : Attribute msg
    , px24 : Attribute msg
    , px40 : Attribute msg
    , fill : Attribute msg
    }
gap =
    { px1 = toGap 1
    , px4 = toGap 4
    , px8 = toGap 8
    , px12 = toGap 12
    , px16 = toGap 16
    , px24 = toGap 24
    , px40 = toGap 40
    , fill = Styles [ Css.justifyContent Css.spaceBetween ]
    }


align :
    { center : Attribute msg
    , centerX : Attribute msg
    , centerY : Attribute msg
    , top : Attribute msg
    , left : Attribute msg
    , bottom : Attribute msg
    , right : Attribute msg
    , above : Attribute msg
    , below : Attribute msg
    , toLeftOf : Attribute msg
    , toRightOf : Attribute msg
    }
align =
    { center =
        Styles
            [ Css.alignItems Css.center
            , Css.justifyContent Css.center
            ]
    , centerX = Class "elm-align-center-x"
    , centerY = Class "elm-align-center-y"
    , top = Class "elm-align-top"
    , left = Class "elm-align-left"
    , bottom = Class "elm-align-bottom"
    , right = Class "elm-align-right"

    -- Only work with `Ui.absolute`
    , above = Class "elm-align-above"
    , below = Class "elm-align-below"
    , toLeftOf = Class "elm-align-toLeftOf"
    , toRightOf = Class "elm-align-toRightOf"
    }



-- TYPOGRAPHY


textAlign : { center : Attribute msg }
textAlign =
    { center = Styles [ Css.textAlign Css.center ]
    }


type Weight
    = Regular
    | Medium
    | Semibold


type Family
    = SansSerif
    | Monospace


typography :
    { fontSize : Float
    , color : Ui.Palette.Color
    , lineHeight : Float
    , weight : Weight
    , families : Family
    }
    -> Attribute msg
typography options =
    Styles
        [ Css.fontSize (Css.px options.fontSize)
        , Css.color options.color
        , Css.lineHeight (Css.px options.lineHeight)
        , Css.fontWeight (Css.int (fromFontWeightToInt options.weight))
        , Css.fontFamilies (toFontFamilies options.families)
        ]


transition : { ms100 : List Ui.Transition.Property -> Attribute msg }
transition =
    { ms100 = toTransition 100
    }



-- INTERACTION STATES


outline :
    { none : Attribute msg
    , px2 : Ui.Palette.Color -> Attribute msg
    }
outline =
    { none = Styles [ Css.outline Css.none ]
    , px2 = toOutline 2
    }


cursor :
    { pointer : Attribute msg
    , disabled : Attribute msg
    }
cursor =
    { pointer = Styles [ Css.cursor Css.pointer ]
    , disabled = Styles [ Css.important (Css.cursor Css.notAllowed) ]
    }


whenHovered : List (Attribute msg) -> Attribute msg
whenHovered attrs =
    Styles [ Css.hover (keepOnlyCssStyles attrs) ]


whenFocused : List (Attribute msg) -> Attribute msg
whenFocused attrs =
    let
        styles : List Css.Style
        styles =
            keepOnlyCssStyles attrs
    in
    Styles
        [ Css.focus styles
        , Css.hover [ Css.focus styles ]
        ]


whenPressed : List (Attribute msg) -> Attribute msg
whenPressed attrs =
    let
        styles : List Css.Style
        styles =
            keepOnlyCssStyles attrs
    in
    Styles
        [ Css.active styles
        , Css.hover [ Css.active styles ]
        , Css.focus [ Css.active styles ]
        , Css.hover [ Css.focus [ Css.active styles ] ]
        ]


whenDisabled : List (Attribute msg) -> Attribute msg
whenDisabled attrs =
    let
        styles =
            keepOnlyCssStyles attrs
    in
    Styles
        [ Css.disabled styles
        , Css.disabled [ Css.hover styles ]
        , Css.disabled [ Css.focus styles ]
        , Css.disabled [ Css.active styles ]
        , Css.disabled [ Css.hover [ Css.active styles ] ]
        , Css.disabled [ Css.focus [ Css.active styles ] ]
        , Css.disabled [ Css.hover [ Css.focus [ Css.active styles ] ] ]
        ]



-- REFS


ref :
    { button : Attribute msg
    , icon : Attribute msg
    }
ref =
    { button = Ref "button"
    , icon = Ref "icon"
    }



-- PADDING


pad :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px6 : Attribute msg
    , px8 : Attribute msg
    , px12 : Attribute msg
    , px16 : Attribute msg
    , px32 : Attribute msg
    , px40 : Attribute msg
    }
pad =
    toPadding "padding"


padLeft :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px6 : Attribute msg
    , px8 : Attribute msg
    , px12 : Attribute msg
    , px16 : Attribute msg
    , px32 : Attribute msg
    , px40 : Attribute msg
    }
padLeft =
    toPadding "padding-left"


padRight :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px6 : Attribute msg
    , px8 : Attribute msg
    , px12 : Attribute msg
    , px16 : Attribute msg
    , px32 : Attribute msg
    , px40 : Attribute msg
    }
padRight =
    toPadding "padding-right"


padTop :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px6 : Attribute msg
    , px8 : Attribute msg
    , px12 : Attribute msg
    , px16 : Attribute msg
    , px32 : Attribute msg
    , px40 : Attribute msg
    }
padTop =
    toPadding "padding-top"


padBottom :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px6 : Attribute msg
    , px8 : Attribute msg
    , px12 : Attribute msg
    , px16 : Attribute msg
    , px32 : Attribute msg
    , px40 : Attribute msg
    }
padBottom =
    toPadding "padding-bottom"


padXY :
    { zero :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
    , px4 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
    , px6 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
    , px8 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
    , px12 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
    , px16 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
    , px32 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
    , px40 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
    }
padXY =
    { zero = toPadXY "0"
    , px4 = toPadXY "4px"
    , px6 = toPadXY "6px"
    , px8 = toPadXY "8px"
    , px12 = toPadXY "12px"
    , px16 = toPadXY "16px"
    , px32 = toPadXY "32px"
    , px40 = toPadXY "40px"
    }



-- ELEVATION


elevation :
    { level1 : Attribute msg
    , level2 : Attribute msg
    , level3 : Attribute msg
    }
elevation =
    { level1 =
        toElevation
            { x = 0
            , y = 4
            , blur = 8
            , spread = 0
            , rgb = ( 16, 24, 64 )
            , alpha = 0.08
            }
    , level2 =
        toElevation
            { x = 0
            , y = 4
            , blur = 8
            , spread = 0
            , rgb = ( 16, 24, 64 )
            , alpha = 0.16
            }
    , level3 =
        toElevation
            { x = 0
            , y = 12
            , blur = 40
            , spread = 0
            , rgb = ( 16, 24, 64 )
            , alpha = 0.24
            }
    }



-- INTERNALS


fromFontWeightToInt : Weight -> Int
fromFontWeightToInt weight =
    case weight of
        Regular ->
            400

        Medium ->
            500

        Semibold ->
            600


toFontFamilies : Family -> List String
toFontFamilies family =
    case family of
        SansSerif ->
            [ "Inter", "sans-serif" ]

        Monospace ->
            [ "Fira Code", "monospace" ]


toElevation :
    { rgb : ( Int, Int, Int )
    , x : Float
    , y : Float
    , blur : Float
    , spread : Float
    , alpha : Float
    }
    -> Attribute msg
toElevation options =
    let
        ( r, g, b ) =
            options.rgb
    in
    Styles
        [ Css.boxShadow5
            (Css.px options.x)
            (Css.px options.y)
            (Css.px options.blur)
            (Css.px options.spread)
            (Css.rgba r g b options.alpha)
        ]


toGap : Int -> Attribute msg
toGap px =
    Styles [ Css.property "gap" (String.fromInt px ++ "px") ]


fromPixels : (Css.Px -> Css.Style) -> Float -> Attribute msg
fromPixels toStyle px =
    Styles [ toStyle (Css.px px) ]


toBorder : Float -> Ui.Palette.Color -> Attribute msg
toBorder px color =
    Styles
        [ Css.borderStyle Css.solid
        , Css.borderColor color
        , Css.borderWidth (Css.px px)
        ]


toBorderRadius : Float -> Attribute msg
toBorderRadius px =
    Styles
        [ Css.borderRadius (Css.px px)
        ]


toBorderRadiusTop : Float -> Attribute msg
toBorderRadiusTop px =
    Styles
        [ Css.borderTopLeftRadius (Css.px px)
        , Css.borderTopRightRadius (Css.px px)
        ]


toBorderRadiusBottom : Float -> Attribute msg
toBorderRadiusBottom px =
    Styles
        [ Css.borderBottomLeftRadius (Css.px px)
        , Css.borderBottomRightRadius (Css.px px)
        ]


toBorderRadiusLeft : Float -> Attribute msg
toBorderRadiusLeft px =
    Styles
        [ Css.borderTopLeftRadius (Css.px px)
        , Css.borderBottomLeftRadius (Css.px px)
        ]


toBorderRadiusRight : Float -> Attribute msg
toBorderRadiusRight px =
    Styles
        [ Css.borderTopRightRadius (Css.px px)
        , Css.borderBottomRightRadius (Css.px px)
        ]


toPadding :
    String
    ->
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
toPadding propertyName =
    { zero = Styles [ Css.property propertyName "0" ]
    , px4 = Styles [ Css.property propertyName "4px" ]
    , px6 = Styles [ Css.property propertyName "6px" ]
    , px8 = Styles [ Css.property propertyName "8px" ]
    , px12 = Styles [ Css.property propertyName "12px" ]
    , px16 = Styles [ Css.property propertyName "16px" ]
    , px32 = Styles [ Css.property propertyName "32px" ]
    , px40 = Styles [ Css.property propertyName "40px" ]
    }


toPadXY :
    String
    ->
        { zero : Attribute msg
        , px4 : Attribute msg
        , px6 : Attribute msg
        , px8 : Attribute msg
        , px12 : Attribute msg
        , px16 : Attribute msg
        , px32 : Attribute msg
        , px40 : Attribute msg
        }
toPadXY xValue =
    { zero = Styles [ Css.property "padding" ("0 " ++ xValue) ]
    , px4 = Styles [ Css.property "padding" ("4px " ++ xValue) ]
    , px6 = Styles [ Css.property "padding" ("6px " ++ xValue) ]
    , px8 = Styles [ Css.property "padding" ("8px " ++ xValue) ]
    , px12 = Styles [ Css.property "padding" ("12px " ++ xValue) ]
    , px16 = Styles [ Css.property "padding" ("16px " ++ xValue) ]
    , px32 = Styles [ Css.property "padding" ("32px " ++ xValue) ]
    , px40 = Styles [ Css.property "padding" ("40px " ++ xValue) ]
    }


{-| When using Elm CSS's `hover`, `disabled`, or other pseudoclass functions,
we need to provide a `List Css.Style`. This means discarding any attributes
using things like `class`.

This can lead to confusion if devs try to change a UI element's alignment
on hover or disabled.

There's probably a typesafe way to prevent this from happening, but my brain is
too small to figure it out right now!

-}
keepOnlyCssStyles : List (Attribute msg) -> List Css.Style
keepOnlyCssStyles attrs =
    let
        toCssStyles : Attribute msg -> List Css.Style
        toCssStyles attr =
            case attr of
                Styles cssList ->
                    cssList

                Class _ ->
                    []

                Id _ ->
                    []

                Ref _ ->
                    []

                IsDisabled _ ->
                    []

                KeyDown _ _ ->
                    []

                Batch items ->
                    List.concatMap toCssStyles items
    in
    attrs
        |> List.concatMap toCssStyles


toTransition : Int -> List Ui.Transition.Property -> Attribute msg
toTransition durationInMs properties =
    Styles
        [ Css.property "transition"
            (properties
                |> List.map
                    (\name ->
                        "{{name}} {{duration}}ms ease-in-out"
                            |> String.replace "{{name}}" (Ui.Transition.toCssPropertyName name)
                            |> String.replace "{{duration}}" (String.fromInt durationInMs)
                    )
                |> String.join ", "
            )
        ]


toOutline : Float -> Ui.Palette.Color -> Attribute msg
toOutline px color =
    Styles
        [ Css.outlineOffset Css.zero
        , Css.outline3 (Css.px px) Css.solid color
        ]



-- KEY EVENTS


toKeyDownDecoder : Dict String msg -> Json.Decode.Decoder msg
toKeyDownDecoder events =
    Json.Decode.field "code" Json.Decode.string
        |> Json.Decode.andThen
            (\actualCode ->
                case Dict.get actualCode events of
                    Just msg ->
                        Json.Decode.succeed msg

                    Nothing ->
                        Json.Decode.fail ("No handler for" ++ actualCode)
            )
