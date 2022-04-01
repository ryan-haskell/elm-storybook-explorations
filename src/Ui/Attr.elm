module Ui.Attr exposing
    ( Attribute, toAttributes
    , none, list
    , typography, textAlign
    , fontColor, backgroundColor
    , border, radius
    , width, height
    , gap, align
    , pad, padXY
    , padTop, padLeft, padRight, padBottom
    , elevation
    , transition
    , whenHovered, whenDisabled, whenFocused, whenActive
    , cursor, outline
    )

{-|

@docs Attribute, toAttributes
@docs none, list
@docs typography, textAlign
@docs fontColor, backgroundColor
@docs border, radius
@docs width, height

@docs gap, align
@docs pad, padXY
@docs padTop, padLeft, padRight, padBottom

@docs elevation

@docs transition


## Interaction

@docs whenHovered, whenDisabled, whenFocused, whenActive
@docs cursor, outline

-}

import Css
import Html.Styled
import Html.Styled.Attributes
import Ui.Palette


type Attribute msg
    = Styles (List Css.Style)
    | Class String
    | Batch (List (Attribute msg))


toAttributes : Attribute msg -> List (Html.Styled.Attribute msg)
toAttributes attr =
    case attr of
        Styles css ->
            [ Html.Styled.Attributes.css css ]

        Class name ->
            [ Html.Styled.Attributes.class name ]

        Batch items ->
            List.concatMap toAttributes items



-- BASICS


none : Attribute msg
none =
    Styles []


list : List (Attribute msg) -> Attribute msg
list attrs =
    Batch attrs


fontColor : Ui.Palette.Color -> Attribute msg
fontColor color =
    Styles [ Css.color color ]


backgroundColor : Ui.Palette.Color -> Attribute msg
backgroundColor color =
    Styles [ Css.backgroundColor color ]


width :
    { px80 : Attribute msg
    }
width =
    { px80 = fromPixels Css.width 80
    }


height :
    { px80 : Attribute msg
    }
height =
    { px80 = fromPixels Css.height 80
    }


border :
    { px1 : Ui.Palette.Color -> Attribute msg
    }
border =
    { px1 = toBorder 1
    }


radius :
    { px4 : Attribute msg
    , px8 : Attribute msg
    }
radius =
    { px4 = fromPixels Css.borderRadius 4
    , px8 = fromPixels Css.borderRadius 8
    }


gap :
    { px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    , px40 : Attribute msg
    }
gap =
    { px4 = toGap 4
    , px8 = toGap 8
    , px16 = toGap 16
    , px40 = toGap 40
    }


align :
    { center : Attribute msg
    , centerX : Attribute msg
    , centerY : Attribute msg
    , top : Attribute msg
    , left : Attribute msg
    , bottom : Attribute msg
    , right : Attribute msg
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
    }



-- TYPOGRAPHY


textAlign : { center : Attribute msg }
textAlign =
    { center = Styles [ Css.textAlign Css.center ]
    }


typography :
    { fontSize : Float
    , lineHeight : Float
    , weight : Int
    , families : List String
    }
    -> Attribute msg
typography options =
    Styles
        [ Css.fontSize (Css.px options.fontSize)
        , Css.lineHeight (Css.px options.lineHeight)
        , Css.fontWeight (Css.int options.weight)
        , Css.fontFamilies options.families
        ]


transition : Int -> List String -> Attribute msg
transition durationInMs properties =
    Styles
        [ Css.property "transition"
            (properties
                |> List.map
                    (\name ->
                        "{{name}} {{duration}}ms ease-in-out"
                            |> String.replace "{{name}}" name
                            |> String.replace "{{duration}}" (String.fromInt durationInMs)
                    )
                |> String.join ", "
            )
        ]



-- INTERACTION STATES


outline : { none : Attribute msg }
outline =
    { none = Styles [ Css.outline Css.none ]
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


whenDisabled : List (Attribute msg) -> Attribute msg
whenDisabled attrs =
    Styles [ Css.disabled (keepOnlyCssStyles attrs) ]


whenFocused : List (Attribute msg) -> Attribute msg
whenFocused attrs =
    Styles
        [ Css.focus (keepOnlyCssStyles attrs)
        , Css.hover [ Css.focus (keepOnlyCssStyles attrs) ]
        ]


whenActive : List (Attribute msg) -> Attribute msg
whenActive attrs =
    Styles
        [ Css.active (keepOnlyCssStyles attrs)
        , Css.hover [ Css.active (keepOnlyCssStyles attrs) ]
        ]



-- PADDING


pad :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    , px40 : Attribute msg
    }
pad =
    toPadding "padding"


padLeft :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    , px40 : Attribute msg
    }
padLeft =
    toPadding "padding-left"


padRight :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    , px40 : Attribute msg
    }
padRight =
    toPadding "padding-right"


padTop :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    , px40 : Attribute msg
    }
padTop =
    toPadding "padding-top"


padBottom :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    , px40 : Attribute msg
    }
padBottom =
    toPadding "padding-bottom"


padXY :
    { zero :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        , px40 : Attribute msg
        }
    , px4 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        , px40 : Attribute msg
        }
    , px8 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        , px40 : Attribute msg
        }
    , px16 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        , px40 : Attribute msg
        }
    , px40 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        , px40 : Attribute msg
        }
    }
padXY =
    { zero = toPadXY "0"
    , px4 = toPadXY "4px"
    , px8 = toPadXY "8px"
    , px16 = toPadXY "16px"
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


toPadding :
    String
    ->
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        , px40 : Attribute msg
        }
toPadding propertyName =
    { zero = Styles [ Css.property propertyName "0" ]
    , px4 = Styles [ Css.property propertyName "4px" ]
    , px8 = Styles [ Css.property propertyName "8px" ]
    , px16 = Styles [ Css.property propertyName "16px" ]
    , px40 = Styles [ Css.property propertyName "40px" ]
    }


toPadXY :
    String
    ->
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        , px40 : Attribute msg
        }
toPadXY xValue =
    { zero = Styles [ Css.property "padding" ("0 " ++ xValue) ]
    , px4 = Styles [ Css.property "padding" ("4px " ++ xValue) ]
    , px8 = Styles [ Css.property "padding" ("8px " ++ xValue) ]
    , px16 = Styles [ Css.property "padding" ("16px " ++ xValue) ]
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

                Batch items ->
                    List.concatMap toCssStyles items
    in
    attrs
        |> List.concatMap toCssStyles
